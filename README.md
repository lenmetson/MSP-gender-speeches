# Are female MSPs getting more opportunities to speak in Scottish Parliament? - Lennard Metson

This file can be read on a [GitHub Pages site](https://lenmetson.github.io/MSP-gender-speeches/), or the original [GitHub repository](https://github.com/lenmetson/MSP-gender-speeches).

This repository stores reproducible code for my descriptive analysis of how much women MSPs speak in the Scottish Parliament. Looking only at backbench MSPs, I find that the amount women speak, as measured by either number of speeches made or syllables spoken (a proxy for time), has stayed stable at around 30%. There has been no improvement in the amount backbench women MSPs are speaking. The amount that women speak is roughly equal to the proportion of women there are amongst backbench MSPs, suggesting that the way to increase female representation is to ensure more women are elected.  

The analysis was adapted from a piece of assessed group work from a Data Science course where the projects aim was to use Data Science tools to interact with datasets and run basic analysis. The original project contained more features and output than is contained in this repository. It can be found as a separate [GitHub repository](https://github.com/lenmetson/speech-time). This repository contains only the R code for analysing speech time of MSPs.

I use the [ParlScot database](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/EQ9WBE) created and maintained by Daniel Braby and Fraser Stewart.

# Reproducibility note

The contents of this repository are fully reproducible at no cost to the user. Because of R's [`here` package](https://cran.r-project.org/web/packages/here/index.html), the code can be run on any machine with any operating system that has [R](https://www.r-project.org/) and [RStudio](https://www.rstudio.com/products/rstudio/download/) installed. You do not need to change working directories. To reproduce the code, complete the following steps:

1. Ensure R and RStudio are installed.
2. Clone the repository to a local folder on your computer.
3. Open `MSP-gender-speeches.Rproj`. This will open a project in RStudio. Then, within R Studio, open the file `main_script.R` and follow the comments in the code.


# Results
The analysis code produces two figures. These are stored in the output folder of this repo. I have also included them below.

## Number of backbench MSPs who are women over time  

![Number of backbench MSPs who are women by session of Scottish Parliament](https://github.com/lenmetson/MSP-gender-speeches/blob/f91974cbe65e84610e20a8d33f60d66b80685871/output/pr-women-parly.png?raw=true)

## Speeches

![Speeches by women over time in Scottish Parliament](https://github.com/lenmetson/MSP-gender-speeches/blob/508f6cdd6d030a64cd65184b48eb5266b74971c1/output/speeches-women-plot.png?raw=true)

## Number of syllables

![Number of syllables by women over time in Scottish Parliament](https://github.com/lenmetson/MSP-gender-speeches/blob/bc7f9aefd82067b249b914b66bc5cfeeef847bff/output/syllables-women-plot.png?raw=true)
