# MaxSpliZer

**Predicting the effect of variants on splicing.**

Based on the maximum entropy model, According to the ClinGen variant curation expert panel consensus guidelines for LDLR variant classification. We use [Mutalyzer v2.0.34](https://mutalyzer.nl/) and [MaxEntScan](http://hollywood.mit.edu/burgelab/maxent/Xmaxentscan_scoreseq.html) web services to predict the effect.

Example: You can explore the reports by entering **c.244T>A** as an example for a valid HGVSc variant name in the website's input box.

---

## Development

The final version is ready at https://maxsplizer.com.
The front-end is developed by [Reza Shahnazar](https://ir.linkedin.com/in/reza-shahnazar-93537672) as a Single-Page-Application using Vue3 framework and some Javascript libraries.
The predictor back-end is an R-plumber api project developed by [Seyedmohammad Saadatagah](https://ir.linkedin.com/in/seyedmohammad-saadatagah-18b103122). It uses [Mutalyzer v2.0.34](https://mutalyzer.nl/) and [MaxEntScan](http://hollywood.mit.edu/burgelab/maxent/Xmaxentscan_scoreseq.html) web services as dependencies.

The project is developed in [Atherosclerosis and Lipid Genomics Laboratory](https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview) under the supervision of [Dr. Iftikhar Kullo](https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview).

---

## Deployment

The R project could be served in a docker container.
Nginx could be configured using the "front-end/nginx.conf" file to serve the production build of the Vue app from "/app" directory on a linux server. Nginx would also redirect all HTTP requests with the endpoint of "/maxent" to the docker port.
