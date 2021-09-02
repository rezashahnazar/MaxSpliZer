FROM rstudio/plumber

COPY . /maxent

RUN R -e "install.packages(c('dplyr','magrittr','data.table','stringr','stringi','httr','urltools'))"

CMD ["/maxent/mpl2.R"]