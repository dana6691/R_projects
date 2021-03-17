Table Display
================
Dahee Kim

### kable

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>

<div class="blue">

**kable**(x, format, digits = getOption(“digits”), row.names = NA,
col.names = NA, align, caption = NULL, label = NULL, format.args =
list(), escape = TRUE, …)

</div>

-----

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>

<div class="blue">

The function *kable* is a simple table generator, from library `knitr`

  - digits: number of digits for individual columns
  - align: ‘l’(left), ‘c’(center),‘r’(right) ex) c(‘c’,‘l’,‘c’)
  - caption
  - label

</div>

``` r
knitr::kable(head(mtcars), digits = 2)
```

|                   |  mpg | cyl | disp |  hp | drat |   wt |  qsec | vs | am | gear | carb |
| :---------------- | ---: | --: | ---: | --: | ---: | ---: | ----: | -: | -: | ---: | ---: |
| Mazda RX4         | 21.0 |   6 |  160 | 110 | 3.90 | 2.62 | 16.46 |  0 |  1 |    4 |    4 |
| Mazda RX4 Wag     | 21.0 |   6 |  160 | 110 | 3.90 | 2.88 | 17.02 |  0 |  1 |    4 |    4 |
| Datsun 710        | 22.8 |   4 |  108 |  93 | 3.85 | 2.32 | 18.61 |  1 |  1 |    4 |    1 |
| Hornet 4 Drive    | 21.4 |   6 |  258 | 110 | 3.08 | 3.21 | 19.44 |  1 |  0 |    3 |    1 |
| Hornet Sportabout | 18.7 |   8 |  360 | 175 | 3.15 | 3.44 | 17.02 |  0 |  0 |    3 |    2 |
| Valiant           | 18.1 |   6 |  225 | 105 | 2.76 | 3.46 | 20.22 |  1 |  0 |    3 |    1 |

### DT

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>

<div class="blue">

**datatable**(data, options = list(), class = “display”, callback =
JS(“return table;”), rownames, colnames, container, caption = NULL,
filter = c(“none”, “bottom”, “top”), escape = TRUE, style = “default”,
width = NULL, height = NULL, elementId = NULL, fillContainer =
getOption(“DT.fillContainer”, NULL), autoHideNavigation =
getOption(“DT.autoHideNavigation”, NULL), selection = c(“multiple”,
“single”, “none”), extensions = list(), plugins = NULL, editable =
FALSE)

</div>

-----

