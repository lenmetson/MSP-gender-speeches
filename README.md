# 🔎 Mini Project: Gender Representation in Scottish Parliament

## Infomation
💽 Data: [ParlScot](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/EQ9WBE) Braby & Stewart (2021)

⏪ Spin-off project from [speech-time](https://github.com/lenmetson/speech-time).

# 🤔 Motivation 
Studies of (decriptive) gender representation tend to compare the proportion of female MPs and with the population. 

We wondered if measuring the time that legislators speak might produce a different result...

... and it didn't in this case. BUT...

..this project is entirely descriptive, we can't say why the proportions of women and speech-time by women is similar. Therefore, we can't generalise this to be the case everywhere. It would be interesting to replicate the analysis in different parliaments and see if the same result is found.

# 📊 Results 

Before we discuss the results, one quick note: the available data only included a binary measure of gender. Therefore, the analysis is unfortunatley restricted to binary gender (i.e. "male" versus "female" MSPs)

# 1️ The proportion of backbench MSPs who are women has stayed pretty much the same over different parliaments

![Number of backbench MSPs who are women by session of Scottish Parliament](https://github.com/lenmetson/MSP-gender-speeches/blob/f91974cbe65e84610e20a8d33f60d66b80685871/output/pr-women-parly.png?raw=true)

# 2️ The proprotion of backbench speeches that are by women has stayed pretty much the same and is roughly proportional to the number of women


![Speeches by women over time in Scottish Parliament](https://github.com/lenmetson/MSP-gender-speeches/blob/508f6cdd6d030a64cd65184b48eb5266b74971c1/output/speeches-women-plot.png?raw=true)

# 3️ The same is true if we measure speech time by the sum of sylables in the words male and female MSPs use

![Number of syllables by women over time in Scottish Parliament](https://github.com/lenmetson/MSP-gender-speeches/blob/bc7f9aefd82067b249b914b66bc5cfeeef847bff/output/syllables-women-plot.png?raw=true)

# ⏩ Where next? 

There are a few ways of extending the analysis including... 

* Applying to different parliaments 
* Using a better measure of gender which isn't binary
* Including ministers in the analysis 
* Finding out about what female MSPs say

# 🔁 Replication 

The R code needed to obtain and analyse the data is all available on this GitHub repository. 

Feel free to reproduce, edit tweak and extend and I would love to chat if you do 😀 (Twitter: @len_metson)

# 🔁 How to replicate
The contents of this repository are fully reproducible at no cost to the user. Because of R's [`here` package](https://cran.r-project.org/web/packages/here/index.html), the code can be run on any machine with any operating system that has [R](https://www.r-project.org/) and [RStudio](https://www.rstudio.com/products/rstudio/download/) installed. You do not need to change working directories. To reproduce the code, complete the following steps:

1. Ensure R and RStudio are installed.
2. Clone the repository to a local folder on your computer.
3. Open `MSP-gender-speeches.Rproj`. This will open a project in RStudio. Then, within R Studio, open the file `main_script.R` and follow the comments in the code.

# ℹ️ Background to the project
This file can be read on a [GitHub Pages site](https://lenmetson.github.io/MSP-gender-speeches/), or the original [GitHub repository](https://github.com/lenmetson/MSP-gender-speeches).

This repository stores reproducible code for my descriptive analysis of how much women MSPs speak in the Scottish Parliament. Looking only at backbench MSPs, I find that the amount women speak, as measured by either number of speeches made or syllables spoken (a proxy for time), has stayed stable at around 30%. There has been no improvement in the amount backbench women MSPs are speaking. The amount that women speak is roughly equal to the proportion of women there are amongst backbench MSPs, suggesting that the way to increase female representation is to ensure more women are elected.  

The analysis was adapted from a piece of assessed group work from a Data Science course where the projects aim was to use Data Science tools to interact with datasets and run basic analysis. The original project contained more features and output than is contained in this repository. It can be found as a separate [GitHub repository](https://github.com/lenmetson/speech-time). This repository contains only the R code for analysing speech time of MSPs.

I use the [ParlScot database](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/EQ9WBE) created and maintained by Daniel Braby and Fraser Stewart.



