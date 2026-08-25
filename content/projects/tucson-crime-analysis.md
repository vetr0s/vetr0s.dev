---
title: "Tucson crime analysis"
description: "A multivariate study of Tucson crime data, neighborhood income, and streetlight locations. The results showed association, not causation."
status: "Course project, complete"
featured: 4
source: "https://github.com/vetr0s/tucson-crime-analysis"
---

This project tested how reported crime in Tucson relates to neighborhood income
and city streetlight locations. Our team combined four public datasets and used
regression and classification models to examine two hypotheses.

Lower median household income was associated with higher crime counts in the
data. Streetlight count was also positively associated with crime. That second
result ran against our starting hypothesis. A likely explanation is that lights
are installed in response to crime or alongside other features of dense areas.
The data cannot establish cause.

## What I worked on

- Cleaning and joining crime, arrest, income, and geospatial datasets
- Exploratory analysis across Tucson police divisions and wards
- Ridge regression, logistic regression, Random Forest, and OLS models
- A written review of reporting bias, sample size, and causal limits
- A reproducible repository with the source datasets and report

The strongest result was methodological. A model can produce a clear number and
still support only a narrow claim. The final report separates predictive fit
from causal interpretation and records where the data is too weak to decide.

- [Source and methodology](https://github.com/vetr0s/tucson-crime-analysis)
- [Final report](https://github.com/vetr0s/tucson-crime-analysis/blob/main/report/final.pdf)
