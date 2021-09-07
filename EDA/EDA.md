Easy EDA with DataExplorer package
================
Dahee Kim
January 5, 2020

\#Easy Data Profiling Report To get a report for the insurance dataset
with response variable bmi, `create_report(dataname)`

``` r
#create_report(dt, y = "bmi")
```

  - Basic Statistics
      - Raw Counts
      - Percentages
  - Data Structure
  - Missing Data Profile
  - Univariate Distribution
      - Histogram
      - Bar Chart (by frequency)
      - Bar Chart (by bmi)
      - QQ Plot
      - QQ Plot (by bmi)
  - Correlation Analysis
  - Principal Component Analysis
  - Bivariate Distribution
      - Boxplot (by bmi)
      - Scatterplot (by bmi)

\#Structure of data

``` r
data_list <- list(dt)
plot_str(data_list)
```

\#Variable information

``` r
plot_intro(dt)
```

![](EDA_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

\#Missing Data by features

``` r
plot_missing(dt)
```

![](EDA_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

\#Continuous Variable \#\#Histogram for Continuous Variables

``` r
plot_histogram(dt)
```

![](EDA_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

\#\#Scatterplot `bmi` with all other continuous features

``` r
plot_scatterplot(split_columns(dt)$continuous, by = "bmi")
```

![](EDA_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

\#\#QQ plot of all continuous variables

``` r
plot_qq(dt)
```

![](EDA_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

``` r
plot_qq(dt, by = "bmi")
```

![](EDA_files/figure-gfm/unnamed-chunk-8-2.png)<!-- -->

\#Categorical Variable \#\#Categorical Data - Frequency Table

``` r
plot_bar(dt)
```

![](EDA_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

\#\#Boxplot by Categorical Variables

``` r
plot_boxplot(dt, by= 'sex',  ncol = 2)
```

![](EDA_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

``` r
plot_boxplot(dt, by= 'smoker',  ncol = 2)
```

![](EDA_files/figure-gfm/unnamed-chunk-10-2.png)<!-- -->

``` r
plot_boxplot(dt, by= 'region',  ncol = 2)
```

![](EDA_files/figure-gfm/unnamed-chunk-10-3.png)<!-- -->

\#Correlation Analysis

``` r
plot_correlation(dt)
```

![](EDA_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

\#Feature Engineering

``` r
#Dummify diamonds dataset
head(dummify(dt))
```

    ##   age  bmi children expenses sex_female sex_male smoker_no smoker_yes
    ## 1  19 27.9        0 16884.92          1        0         0          1
    ## 2  18 33.8        1  1725.55          0        1         1          0
    ## 3  28 33.0        3  4449.46          0        1         1          0
    ## 4  33 22.7        0 21984.47          0        1         1          0
    ## 5  32 28.9        0  3866.86          0        1         1          0
    ## 6  31 25.7        0  3756.62          1        0         1          0
    ##   region_northeast region_northwest region_southeast region_southwest
    ## 1                0                0                0                1
    ## 2                0                0                1                0
    ## 3                0                0                1                0
    ## 4                0                1                0                0
    ## 5                0                1                0                0
    ## 6                0                0                1                0

``` r
#Update columns
head(update_columns(dt, c("sex", "smoker","region"), as.factor))
```

    ##   age    sex  bmi children smoker    region expenses
    ## 1  19 female 27.9        0    yes southwest 16884.92
    ## 2  18   male 33.8        1     no southeast  1725.55
    ## 3  28   male 33.0        3     no southeast  4449.46
    ## 4  33   male 22.7        0     no northwest 21984.47
    ## 5  32   male 28.9        0     no northwest  3866.86
    ## 6  31 female 25.7        0     no southeast  3756.62

``` r
## Drop columns
head(drop_columns(dt, 1:2),5)
```

    ##    bmi children smoker    region expenses
    ## 1 27.9        0    yes southwest 16884.92
    ## 2 33.8        1     no southeast  1725.55
    ## 3 33.0        3     no southeast  4449.46
    ## 4 22.7        0     no northwest 21984.47
    ## 5 28.9        0     no northwest  3866.86