<div class="blue">

  - caption
  - filter: add filter to each column
  - editable: TRUE/FALSE
  - colnames: colnames = c(‘Here’, ‘Are’, ‘Some’, ‘New’, ‘Names’)
    colnames = c(‘A Better Name’ = ‘Sepal.Width’) colnames = c(‘Another
    Better Name’ = 2, ‘Yet Another Name’ = 4
  - pageLength(options): limited showing row c(“none”, “bottom”, “top”)
  - scrollX(options): get vertical scroll bar

</div>

``` r
library(DT)
longley <- data.frame(longley)
datatable(head(longley), rownames = FALSE, filter="top", options = list(pageLength = 6, scrollX=T) )
```

<!--html_preserve-->

<div id="htmlwidget-d4bb68ea7fc232b382a4" class="datatables html-widget" style="width:100%;height:auto;">

</div>

<script type="application/json" data-for="htmlwidget-d4bb68ea7fc232b382a4">{"x":{"filter":"top","filterHTML":"<tr>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"83\" data-max=\"98.1\" data-scale=\"1\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"234.289\" data-max=\"346.999\" data-scale=\"3\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"193.2\" data-max=\"368.2\" data-scale=\"1\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"145.6\" data-max=\"359.4\" data-scale=\"1\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"107.608\" data-max=\"113.27\" data-scale=\"3\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"integer\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"1947\" data-max=\"1952\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"60.171\" data-max=\"63.639\" data-scale=\"3\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","data":[[83,88.5,88.2,89.5,96.2,98.1],[234.289,259.426,258.054,284.599,328.975,346.999],[235.6,232.5,368.2,335.1,209.9,193.2],[159,145.6,161.6,165,309.9,359.4],[107.608,108.632,109.773,110.929,112.075,113.27],[1947,1948,1949,1950,1951,1952],[60.323,61.122,60.171,61.187,63.221,63.639]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>GNP.deflator<\/th>\n      <th>GNP<\/th>\n      <th>Unemployed<\/th>\n      <th>Armed.Forces<\/th>\n      <th>Population<\/th>\n      <th>Year<\/th>\n      <th>Employed<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":6,"scrollX":true,"columnDefs":[{"className":"dt-right","targets":[0,1,2,3,4,5,6]}],"order":[],"autoWidth":false,"orderClasses":false,"orderCellsTop":true,"lengthMenu":[6,10,25,50,100]}},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->

### tibble

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>

<div class="blue">

**tibble**(…, .rows = NULL, .name\_repair = c(“check\_unique”, “unique”,
“universal”, “minimal”))

</div>

-----

<div class="blue">

  - Re-imagining of the data.frame
  - tibble() never changes the type of the inputs,never changes the
    names of variables, easier than data.frame()

</div>

``` r
library(tibble)
as_tibble(longley)
```

    ## # A tibble: 16 x 7
    ##    GNP.deflator   GNP Unemployed Armed.Forces Population  Year Employed
    ##           <dbl> <dbl>      <dbl>        <dbl>      <dbl> <int>    <dbl>
    ##  1         83    234.       236.         159        108.  1947     60.3
    ##  2         88.5  259.       232.         146.       109.  1948     61.1
    ##  3         88.2  258.       368.         162.       110.  1949     60.2
    ##  4         89.5  285.       335.         165        111.  1950     61.2
    ##  5         96.2  329.       210.         310.       112.  1951     63.2
    ##  6         98.1  347.       193.         359.       113.  1952     63.6
    ##  7         99    365.       187          355.       115.  1953     65.0
    ##  8        100    363.       358.         335        116.  1954     63.8
    ##  9        101.   397.       290.         305.       117.  1955     66.0
    ## 10        105.   419.       282.         286.       119.  1956     67.9
    ## 11        108.   443.       294.         280.       120.  1957     68.2
    ## 12        111.   445.       468.         264.       122.  1958     66.5
    ## 13        113.   483.       381.         255.       123.  1959     68.7
    ## 14        114.   503.       393.         251.       125.  1960     69.6
    ## 15        116.   518.       481.         257.       128.  1961     69.3
    ## 16        117.   555.       401.         283.       130.  1962     70.6

``` r
tibble(longley$GNP, longley$Unemployed, total = longley$GNP + longley$Unemployed)
```

    ## # A tibble: 16 x 3
    ##    `longley$GNP` `longley$Unemployed` total
    ##            <dbl>                <dbl> <dbl>
    ##  1          234.                 236.  470.
    ##  2          259.                 232.  492.
    ##  3          258.                 368.  626.
    ##  4          285.                 335.  620.
    ##  5          329.                 210.  539.
    ##  6          347.                 193.  540.
    ##  7          365.                 187   552.
    ##  8          363.                 358.  721.
    ##  9          397.                 290.  688.
    ## 10          419.                 282.  701.
    ## 11          443.                 294.  736.
    ## 12          445.                 468.  913.
    ## 13          483.                 381.  864.
    ## 14          503.                 393.  896.
    ## 15          518.                 481.  999.
    ## 16          555.                 401.  956.

### xtable

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>

<div class="blue">

**xtable**(x, caption = NULL, label = NULL, align = NULL, digits = NULL,
display = NULL, auto = FALSE, …)

</div>

``` r
library(xtable)
f1 <- aov(Year ~ GNP + Unemployed +  Population, data = longley) #latex input
xtable(f1)
```

    ## % latex table generated in R 3.6.3 by xtable 1.8-4 package
    ## % Tue Mar 16 18:52:54 2021
    ## \begin{table}[ht]
    ## \centering
    ## \begin{tabular}{lrrrrr}
    ##   \hline
    ##  & Df & Sum Sq & Mean Sq & F value & Pr($>$F) \\ 
    ##   \hline
    ## GNP & 1 & 336.79 & 336.79 & 6298.74 & 0.0000 \\ 
    ##   Unemployed & 1 & 2.39 & 2.39 & 44.76 & 0.0000 \\ 
    ##   Population & 1 & 0.17 & 0.17 & 3.20 & 0.0987 \\ 
    ##   Residuals & 12 & 0.64 & 0.05 &  &  \\ 
    ##    \hline
    ## \end{tabular}
    ## \end{table}

### expss

<div class="blue">

*expss* provides tabulation functions with support for ‘SPSS’-style
labels, multiple / nested banners, weights, multiple-response variables
and significance testing

</div>

``` r
library(expss)
mtcars = apply_labels(mtcars,
                      mpg = "Miles/(US) gallon",
                      cyl = "Number of cylinders",
                      disp = "Displacement (cu.in.)",
                      hp = "Gross horsepower",
                      drat = "Rear axle ratio",
                      wt = "Weight (1000 lbs)",
                      qsec = "1/4 mile time",
                      vs = "Engine",
                      vs = c("V-engine" = 0,
                             "Straight engine" = 1),
                      am = "Transmission",
                      am = c("Automatic" = 0,
                             "Manual"=1),
                      gear = "Number of forward gears",
                      carb = "Number of carburetors"
)
# Different statistics for different variables.
mtcars %>%
    tab_cols(total(), vs) %>%
    tab_cells(mpg) %>% 
    tab_stat_mean() %>% 
    tab_stat_valid_n() %>% 
    tab_cells(am) %>%
    tab_stat_cpct(total_row_position = "none", label = "col %") %>%
    tab_stat_rpct(total_row_position = "none", label = "row %") %>%
    tab_stat_tpct(total_row_position = "none", label = "table %") %>%
    tab_pivot(stat_position = "inside_rows") 
```

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">

<thead>

<tr>

<th style="border-top: 2px solid grey;">

</th>

<th colspan="1" style="font-weight: 900; border-top: 2px solid grey; text-align: center;">

</th>

<th style="border-bottom: none; border-top: 2px solid grey;" colspan="1">

 

</th>

<th colspan="1" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">

 \#Total 

</th>

<th style="border-bottom: none; border-top: 2px solid grey;" colspan="1">

 

</th>

<th colspan="2" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">

 Engine 

</th>

</tr>

<tr>

<th style="border-bottom: 1px solid grey; font-weight: 900; text-align: center;">

</th>

<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: center;">

</th>

<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: center;" colspan="1">

 

</th>

<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: center;">

</th>

<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: center;" colspan="1">

 

</th>

<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: center;">

 V-engine 

</th>

<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: center;">

 Straight engine 

</th>

</tr>

</thead>

<tbody>

<tr>

<td colspan="7" style="font-weight: 900;">

 Miles/(US) gallon 

</td>

</tr>

<tr>

<td style="text-align: left;">

   Mean 

</td>

<td style="text-align: left;">

</td>

<td style="text-align: left;" colspan="1">

 

</td>

<td style="text-align: right;">

20.1

</td>

<td style="text-align: right;" colspan="1">

 

</td>

<td style="text-align: right;">

16.6

</td>

<td style="text-align: right;">

24.6

</td>

</tr>

<tr>

<td style="text-align: left;">

   Valid N 

</td>

<td style="text-align: left;">

</td>

<td style="text-align: left;" colspan="1">

 

</td>

<td style="text-align: right;">

32.0

</td>

<td style="text-align: right;" colspan="1">

 

</td>

<td style="text-align: right;">

18.0

</td>

<td style="text-align: right;">

14.0

</td>

</tr>

<tr>

<td colspan="7" style="font-weight: 900;">

 Transmission 

</td>

</tr>

<tr>

<td style="text-align: left;">

   Automatic 

</td>

<td style="text-align: left;">

 col % 

</td>

<td style="text-align: left;" colspan="1">

 

</td>

<td style="text-align: right;">

59.4

</td>

<td style="text-align: right;" colspan="1">

 

</td>

<td style="text-align: right;">

66.7

</td>

<td style="text-align: right;">

50.0

</td>

</tr>

<tr>

<td style="text-align: left;">

  

</td>

<td style="text-align: left;">

 row % 

</td>

<td style="text-align: left;" colspan="1">

 

</td>

<td style="text-align: right;">

100.0

</td>

<td style="text-align: right;" colspan="1">

 

</td>

<td style="text-align: right;">

63.2

</td>

<td style="text-align: right;">

36.8

</td>

</tr>

<tr>

<td style="text-align: left;">

  

</td>

<td style="text-align: left;">

 table % 

</td>

<td style="text-align: left;" colspan="1">

 

</td>

<td style="text-align: right;">

59.4

</td>

<td style="text-align: right;" colspan="1">

 

</td>

<td style="text-align: right;">

37.5

</td>

<td style="text-align: right;">

21.9

</td>

</tr>

<tr>

<td style="text-align: left;">

   Manual 

</td>

<td style="text-align: left;">

 col % 

</td>

<td style="text-align: left;" colspan="1">

 

</td>

<td style="text-align: right;">

40.6

</td>

<td style="text-align: right;" colspan="1">

 

</td>

<td style="text-align: right;">

33.3

</td>

<td style="text-align: right;">

50.0

</td>

</tr>

<tr>

<td style="text-align: left;">

  

</td>

<td style="text-align: left;">

 row % 

</td>

<td style="text-align: left;" colspan="1">

 

</td>

<td style="text-align: right;">

100.0

</td>

<td style="text-align: right;" colspan="1">

 

</td>

<td style="text-align: right;">

46.2

</td>

<td style="text-align: right;">

53.8

</td>

</tr>

<tr>

<td style="border-bottom: 2px solid grey; text-align: left;">

  

</td>

<td style="border-bottom: 2px solid grey; text-align: left;">

 table % 

</td>

<td style="border-bottom: 2px solid grey; text-align: left;" colspan="1">

 

</td>

<td style="border-bottom: 2px solid grey; text-align: right;">

40.6

</td>

<td style="border-bottom: 2px solid grey; text-align: right;" colspan="1">

 

</td>

<td style="border-bottom: 2px solid grey; text-align: right;">

18.8

</td>

<td style="border-bottom: 2px solid grey; text-align: right;">

21.9

</td>

</tr>

</tbody>

</table>

### formattable

``` r
library("formattable")
# Read CSV into R
MyData <- read.csv(file="C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Rfile/Rpubs/Visualization/african_crises.csv", header=TRUE, sep=",")
mydata <- subset(MyData, MyData$year< 1870)
formattable(table(mydata$year, mydata$country))
```

    ##       
    ##        Algeria Angola Central African Republic Egypt Ivory Coast Kenya
    ##   1860 0       0      0                        1     0           0    
    ##   1861 0       0      0                        1     0           0    
    ##   1862 0       0      0                        1     0           0    
    ##   1863 0       0      0                        1     0           0    
    ##   1864 0       0      0                        1     0           0    
    ##   1865 0       0      0                        1     0           0    
    ##   1866 0       0      0                        1     0           0    
    ##   1867 0       0      0                        1     0           0    
    ##   1868 0       0      0                        1     0           0    
    ##   1869 0       0      0                        1     0           0    
    ##       
    ##        Mauritius Morocco Nigeria South Africa Tunisia Zambia Zimbabwe
    ##   1860 0         0       0       0            0       0      0       
    ##   1861 0         0       0       0            0       0      0       
    ##   1862 0         0       0       0            0       0      0       
    ##   1863 0         0       0       0            0       0      0       
    ##   1864 0         0       0       0            0       0      0       
    ##   1865 0         0       0       0            0       0      0       
    ##   1866 0         0       0       0            0       0      0       
    ##   1867 0         0       0       0            0       0      0       
    ##   1868 0         0       0       0            0       0      0       
    ##   1869 0         0       0       0            0       0      0

### tidyr

``` r
library(formattable)
library(tidyr)
library(dplyr)
library(readxl)
texasdata <- read.csv("https://raw.githubusercontent.com/dana6691/R_project/master/Data/Imagine_Austin_Indicators.csv", header=TRUE, sep=",")

# select rows, columns, average by rows, percentage of change
i1 <- texasdata %>%
  filter(`Indicator.Name` %in% 
           c('Prevalence of Obesity', 'Prevalence of Tobacco Use', 
             'Prevalence of Cardiovascular Disease', 'Prevalence of Diabetes')) %>%
  select(c(`Indicator.Name`, `X2011`, `X2012`, `X2013`, `X2014`, `X2015`, `X2016`)) %>%
  mutate (Average = round(rowMeans(
    cbind(`X2011`, `X2012`, `X2013`, `X2014`, `X2015`, `X2016`), na.rm=T),2), 
    `Improvement` = round((`X2016`-`X2011`)/`X2011`*100,2))
i1
```

    ##                         Indicator.Name X2011 X2012 X2013 X2014 X2015 X2016
    ## 1               Prevalence of Diabetes   8.0   7.2   9.3   7.2   7.5  10.4
    ## 2            Prevalence of Tobacco Use  17.4  15.0  15.3  12.2  16.6  16.7
    ## 3                Prevalence of Obesity  19.1  23.6  23.3  20.5  24.0  23.2
    ## 4 Prevalence of Cardiovascular Disease   5.0   4.9   1.5   4.4   4.9   6.2
    ##   Average Improvement
    ## 1    8.27       30.00
    ## 2   15.53       -4.02
    ## 3   22.28       21.47
    ## 4    4.48       24.00

``` r
formattable(i1)
```

<table class="table table-condensed">

<thead>

<tr>

<th style="text-align:right;">

Indicator.Name

</th>

<th style="text-align:right;">

X2011

</th>

<th style="text-align:right;">

X2012

</th>

<th style="text-align:right;">

X2013

</th>

<th style="text-align:right;">

X2014

</th>

<th style="text-align:right;">

X2015

</th>

<th style="text-align:right;">

X2016

</th>

<th style="text-align:right;">

Average

</th>

<th style="text-align:right;">

Improvement

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

Prevalence of Diabetes

</td>

<td style="text-align:right;">

8.0

</td>

<td style="text-align:right;">

7.2

</td>

<td style="text-align:right;">

9.3

</td>

<td style="text-align:right;">

7.2

</td>

<td style="text-align:right;">

7.5

</td>

<td style="text-align:right;">

10.4

</td>

<td style="text-align:right;">

8.27

</td>

<td style="text-align:right;">

30.00

</td>

</tr>

<tr>

<td style="text-align:right;">

Prevalence of Tobacco Use

</td>

<td style="text-align:right;">

17.4

</td>

<td style="text-align:right;">

15.0

</td>

<td style="text-align:right;">

15.3

</td>

<td style="text-align:right;">

12.2

</td>

<td style="text-align:right;">

16.6

</td>

<td style="text-align:right;">

16.7

</td>

<td style="text-align:right;">

15.53

</td>

<td style="text-align:right;">

\-4.02

</td>

</tr>

<tr>

<td style="text-align:right;">

Prevalence of Obesity

</td>

<td style="text-align:right;">

19.1

</td>

<td style="text-align:right;">

23.6

</td>

<td style="text-align:right;">

23.3

</td>

<td style="text-align:right;">

20.5

</td>

<td style="text-align:right;">

24.0

</td>

<td style="text-align:right;">

23.2

</td>

<td style="text-align:right;">

22.28

</td>

<td style="text-align:right;">

21.47

</td>

</tr>

<tr>

<td style="text-align:right;">

Prevalence of Cardiovascular Disease

</td>

<td style="text-align:right;">

5.0

</td>

<td style="text-align:right;">

4.9

</td>

<td style="text-align:right;">

1.5

</td>

<td style="text-align:right;">

4.4

</td>

<td style="text-align:right;">

4.9

</td>

<td style="text-align:right;">

6.2

</td>

<td style="text-align:right;">

4.48

</td>

<td style="text-align:right;">

24.00

</td>

</tr>

</tbody>

</table>

### stargazer

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>

<div class="blue">

**stargazer**( …, type = “latex”, title = "“, style =”default", summary
= NULL, out = NULL, out.header = FALSE, column.labels = NULL,
column.separate = NULL, covariate.labels = NULL, dep.var.caption = NULL,
dep.var.labels = NULL, dep.var.labels.include = TRUE, align = FALSE,
coef = NULL, se = NULL, t = NULL, p = NULL, t.auto = TRUE, p.auto =
TRUE, ci = FALSE, ci.custom = NULL, ci.level = 0.95, ci.separator =
NULL, add.lines = NULL, apply.coef = NULL, apply.se = NULL,
summary.logical = TRUE, summary.stat = NULL, nobs = TRUE, mean.sd =
TRUE, min.max = TRUE, median = FALSE, iqr = FALSE )

</div>

-----

<div class="blue">

  - Type: “text”, “html”
  - ci: TRUE/FALSE
  - ci.level: 0.8, 0.9
  - omit.stat: =c(“f”, “ser”)

</div>

``` r
library(stargazer)
f1 <- lm(mpg ~ wt, mtcars) #2 OLS models
f2 <- lm(mpg ~ wt + hp, mtcars)
f3 <- lm(mpg ~ wt + hp + cyl, mtcars)
stargazer(f1, f2, f3, type = 'html')
```

<table style="text-align:center">

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="3">

<em>Dependent variable:</em>

</td>

</tr>

<tr>

<td>

</td>

<td colspan="3" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="3">

mpg

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(1)

</td>

<td>

(2)

</td>

<td>

(3)

</td>

</tr>

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

wt

</td>

<td>

\-5.344<sup>\*\*\*</sup>

</td>

<td>

\-3.878<sup>\*\*\*</sup>

</td>

<td>

\-3.167<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.559)

</td>

<td>

(0.633)

</td>

<td>

(0.741)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

hp

</td>

<td>

</td>

<td>

\-0.032<sup>\*\*\*</sup>

</td>

<td>

\-0.018

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

(0.009)

</td>

<td>

(0.012)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

cyl

</td>

<td>

</td>

<td>

</td>

<td>

\-0.942<sup>\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

(0.551)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

Constant

</td>

<td>

37.285<sup>\*\*\*</sup>

</td>

<td>

37.227<sup>\*\*\*</sup>

</td>

<td>

38.752<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(1.878)

</td>

<td>

(1.599)

</td>

<td>

(1.787)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Observations

</td>

<td>

32

</td>

<td>

32

</td>

<td>

32

</td>

</tr>

<tr>

<td style="text-align:left">

R<sup>2</sup>

</td>

<td>

0.753

</td>

<td>

0.827

</td>

<td>

0.843

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.745

</td>

<td>

0.815

</td>

<td>

0.826

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

3.046 (df = 30)

</td>

<td>

2.593 (df = 29)

</td>

<td>

2.512 (df = 28)

</td>

</tr>

<tr>

<td style="text-align:left">

F Statistic

</td>

<td>

91.375<sup>\*\*\*</sup> (df = 1; 30)

</td>

<td>

69.211<sup>\*\*\*</sup> (df = 2; 29)

</td>

<td>

50.171<sup>\*\*\*</sup> (df = 3; 28)

</td>

</tr>

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

<em>Note:</em>

</td>

<td colspan="3" style="text-align:right">

<sup>*</sup>p\<0.1; <sup>**</sup>p\<0.05; <sup>***</sup>p\<0.01

</td>

</tr>

</table>

``` r
library(stargazer)
f1 <- lm(mpg ~ wt, mtcars) #2 OLS models
f2 <- lm(mpg ~ wt + hp, mtcars)
f3 <- lm(mpg ~ wt + hp + cyl, mtcars)
stargazer(f1, f2, f3, type = 'html')
```

<table style="text-align:center">

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="3">

<em>Dependent variable:</em>

</td>

</tr>

<tr>

<td>

</td>

<td colspan="3" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="3">

mpg

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(1)

</td>

<td>

(2)

</td>

<td>

(3)

</td>

</tr>

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

wt

</td>

<td>

\-5.344<sup>\*\*\*</sup>

</td>

<td>

\-3.878<sup>\*\*\*</sup>

</td>

<td>

\-3.167<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.559)

</td>

<td>

(0.633)

</td>

<td>

(0.741)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

hp

</td>

<td>

</td>

<td>

\-0.032<sup>\*\*\*</sup>

</td>

<td>

\-0.018

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

(0.009)

</td>

<td>

(0.012)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

cyl

</td>

<td>

</td>

<td>

</td>

<td>

\-0.942<sup>\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

(0.551)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

Constant

</td>

<td>

37.285<sup>\*\*\*</sup>

</td>

<td>

37.227<sup>\*\*\*</sup>

</td>

<td>

38.752<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(1.878)

</td>

<td>

(1.599)

</td>

<td>

(1.787)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Observations

</td>

<td>

32

</td>

<td>

32

</td>

<td>

32

</td>

</tr>

<tr>

<td style="text-align:left">

R<sup>2</sup>

</td>

<td>

0.753

</td>

<td>

0.827

</td>

<td>

0.843

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.745

</td>

<td>

0.815

</td>

<td>

0.826

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

3.046 (df = 30)

</td>

<td>

2.593 (df = 29)

</td>

<td>

2.512 (df = 28)

</td>

</tr>

<tr>

<td style="text-align:left">

F Statistic

</td>

<td>

91.375<sup>\*\*\*</sup> (df = 1; 30)

</td>

<td>

69.211<sup>\*\*\*</sup> (df = 2; 29)

</td>

<td>

50.171<sup>\*\*\*</sup> (df = 3; 28)

</td>

</tr>

<tr>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

<em>Note:</em>

</td>

<td colspan="3" style="text-align:right">

<sup>*</sup>p\<0.1; <sup>**</sup>p\<0.05; <sup>***</sup>p\<0.01

</td>

</tr>

</table>

``` r
correlation.matrix <- cor(mtcars) #correlation matrix
stargazer(correlation.matrix, type="html")
```

<table style="text-align:center">

<tr>

<td colspan="12" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

mpg

</td>

<td>

cyl

</td>

<td>

disp

</td>

<td>

hp

</td>

<td>

drat

</td>

<td>

wt

</td>

<td>

qsec

</td>

<td>

vs

</td>

<td>

am

</td>

<td>

gear

</td>

<td>

carb

</td>

</tr>

<tr>

<td colspan="12" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

mpg

</td>

<td>

1

</td>

<td>

\-0.852

</td>

<td>

\-0.848

</td>

<td>

\-0.776

</td>

<td>

0.681

</td>

<td>

\-0.868

</td>

<td>

0.419

</td>

<td>

0.664

</td>

<td>

0.600

</td>

<td>

0.480

</td>

<td>

\-0.551

</td>

</tr>

<tr>

<td style="text-align:left">

cyl

</td>

<td>

\-0.852

</td>

<td>

1

</td>

<td>

0.902

</td>

<td>

0.832

</td>

<td>

\-0.700

</td>

<td>

0.782

</td>

<td>

\-0.591

</td>

<td>

\-0.811

</td>

<td>

\-0.523

</td>

<td>

\-0.493

</td>

<td>

0.527

</td>

</tr>

<tr>

<td style="text-align:left">

disp

</td>

<td>

\-0.848

</td>

<td>

0.902

</td>

<td>

1

</td>

<td>

0.791

</td>

<td>

\-0.710

</td>

<td>

0.888

</td>

<td>

\-0.434

</td>

<td>

\-0.710

</td>

<td>

\-0.591

</td>

<td>

\-0.556

</td>

<td>

0.395

</td>

</tr>

<tr>

<td style="text-align:left">

hp

</td>

<td>

\-0.776

</td>

<td>

0.832

</td>

<td>

0.791

</td>

<td>

1

</td>

<td>

\-0.449

</td>

<td>

0.659

</td>

<td>

\-0.708

</td>

<td>

\-0.723

</td>

<td>

\-0.243

</td>

<td>

\-0.126

</td>

<td>

0.750

</td>

</tr>

<tr>

<td style="text-align:left">

drat

</td>

<td>

0.681

</td>

<td>

\-0.700

</td>

<td>

\-0.710

</td>

<td>

\-0.449

</td>

<td>

1

</td>

<td>

\-0.712

</td>

<td>

0.091

</td>

<td>

0.440

</td>

<td>

0.713

</td>

<td>

0.700

</td>

<td>

\-0.091

</td>

</tr>

<tr>

<td style="text-align:left">

wt

</td>

<td>

\-0.868

</td>

<td>

0.782

</td>

<td>

0.888

</td>

<td>

0.659

</td>

<td>

\-0.712

</td>

<td>

1

</td>

<td>

\-0.175

</td>

<td>

\-0.555

</td>

<td>

\-0.692

</td>

<td>

\-0.583

</td>

<td>

0.428

</td>

</tr>

<tr>

<td style="text-align:left">

qsec

</td>

<td>

0.419

</td>

<td>

\-0.591

</td>

<td>

\-0.434

</td>

<td>

\-0.708

</td>

<td>

0.091

</td>

<td>

\-0.175

</td>

<td>

1

</td>

<td>

0.745

</td>

<td>

\-0.230

</td>

<td>

\-0.213

</td>

<td>

\-0.656

</td>

</tr>

<tr>

<td style="text-align:left">

vs

</td>

<td>

0.664

</td>

<td>

\-0.811

</td>

<td>

\-0.710

</td>

<td>

\-0.723

</td>

<td>

0.440

</td>

<td>

\-0.555

</td>

<td>

0.745

</td>

<td>

1

</td>

<td>

0.168

</td>

<td>

0.206

</td>

<td>

\-0.570

</td>

</tr>

<tr>

<td style="text-align:left">

am

</td>

<td>

0.600

</td>

<td>

\-0.523

</td>

<td>

\-0.591

</td>

<td>

\-0.243

</td>

<td>

0.713

</td>

<td>

\-0.692

</td>

<td>

\-0.230

</td>

<td>

0.168

</td>

<td>

1

</td>

<td>

0.794

</td>

<td>

0.058

</td>

</tr>

<tr>

<td style="text-align:left">

gear

</td>

<td>

0.480

</td>

<td>

\-0.493

</td>

<td>

\-0.556

</td>

<td>

\-0.126

</td>

<td>

0.700

</td>

<td>

\-0.583

</td>

<td>

\-0.213

</td>

<td>

0.206

</td>

<td>

0.794

</td>

<td>

1

</td>

<td>

0.274

</td>

</tr>

<tr>

<td style="text-align:left">

carb

</td>

<td>

\-0.551

</td>

<td>

0.527

</td>

<td>

0.395

</td>

<td>

0.750

</td>

<td>

\-0.091

</td>

<td>

0.428

</td>

<td>

\-0.656

</td>

<td>

\-0.570

</td>

<td>

0.058

</td>

<td>

0.274

</td>

<td>

1

</td>

</tr>

<tr>

<td colspan="12" style="border-bottom: 1px solid black">

</td>

</tr>

</table>
