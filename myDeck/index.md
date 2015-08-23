---
title       : Project Presentation
subtitle    : Most Popular Baby Names in US
author      : Xinyu Tan
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## App Overview

This APP is to display the most and least popular names from 1880 to 2006 in the U.S. where the newborn individual has a social security number.

The main panel shows two types of presentation of the data: 

1. Point graph
2. Wordcloud


The sidebar panel has the following options for the viewer to choose the data they are interested:

1. Sex
2. Year
3. Type of order (most popular or least popular)

---

## App layout

<img src="screenshot.png" height="500", width="1000">

---

## Example output - point plot of most frequenct male baby name in 2006


<img src="p1.jpg" width=1000, height = 500>
---

## Example output - wordcloud for most frequenct male baby name in 2006


```r
data <- read.csv('../names/yob2006.txt', header = F, stringsAsFactors = F)
temp_data <- data[data$V2=='M', ]
temp_data <- temp_data[order(temp_data$V3, decreasing = T), ]
temp_data <- temp_data[1:50, ]
dim(temp_data)
```

```
## [1] 50  3
```

```r
require(wordcloud)
wordcloud(temp_data$V1, temp_data$V3, colors=brewer.pal(8, "Dark2"))
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png) 


