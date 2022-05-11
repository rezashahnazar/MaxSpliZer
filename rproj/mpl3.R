# setwd("/Users/m218518/Lab's Projects/14 LDL variant Call/MaxEntScan_web")
library(plumber)
library(dplyr)
library(magrittr)
library(data.table)
library(stringr)
library(stringi)
library(httr)
library(urltools)


#* @serializer unboxedJSON
#* @get /maxent
function(req){
  gene = str_to_upper(url_encode(req$args$gene))
  hgvs = paste0(str_to_lower(substring(url_encode(req$args$variant),1,1)),substring(url_encode(req$args$variant),2,nchar(url_encode(req$args$variant))))
  
  url_runmut = case_when(
    str_detect(gene,"LDLR") ~ "https://mutalyzer.nl/json/runMutalyzer?variant=NG_009060.1(LDLR):",
    str_detect(gene,"FBN") ~ "https://mutalyzer.nl/json/runMutalyzer?variant=NG_008805.2(FBN1):")
  mut_output <- content(GET(paste0(url_runmut,hgvs)), "parsed")
  war_msg <- ifelse(mut_output$errors == 0 & mut_output$warnings > 0,mut_output$messages[[1]]$message,"NA")
  
  if (mut_output$errors == 0 & (mut_output$warnings == 0 | (mut_output$warnings > 0 & !str_detect(war_msg,"is identical to the variant|No mutation given")))) {
    exons <- c(1:length(mut_output$exons))
    starts <- c()
    ends <- c()
    for (e in exons) {
      starts <- c(starts,mut_output$exons[[e]]$gStart)
      ends <- c(ends,mut_output$exons[[e]]$gStop)}
    
    NG_seq <- mut_output$original
    
    gene_position = as.numeric(str_extract(mut_output$rawVariants[[1]]$description, "\\d+"))
    mut = str_extract(mut_output$rawVariants[[1]]$description, "[a-z]+")
    
    if(str_detect(str_extract(mut_output$rawVariants[[1]]$description, "[a-z]+"), "delet")){
      REF = str_extract(string = strsplit(mut_output$rawVariants[[1]]$visualisation,"\n")[[1]][1], "(?<=(\\s))[ACTG]+(?=(\\s))")
      ALT = ""
    }else if(str_detect(str_extract(mut_output$rawVariants[[1]]$description, "[a-z]+"), "insert|duplica")){
      REF = str_extract(string = strsplit(mut_output$rawVariants[[1]]$visualisation,"\n")[[1]][1], "[ACTG](?=( -))")
      ALT = paste0(str_extract(string = strsplit(mut_output$rawVariants[[1]]$visualisation,"\n")[[1]][1], "[ACTG](?=( -))"),
                   str_extract(string = strsplit(mut_output$rawVariants[[1]]$visualisation,"\n")[[1]][2], "(?<=(\\s))[ACTG]+(?=(\\s))"))
    }else if(str_detect(str_extract(mut_output$rawVariants[[1]]$description, "[a-z]+"), "substit|delins")){
      REF = str_extract(string = strsplit(mut_output$rawVariants[[1]]$visualisation,"\n")[[1]][1], "(?<=(\\s))[ACTG]+(?=(\\s))")
      ALT = str_extract(string = strsplit(mut_output$rawVariants[[1]]$visualisation,"\n")[[1]][2], "(?<=(\\s))[ACTG]+(?=(\\s))")
    }
    
    don_part1 = "http://hollywood.mit.edu/cgi-bin/Xmaxentscan_scoreseq.pl?INPUTFILE=&SEQUENCE="
    don_part2 = "&MAXENT=1"
    
    acc_part1 = "http://hollywood.mit.edu/cgi-bin/Xmaxentscan_scoreseq_acc.pl?INPUTFILE=&SEQUENCE="
    acc_part2 = "&MAXENT=1"
    
    nchar_ref = nchar(REF);nchar_alt = nchar(ALT);ref_start = gene_position;ref_end = gene_position+(nchar_ref-1)
    
    for (a_ag in 2:length(starts)) {
      if (ref_start %in% c((starts[a_ag]-20):(starts[a_ag]+2)) | ref_end %in% c((starts[a_ag]-20):(starts[a_ag]+2))) {
        met_A_acc = 1
        break
      }else {
        met_A_acc = 0
      }
    };rm(a_ag)
    
    
    for (a_gt in 1:(length(ends)-1)) {
      if (ref_start %in% c((ends[a_gt]-2):(ends[a_gt]+6)) | ref_end %in% c((ends[a_gt]-2):(ends[a_gt]+6))) {
        met_A_don = 1
        break
      }else {
        met_A_don = 0
      }
    };rm(a_gt)
    
    for (b_ag in 1:length(exons)) {
      if (ref_start %in% c((starts[b_ag]):(ends[b_ag]-48)) | ref_end %in% c((starts[b_ag]):(ends[b_ag]-48))) {
        met_B_acc = 1
        break
      }else{
        met_B_acc = 0
      }
    };rm(b_ag)
    
    
    for (b_gt in 1:length(exons)) {
      if (ref_start %in% c((starts[b_gt]+48):(ends[b_gt])) | ref_end %in% c((starts[b_gt]+48):(ends[b_gt]))) {
        met_B_don = 1
        break
      }else{
        met_B_don = 0
      }
    };rm(b_gt)
    
    met_any <- ifelse((met_A_acc == 1 | met_A_don == 1 | met_B_acc == 1 | met_B_don == 1),1,0)
    
    if(met_any == 1) {
      
      for (ex in 1:length(exons)) {
        if (ref_start %in% c((starts[ex]-20):(ends[ex]+6)) | ref_end %in% c((starts[ex]-20):(ends[ex]+6))) {
          affecting_exon = ex
          exon_start = starts[ex]
          exon_end = ends[ex]
          break
        }else{affecting_exon = 0}
      };rm(ex)
      
      if (affecting_exon %in% c(2:(length(exons)-1))) {
        wt_acc_motif = substring(NG_seq,exon_start-20,exon_start+2)
        wt_acc_motif_score = as.numeric(str_extract(content(GET(paste0(acc_part1,wt_acc_motif,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
        wt_don_motif = substring(NG_seq,exon_end-2,exon_end+6)
        wt_don_motif_score = as.numeric(str_extract(content(GET(paste0(don_part1,wt_don_motif,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else if (affecting_exon == 1) {
        wt_acc_motif = ""
        wt_acc_motif_score = NA
        wt_don_motif = substring(NG_seq,exon_end-2,exon_end+6)
        wt_don_motif_score = as.numeric(str_extract(content(GET(paste0(don_part1,wt_don_motif,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else if (affecting_exon == length(exons)) {
        wt_acc_motif = substring(NG_seq,exon_start-20,exon_start+2)
        wt_acc_motif_score = as.numeric(str_extract(content(GET(paste0(acc_part1,wt_acc_motif,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
        wt_don_motif = ""
        wt_don_motif_score = NA
      }
      
      
      for (ex in 2:length(exons)) {
        if (any(seq(ref_start,ref_end) %in% c((starts[ex]-2):(starts[ex]-1)))) {
          cano_AG = 1
          break
        }else {cano_AG = 0}
      }; rm(ex)
      
      
      for (ex in 1:(length(exons)-1)) {
        if (any(seq(ref_start,ref_end) %in% c((ends[ex]+1):(ends[ex]+2)))) {
          cano_GT = 1
          break
        }else {cano_GT = 0}
      }; rm(ex)
      
      
      ### scenario A, acceptor site
      if(met_A_acc == 1){
        if(ref_end < exon_start) {
          A_alt_ag_motif = paste0(substring(NG_seq,(exon_start-20)-(nchar_ref - nchar_alt),ref_start-1),ALT,substring(NG_seq,ref_end+1,(exon_start+2)))
        }else if(ref_start == exon_start) {
          A_alt_ag_motif = paste0(substring(NG_seq,(exon_start-20),(exon_start-20)+19),substring((paste0(ALT,substring(NG_seq,ref_end+1,ref_end+3))),1,3)) 
        }else if(ref_start > exon_start) {
          A_alt_ag_motif = paste0(substring(NG_seq,(exon_start-20),(exon_start-20)+19),substring((paste0(substring(NG_seq,exon_start,ref_start-1),ALT,substring(NG_seq,ref_end+1,ref_end+3))),1,3)) 
        }
      }else if(met_A_acc == 0){
        A_alt_ag_motif <- NA
      }
      
      if(met_A_acc == 1) {
        A_alt_ag_motif_score = as.numeric(str_extract(content(GET(paste0(acc_part1,A_alt_ag_motif,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{A_alt_ag_motif_score = NA}
      
      
      ### scenario A, donor site
      if(met_A_don == 1){
        if(ref_start > exon_end) {
          A_alt_gt_motif = paste0(substring(NG_seq,(exon_end-2),ref_start-1),ALT,substring(NG_seq,ref_end+1,((exon_end+6) + (nchar_ref - nchar_alt))))
        }else if(ref_end <= exon_end) {
          up_stream = paste0(substring(NG_seq,ref_start-3,ref_start-1),ALT,substring(NG_seq,ref_end+1,exon_end))
          A_alt_gt_motif = paste0(substring(up_stream,nchar(up_stream)-2,nchar(up_stream)),substring(NG_seq,exon_end+1,exon_end+6))
        }
      }else if(met_A_don == 0){
        A_alt_gt_motif <- NA
      }
      
      if(met_A_don == 1) {
        A_alt_gt_motif_score = as.numeric(str_extract(content(GET(paste0(don_part1,A_alt_gt_motif,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{A_alt_gt_motif_score <- NA}
      
      
      B_ref_ag_seq = case_when(met_B_acc == 1 ~ substring(NG_seq,ref_start-1,ref_end+1))
      B_alt_ag_seq = case_when(met_B_acc == 1 ~ paste0(substring(NG_seq,ref_start-1,ref_start-1),ALT,substring(NG_seq,ref_end+1,ref_end+1)))
      new_AG = case_when(!is.na(B_ref_ag_seq) & !str_detect(B_ref_ag_seq,"AG") & str_detect(B_alt_ag_seq,"AG") ~ 1,
                         TRUE ~ 0)
      
      
      if(!is.na(new_AG) & new_AG == 1){
        alt_seq = B_alt_ag_seq
        alt_len = nchar(B_alt_ag_seq)
        ag_start = str_locate(B_alt_ag_seq,"AG")[[1]][1]
        ag_end = str_locate(B_alt_ag_seq,"AG")[[2]][1]
        genome_up = substring(NG_seq,ref_start-19,ref_start-2)
        alt_up = substring(alt_seq,1,ag_start-1)
        all_up = paste0(genome_up,alt_up)
        all_up_len = nchar(all_up)
        up_section = ifelse(ag_start == 1,genome_up,substring(all_up,all_up_len-17,all_up_len))
        alt_down = substring(alt_seq,ag_end+1,alt_len)
        genome_down = substring(NG_seq,ref_end+2,ref_end+4)
        all_down = paste0(alt_down,genome_down)
        down_section = substring(all_down,1,3)
        B_alt_ag_motif = paste0(up_section,"AG",down_section)
      }else{B_alt_ag_motif = NA}
      
      if(!is.na(new_AG) & new_AG == 1){rm(ag_end,ag_start,all_down,all_up_len,all_up,alt_down,alt_len,alt_seq,alt_up,down_section,genome_down,genome_up,up_section)}
      
      if(!is.na(B_alt_ag_motif)){
        B_alt_ag_motif_score = as.numeric(str_extract(content(GET(paste0(acc_part1,B_alt_ag_motif,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{B_alt_ag_motif_score = NA}
      
      B_ref_gt_seq = case_when(met_B_don == 1 ~ substring(NG_seq,ref_start-1,ref_end+1))
      B_alt_gt_seq = case_when(met_B_don == 1 ~ paste0(substring(NG_seq,ref_start-1,ref_start-1),ALT,substring(NG_seq,ref_end+1,ref_end+1)))
      new_GT = case_when(!is.na(B_ref_gt_seq) & !str_detect(B_ref_gt_seq,"GT") & str_detect(B_alt_gt_seq,"GT") ~ 1,
                         TRUE ~ 0)
      
      
      ### creating denove GT motif, simple approach
      if(!is.na(new_GT) & new_GT == 1){
        alt_seq = B_alt_gt_seq
        alt_len = nchar(B_alt_gt_seq)
        ag_start = str_locate(B_alt_gt_seq,"GT")[[1]][1]
        ag_end = str_locate(B_alt_gt_seq,"GT")[[2]][1]
        genome_up = substring(NG_seq,ref_start-4,ref_start-2)
        alt_up = substring(alt_seq,1,ag_start-1)
        all_up = paste0(genome_up,alt_up)
        all_up_len = nchar(all_up)
        up_section = ifelse(ag_start == 1,genome_up,substring(all_up,all_up_len-2,all_up_len))
        alt_down = substring(alt_seq,ag_end+1,alt_len)
        genome_down = substring(NG_seq,ref_end+2,ref_end+5)
        all_down = paste0(alt_down,genome_down)
        down_section = substring(all_down,1,4)
        B_alt_gt_motif = paste0(up_section,"GT",down_section)
      }else{B_alt_gt_motif = NA}
      
      if(!is.na(new_GT) & new_GT == 1){rm(ag_end,ag_start,all_down,all_up_len,all_up,alt_down,alt_len,alt_seq,alt_up,down_section,genome_down,genome_up,up_section)}
      
      if(!is.na(B_alt_gt_motif)){
        B_alt_gt_motif_score = as.numeric(str_extract(content(GET(paste0(don_part1,B_alt_gt_motif,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{B_alt_gt_motif_score = NA}
      
      
      ##scenario C
      ## modifying AG
      ### creating downstream sequence of variant --> ref_end + 1 up to max 19 or end_exon-48
      if (met_B_acc == 1) {
        C_down_stream_ag = paste0(substring(ALT,nchar_alt,nchar_alt),substring(NG_seq,ref_end+1,(ref_end+1+min(18,((exon_end-48)-(ref_end+1))))))
      }else {
        C_down_stream_ag <- NA}
      
      
      ### creating upstream sequence of variant --> ref_start -1 going backward for 5 Nt or up to exon start (if variant is so close to the exon start)
      if (met_B_acc == 1) {
        C_up_stream_ag = paste0(substring(NG_seq,max(ref_start-4,exon_start),ref_start-1),substring(ALT,1,1))
      }else {
        C_up_stream_ag <- NA
      }
      
      ### checking for AG in downstream and upstream
      C_AG_down = case_when(str_detect(C_down_stream_ag, "AG") ~ 1, TRUE ~ 0)
      C_AG_up = case_when(str_detect(C_up_stream_ag, "AG") ~ 1, TRUE ~ 0)
      
      
      ### creating 23 sequence for wt_cryptic and var_cryptic
      ### nearest AG in both upstream and downstream
      ### no need to check if it creates a new AG in scenario B because that would be the closest one
      if (!is.na(C_AG_down) & C_AG_down == 1 & ((!is.na(new_AG) & new_AG == 0) | is.na(new_AG))) {
        G = str_locate(C_down_stream_ag,"AG")[[2]][[1]]
        C_wt_acc_cryptic_down <- substring(NG_seq,(ref_end+(G-1))-19,(ref_end+(G-1))+3)
        first = substring(NG_seq,((ref_end+(G-1))-19)+(nchar_alt-nchar_ref),ref_start-1)
        last = substring(NG_seq,ref_end+1,(ref_end+(G-1))+3)
        all = paste0(first,ALT,last)
        C_var_acc_cryptic_down <- substring(all, nchar(all)-22, nchar(all))
      }else{
        C_wt_acc_cryptic_down <- NA
        C_var_acc_cryptic_down <- NA
      }
      
      if(!is.na(C_AG_down) & C_AG_down == 1 & ((!is.na(new_AG) & new_AG == 0) | is.na(new_AG))){
        rm(G,first,last,all)
        C_wt_acc_cryptic_down_score = as.numeric(str_extract(content(GET(paste0(acc_part1,C_wt_acc_cryptic_down,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
        C_var_acc_cryptic_down_score = as.numeric(str_extract(content(GET(paste0(acc_part1,C_var_acc_cryptic_down,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{
        C_wt_acc_cryptic_down_score = NA
        C_var_acc_cryptic_down_score = NA
      }
      
      
      if (!is.na(C_AG_up) & C_AG_up == 1 & ((!is.na(new_AG) & new_AG == 0) | is.na(new_AG))) {
        G = nchar(C_up_stream_ag) - stri_locate_last(str = C_up_stream_ag, regex = "AG")[[2]][1]
        C_wt_acc_cryptic_up <- substring(NG_seq,(ref_start-G)-19,((ref_start)-G)+3)
        first = substring(NG_seq,(ref_start-G)-19,ref_start-1)
        last = substring(NG_seq,ref_end+1,ref_end+3)
        C_var_acc_cryptic_up <- substring(paste0(first,ALT,last),1,23)
      }else{
        C_wt_acc_cryptic_up <- NA
        C_var_acc_cryptic_up <- NA
      }
      
      if(!is.na(C_AG_up) & C_AG_up == 1 & ((!is.na(new_AG) & new_AG == 0) | is.na(new_AG))) {
        rm(G,first,last)
        C_wt_acc_cryptic_up_score = as.numeric(str_extract(content(GET(paste0(acc_part1,C_wt_acc_cryptic_up,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
        C_var_acc_cryptic_up_score = as.numeric(str_extract(content(GET(paste0(acc_part1,C_var_acc_cryptic_up,acc_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{
        C_wt_acc_cryptic_up_score = NA
        C_var_acc_cryptic_up_score = NA
      }
      
      
      ##scenario C
      ## modifying GT
      ### creating downstream sequence of variant --> ref_end + 1 up to max 5 or end_exon
      if (met_B_don == 1) {
        C_down_stream_gt = paste0(substring(ALT,nchar_alt,nchar_alt),substring(NG_seq,ref_end+1,(ref_end+1+min(3,(exon_end-(ref_end+1))))))
      }else {
        C_down_stream_gt <- NA
      }
      
      ### creating upstream sequence of variant --> ref_start -1 going backward for 6 Nt or up to exon start+48
      if (met_B_don == 1) {
        C_up_stream_gt = paste0(substring(NG_seq,max(ref_start-5,exon_start+48),ref_start-1),substring(ALT,1,1))
      }else {
        C_up_stream_gt <- NA
      }
      
      ### checking for GT in downstream and upstream
      C_GT_down = case_when(str_detect(C_down_stream_gt, "GT") ~ 1, TRUE ~ 0)
      C_GT_up = case_when(str_detect(C_up_stream_gt, "GT") ~ 1, TRUE ~ 0)
      
      
      ### creating 9 sequence for wt_cryptic and var_cryptic
      ### nearest GT in both upstream and downstream
      ### no need to check if it creates a new GT in scenario B because that would be the closest one
      if (!is.na(C_GT_down) & C_GT_down == 1 & ((!is.na(new_GT) & new_GT == 0) | is.na(new_GT))) {
        G = str_locate(C_down_stream_gt,"GT")[[1]][[1]]
        C_wt_don_cryptic_down <- substring(NG_seq,(ref_end+(G-1))-3,(ref_end+(G-1))+5)
        first = substring(NG_seq,((ref_end+(G-1))-3)+(nchar_alt-nchar_ref),ref_start-1)
        last = substring(NG_seq,ref_end+1,(ref_end+(G-1))+5)
        C_var_don_cryptic_down <- paste0(first,ALT,last)
      }else{
        C_wt_don_cryptic_down <- NA
        C_var_don_cryptic_down <- NA
      }
      
      if(!is.na(C_GT_down) & C_GT_down == 1 & ((!is.na(new_GT) & new_GT == 0) | is.na(new_GT))) {
        rm(G,first,last)
        C_wt_don_cryptic_down_score = as.numeric(str_extract(content(GET(paste0(don_part1,C_wt_don_cryptic_down,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
        C_var_don_cryptic_down_score = as.numeric(str_extract(content(GET(paste0(don_part1,C_var_don_cryptic_down,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{
        C_wt_don_cryptic_down_score = NA
        C_var_don_cryptic_down_score = NA
      }
      
      
      if (!is.na(C_GT_up) & C_GT_up == 1 & ((!is.na(new_GT) & new_GT == 0) | is.na(new_GT))) {
        G = nchar(C_up_stream_gt) - stri_locate_last(str = C_up_stream_gt, regex = "GT")[[1]][1]
        C_wt_don_cryptic_up <- substring(NG_seq,(ref_start-G)-3,((ref_start)-G)+5)
        first = substring(NG_seq,(ref_start-G)-3,ref_start-1)
        last = substring(NG_seq,ref_end+1,ref_end+5)
        C_var_don_cryptic_up <- substring(paste0(first,ALT,last),1,9)
      }else{
        C_wt_don_cryptic_up <- NA
        C_var_don_cryptic_up <- NA
      }
      
      if(!is.na(C_GT_up) & C_GT_up == 1 & ((!is.na(new_GT) & new_GT == 0) | is.na(new_GT))) {
        rm(G,first,last)
        C_wt_don_cryptic_up_score = as.numeric(str_extract(content(GET(paste0(don_part1,C_wt_don_cryptic_up,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
        C_var_don_cryptic_up_score = as.numeric(str_extract(content(GET(paste0(don_part1,C_var_don_cryptic_up,don_part2)), "text"), "(?<=(MAXENT: )).?\\d{1,2}.\\d{1,2}"))
      }else{
        C_wt_don_cryptic_up_score = NA
        C_var_don_cryptic_up_score = NA
      }
      
      A_acc_ratio = case_when(met_A_acc == 1 ~ A_alt_ag_motif_score / wt_acc_motif_score)
      A_don_ratio = case_when(met_A_don == 1 ~ A_alt_gt_motif_score / wt_don_motif_score)
      B_acc_ratio = case_when(met_B_acc == 1 & !is.na(new_AG) & new_AG == 1 ~ B_alt_ag_motif_score / wt_acc_motif_score)
      B_don_ratio = case_when(met_B_don == 1 & !is.na(new_GT) & new_GT == 1 ~ B_alt_gt_motif_score / wt_don_motif_score)
      C_acc_down_ratio_1 = case_when(met_B_acc == 1 & !is.na(C_AG_down) & C_AG_down == 1 ~ C_var_acc_cryptic_down_score / C_wt_acc_cryptic_down_score)
      C_acc_down_ratio_2 = case_when(met_B_acc == 1 & !is.na(C_AG_down) & C_AG_down == 1 ~ C_var_acc_cryptic_down_score / wt_acc_motif_score)
      C_acc_up_ratio_1 = case_when(met_B_acc == 1 & !is.na(C_AG_up) & C_AG_up == 1 ~ C_var_acc_cryptic_up_score / C_wt_acc_cryptic_up_score)
      C_acc_up_ratio_2 = case_when(met_B_acc == 1 & !is.na(C_AG_up) & C_AG_up == 1 ~ C_var_acc_cryptic_up_score / wt_acc_motif_score)
      C_don_down_ratio_1 = case_when(met_B_don == 1 & !is.na(C_GT_down) & C_GT_down == 1 ~ C_var_don_cryptic_down_score / C_wt_don_cryptic_down_score)
      C_don_down_ratio_2 = case_when(met_B_don == 1 & !is.na(C_GT_down) & C_GT_down == 1 ~ C_var_don_cryptic_down_score / wt_don_motif_score)
      C_don_up_ratio_1 = case_when(met_B_don == 1 & !is.na(C_GT_up) & C_GT_up == 1 ~ C_var_don_cryptic_up_score / C_wt_don_cryptic_up_score)
      C_don_up_ratio_2 = case_when(met_B_don == 1 & !is.na(C_GT_up) & C_GT_up == 1 ~ C_var_don_cryptic_up_score / wt_don_motif_score)
      
      report <- "Report:"
      
      if(cano_AG == 1 | cano_GT == 1){
        report <- c(report,
                    paste0("WARNING: Variant involves the canonical AG/GT sites."))
      }
      
      if(met_A_acc == 1){
        report <- c(report,
                    paste0("Scenario A, Acceptor site: The variant is located at -20 to +3 bases of canonical acceptor splicing site of exon ",affecting_exon,"."),
                    paste0("Wild type canonical acceptor motif: ",wt_acc_motif,": ",wt_acc_motif_score),
                    paste0("Variant canonical acceptor motif: ",A_alt_ag_motif,": ",A_alt_ag_motif_score),
                    paste0("Var/Wt ratio = ",round(A_acc_ratio,2))
        )
      }else {report <- c(report,paste0("Scenario A, Acceptor site: The variant is not located at -20 to +3 bases of canonical acceptor splicing site of any exons."))}
      
      
      if(met_A_don == 1){
        report <- c(report,
                    paste0("Scenario A, Donor site: The variant is located at -3 to +6 bases of canonical donor splicing site of exon ",affecting_exon,"."),
                    paste0("Wild type canonical donor motif: ",wt_don_motif,": ",wt_don_motif_score),
                    paste0("Variant canonical donor motif: ",A_alt_gt_motif,": ",A_alt_gt_motif_score),
                    paste0("Var/Wt ratio = ",round(A_don_ratio,2))
        )
      }else {report <- c(report,paste0("Scenario A, Donor site: The variant is not located at -3 to +6 bases of canonical donor splicing site of any exons."))}
      
      
      if(met_B_acc == 0){
        report <- c(report,paste0("Scenario B, Acceptor site: The variant is out of range. No need to studying denovo AG site."))
      }else if(met_B_acc == 1 & new_AG == 0){
        report <- c(report,paste0("Scenario B, Acceptor site: The variant is located within the range but does not create denovo AG site."))
      }else if(met_B_acc == 1 & new_AG == 1){
        report <- c(report,
                    paste0("Scenario B, Acceptor site: Variant is located within the range and creates denovo AG site."),
                    paste0("Wild type canonical acceptor motif: ",wt_acc_motif,": ",wt_acc_motif_score),
                    paste0("Variant denovo acceptor motif: ",B_alt_ag_motif,": ",B_alt_ag_motif_score),
                    paste0("denovo Var/Wt ratio = ",round(B_acc_ratio,2))
        )
      }
      
      
      if(met_B_don == 0){
        report <- c(report,paste0("Scenario B, Donor site: The variant is out of range. No need to studying denovo GT site."))
      }else if(met_B_don == 1 & new_GT == 0){
        report <- c(report,paste0("Scenario B, Donor site: The variant is located within the range but does not create denovo GT site."))
      }else if(met_B_don == 1 & new_GT == 1){
        report <- c(report,
                    paste0("Scenario B, Donor site: The variant is located within the range and creates denovo GT site."),
                    paste0("Wild type canonical donor motif: ",wt_don_motif,": ",wt_don_motif_score),
                    paste0("Variant denovo donor motif: ",B_alt_gt_motif,": ",B_alt_gt_motif_score),
                    paste0("denovo Var/Wt ratio = ",round(B_don_ratio,2))
        )
      }
      
      
      if(met_B_acc == 0){
        report <- c(report,paste0("Scenario C, Acceptor site: The variant is out of range. No need to studying nearby AG site.")) 
      }else if(met_B_acc == 1 & new_AG == 1){
        report <- c(report,paste0("Scenario C, Acceptor site: The variant is within the range but creates a denovo AG. No need to studying nearby AG site."))
      }else if(met_B_acc == 1 & new_AG == 0 & C_AG_down == 0 & C_AG_up == 0){
        report <- c(report,paste0("Scenario C, Acceptor site: The variant is within the range and does not create a denovo AG. There is no AG in downstream (20 Nt) or upstream (3 Nt)."))
      }else if(met_B_acc == 1 & new_AG == 0 & C_AG_down == 1){
        report <- c(report,
                    paste0("Scenario C, Acceptor site: The variant is within the range and does not create a denovo AG. There is a AG site in downstream (20 Nt)."),
                    paste0("Wild type canonical acceptor motif: ",wt_acc_motif,": ",wt_acc_motif_score),
                    paste0("Wild type cryptic acceptor motif (downstream): ",C_wt_acc_cryptic_down,": ",C_wt_acc_cryptic_down_score),
                    paste0("Variant cryptic acceptor motif (downstream): ",C_var_acc_cryptic_down,": ",C_var_acc_cryptic_down_score),
                    paste0("Var cryptic/Wt cryptic = ",round(C_acc_down_ratio_1,2)),
                    paste0("Var cryptic/Wt canonical = ",round(C_acc_down_ratio_2,2))
        )
      }else if(met_B_acc == 1 & new_AG == 0 & C_AG_up == 1){
        report <- c(report,
                    paste0("Scenario C, Acceptor site: The variant is within the range and does not create a denovo AG. There is a AG site in upstream (3 Nt)."),
                    paste0("Wild type canonical acceptor motif: ",wt_acc_motif,": ",wt_acc_motif_score),
                    paste0("Wild type cryptic acceptor motif (upstream): ",C_wt_acc_cryptic_up,": ",C_wt_acc_cryptic_up_score),
                    paste0("Variant cryptic acceptor motif (upstream): ",C_var_acc_cryptic_up,": ",C_var_acc_cryptic_up_score),
                    paste0("Var cryptic/Wt cryptic = ",round(C_acc_up_ratio_1,2)),
                    paste0("Var cryptic/Wt canonical = ",round(C_acc_up_ratio_2,2))
        )
      }
      
      
      if(met_B_don == 0){
        report <- c(report,paste0("Scenario C, Donor site: The variant is out of range. No need to studying nearby GT site.")) 
      }else if(met_B_don == 1 & new_GT == 1){
        report <- c(report,paste0("Scenario C, Donor site: The variant is within the range but creates a denovo GT. No need to studying nearby GT site."))
      }else if(met_B_don == 1 & new_GT == 0 & C_GT_down == 0 & C_GT_up == 0){
        report <- c(report,paste0("Scenario C, Donor site: The variant is within the range and does not create a denovo GT. There is no GT in downstream (3 Nt) or upstream (6 Nt)."))
      }else if(met_B_don == 1 & new_GT == 0 & C_GT_down == 1){
        report <- c(report,
                    paste0("Scenario C, Donor site: The variant is within the range and does not create a denovo GT. There is a GT site in downstream (3 Nt)."),
                    paste0("Wild type canonical acceptor motif: ",wt_don_motif,": ",wt_don_motif_score),
                    paste0("Wild type cryptic acceptor motif (downstream): ",C_wt_don_cryptic_down,": ",C_wt_don_cryptic_down_score),
                    paste0("Variant cryptic acceptor motif (downstream): ",C_var_don_cryptic_down,": ",C_var_don_cryptic_down_score),
                    paste0("Var cryptic/Wt cryptic = ",round(C_don_down_ratio_1,2)),
                    paste0("Var cryptic/Wt canonical = ",round(C_don_down_ratio_2,2))
        )
      }else if(met_B_don == 1 & new_GT == 0 & C_GT_up == 1){
        report <- c(report,
                    paste0("Scenario C, Donor site: Variant is within the range and does not create a denovo GT. There is a GT site in upstream (6 Nt)."),
                    paste0("Wild type canonical acceptor motif: ",wt_don_motif,": ",wt_don_motif_score),
                    paste0("Wild type cryptic acceptor motif (upstream): ",C_wt_don_cryptic_up,": ",C_wt_don_cryptic_up_score),
                    paste0("Variant cryptic acceptor motif (upstream): ",C_var_don_cryptic_up,": ",C_var_don_cryptic_up_score),
                    paste0("Var cryptic/Wt cryptic = ",round(C_don_up_ratio_1,2)),
                    paste0("Var cryptic/Wt canonical = ",round(C_don_up_ratio_2,2))
        )
      }
      
      
      Final_interpretaion = ifelse(any(A_acc_ratio < 0.8 | A_don_ratio < 0.8 | B_acc_ratio > 0.9 | B_don_ratio > 0.9 |
                                         (C_acc_down_ratio_1 > 1.1 & C_acc_down_ratio_2 > 0.9) | (C_acc_up_ratio_1 > 1.1 & C_acc_up_ratio_2 > 0.9)|
                                         (C_don_down_ratio_1 > 1.1 & C_don_down_ratio_2 > 0.9) | (C_don_up_ratio_1 > 1.1 & C_don_up_ratio_2 > 0.9),na.rm = T),1,0)
      
      
      if(Final_interpretaion == 1){
        report <- c(report,
                    paste0("Interpretation: The variant affects splicing process."))
      }else {
        report <- c(report,
                    paste0("Interpretation: The variant does not affect splicing process."))
      }
      
      results = list(
        "rep_status" = 1,
        "summary" = mut_output$summary,
        "war_msg" = ifelse(mut_output$warnings == 0,"NA",mut_output$messages[[1]]$message),
        "ref_id" = mut_output$referenceId,
        "g_des" = mut_output$genomicDescription,
        "g_pos" = gene_position,
        "ref_allele" = REF,
        "alt_allele" = ALT,
        "aff_exon" =  affecting_exon,
        "aff_exon_start" = exon_start,
        "aff_exon_end" = exon_end,
        "cano_inv" = ifelse(cano_AG == 1 | cano_GT == 1,"WARNING: Variant alters the canonical splicing sites!","NA"),
        "wt_can_acc_motif" = wt_acc_motif,
        "wt_can_acc_motif_score" = wt_acc_motif_score,
        "wt_can_don_motif" = wt_don_motif,
        "wt_can_don_motif_score" = wt_don_motif_score,
        "met_a_acc" =  met_A_acc,
        "scen_a_var_acc_motif" =  A_alt_ag_motif,
        "scen_a_var_acc_motif_score" = A_alt_ag_motif_score,
        "scen_a_acc_ratio" =  A_acc_ratio,
        "met_a_don" =  met_A_don,
        "scen_a_var_don_motif" =  A_alt_gt_motif,
        "scen_a_var_don_motif_score" = A_alt_gt_motif_score,
        "scen_a_don_ratio" =  A_don_ratio,
        "met_b_acc" = met_B_acc,
        "new_ag" = new_AG,
        "scen_b_ref_ag_seq" = B_ref_ag_seq,
        "scen_b_alt_ag_seq" = B_alt_ag_seq,
        "scen_b_alt_ag_motif" = B_alt_ag_motif,
        "scen_b_alt_ag_motif_score" = B_alt_ag_motif_score,
        "scen_b_acc_ratio" = B_acc_ratio,
        "met_b_don" = met_B_don,
        "new_gt" = new_GT,
        "scen_b_ref_gt_seq" = B_ref_gt_seq,
        "scen_b_alt_gt_seq" = B_alt_gt_seq,
        "scen_b_alt_gt_motif" = B_alt_gt_motif,
        "scen_b_alt_gt_motif_score" = B_alt_gt_motif_score,
        "scen_b_don_ratio" = B_don_ratio,
        "scen_c_ag_up" = C_AG_up,
        "scen_c_wt_acc_cryp_up_motif" = C_wt_acc_cryptic_up,
        "scen_c_wt_acc_cryp_up_motif_score" = C_wt_acc_cryptic_up_score,
        "scen_c_var_acc_cryp_up_motif" = C_var_acc_cryptic_up,
        "scen_c_var_acc_cryp_up_motif_score" = C_var_acc_cryptic_up_score,
        "scen_c_acc_up_ratio1" = C_acc_up_ratio_1,
        "scen_c_acc_up_ratio2" = C_acc_up_ratio_2,
        "scen_c_ag_down" = C_AG_down,
        "scen_c_wt_acc_cryp_down_motif" = C_wt_acc_cryptic_down,
        "scen_c_wt_acc_cryp_down_motif_score" = C_wt_acc_cryptic_down_score,
        "scen_c_var_acc_cryp_down_motif" = C_var_acc_cryptic_down,
        "scen_c_var_acc_cryp_down_motif_score" = C_var_acc_cryptic_down_score,
        "scen_c_acc_down_ratio1" = C_acc_down_ratio_1,
        "scen_c_acc_down_ratio2" = C_acc_down_ratio_2,
        "scen_c_gt_up" = C_GT_up,
        "scen_c_wt_don_cryp_up_motif" = C_wt_don_cryptic_up,
        "scen_c_wt_don_cryp_up_motif_score" = C_wt_don_cryptic_up_score,
        "scen_c_var_don_cryp_up_motif" = C_var_don_cryptic_up,
        "scen_c_var_don_cryp_up_motif_score" = C_var_don_cryptic_up_score,
        "scen_c_don_up_ratio1" = C_don_up_ratio_1,
        "scen_c_don_up_ratio2" = C_don_up_ratio_2,
        "scen_c_gt_down" = C_GT_down,
        "scen_c_wt_don_cryp_down_motif" = C_wt_don_cryptic_down,
        "scen_c_wt_don_cryp_down_motif_score" = C_wt_don_cryptic_down_score,
        "scen_c_var_don_cryp_down_motif" = C_var_don_cryptic_down,
        "scen_c_var_don_cryp_down_motif_score" = C_var_don_cryptic_down_score,
        "scen_c_don_down_ratio1" = C_don_down_ratio_1,
        "scen_c_don_down_ratio2" = C_don_down_ratio_2,
        "intp" = ifelse(Final_interpretaion == 1, "The variant affects splicing process.", "The variant does not affect splicing process."),
        "Report" = report
      )
      return(results)
    }else if(met_any == 0){
      results = list(
        "rep_status" = 2,
        "summary" = mut_output$summary,
        "war_msg" = ifelse(mut_output$warnings == 0,"NA",mut_output$messages[[1]]$message),
        "ref_id" = mut_output$referenceId,
        "g_des" = mut_output$genomicDescription,
        "g_pos" = gene_position,
        "ref_allele" = REF,
        "alt_allele" = ALT,
        "note" = "The variant is located out of range for all scenarios.",
        "intp" = "The variant does not affect splicing process"
      )
      return(results) 
    }
    
    
  }else if (mut_output$errors > 0 | (mut_output$warnings > 0 & str_detect(mut_output$messages[[1]]$message,"is identical to the variant|No mutation given"))) {
    results = list(
      "rep_status" = 3,
      "summary" = mut_output$summary,
      "war_msg" = mut_output$messages[[1]]$message)
    return(results)
  }
plumber::forward()
}

#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}





