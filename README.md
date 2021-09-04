# VariantPred

** Predicting the effect of variants on splicing. **

Based on the maximum entropy model, According to the ClinGen variant curation expert panel consensus guidelines for LDLR variant classification. We use [Mutalyzer v2.0.34](https://mutalyzer.nl/) and [MaxEntScan](http://hollywood.mit.edu/burgelab/maxent/Xmaxentscan_scoreseq.html) web services to predict the effect.

______

## Development
The test version is ready at https://variantpred.com. (It only supports prediction of LDLR gene variants at this time.)
The front-end is developed by [Reza Shahnazar](https://ir.linkedin.com/in/reza-shahnazar-93537672) as a Single-Page-Application using Vue3 framework and some Javascript libraries.
The predictor back-end is an R-plumber api project developed by [Seyedmohammad Saadatagah](https://ir.linkedin.com/in/seyedmohammad-saadatagah-18b103122). It uses [Mutalyzer v2.0.34](https://mutalyzer.nl/) and [MaxEntScan](http://hollywood.mit.edu/burgelab/maxent/Xmaxentscan_scoreseq.html) web services as dependencies.

The project is developed in [Atherosclerosis and Lipid Genomics Laboratory](https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview) under the supervision of [Dr. Iftikhar Kullo](https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview).


______

## Deployment
The R project could be served in a docker container.
Nginx could be configured using the "front-end/nginx.conf" file to serve the production build of the Vue app from the "/app" directory on a linux server. Nginx would also redirect all HTTP requests with the endpoint of "/maxent" to the docker port.
