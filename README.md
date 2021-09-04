# VariantPred
Predicting the effect of variants on splicing.

Based on the maximum entropy model, According to the ClinGen variant curation expert panel consensus guidelines for LDLR variant classification. We use [Mutalyzer v2.0.34](https://mutalyzer.nl/) and [MaxEntScan](http://hollywood.mit.edu/burgelab/maxent/Xmaxentscan_scoreseq.html) web services to predict the effect.

The test version is ready at https://variantpred.com. It only supports prediction of LDLR gene variants at this time.
The front-end is developed as a SPA using Vue3 and several Javascript dependencies.
The back-end is a R-plumber api project developed by Seyedmohammad Saadatagah.

Developed in [Atherosclerosis and Lipid Genomics Laboratory](https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview) under the supervision of [Dr. Iftikhar Kullo](https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview).
