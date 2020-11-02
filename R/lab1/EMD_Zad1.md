Wczytywanie danych i ładowanie bibliotek
----------------------------------------

``` r
library(EDAWR)
```

    ## 
    ## Attaching package: 'EDAWR'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     storms

``` r
data_source<-tb
```

Krótkie podsumowanie danych w zbiorze
-------------------------------------

``` r
knitr::kable(summary(data_source))
```

<table style="width:100%;">
<colgroup>
<col style="width: 3%" />
<col style="width: 17%" />
<col style="width: 13%" />
<col style="width: 17%" />
<col style="width: 16%" />
<col style="width: 15%" />
<col style="width: 17%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">country</th>
<th style="text-align: left;">year</th>
<th style="text-align: left;">sex</th>
<th style="text-align: left;">child</th>
<th style="text-align: left;">adult</th>
<th style="text-align: left;">elderly</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">Length:3800</td>
<td style="text-align: left;">Min. :1995</td>
<td style="text-align: left;">Length:3800</td>
<td style="text-align: left;">Min. : 0.0</td>
<td style="text-align: left;">Min. : 0</td>
<td style="text-align: left;">Min. : 0.0</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">Class :character</td>
<td style="text-align: left;">1st Qu.:1999</td>
<td style="text-align: left;">Class :character</td>
<td style="text-align: left;">1st Qu.: 25.0</td>
<td style="text-align: left;">1st Qu.: 1128</td>
<td style="text-align: left;">1st Qu.: 84.5</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">Mode :character</td>
<td style="text-align: left;">Median :2004</td>
<td style="text-align: left;">Mode :character</td>
<td style="text-align: left;">Median : 76.0</td>
<td style="text-align: left;">Median : 2589</td>
<td style="text-align: left;">Median : 230.0</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Mean :2004</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Mean : 493.2</td>
<td style="text-align: left;">Mean : 10864</td>
<td style="text-align: left;">Mean : 1253.0</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">3rd Qu.:2009</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">3rd Qu.: 264.5</td>
<td style="text-align: left;">3rd Qu.: 6706</td>
<td style="text-align: left;">3rd Qu.: 640.0</td>
</tr>
<tr class="even">
<td style="text-align: left;"></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Max. :2013</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">Max. :25661.0</td>
<td style="text-align: left;">Max. :731540</td>
<td style="text-align: left;">Max. :125991.0</td>
</tr>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA’s :396</td>
<td style="text-align: left;">NA’s :413</td>
<td style="text-align: left;">NA’s :413</td>
</tr>
</tbody>
</table>

Liczbę zachorowań z podziałem na płeć
-------------------------------------

``` r
t_date<- group_by(data_source, sex)

summarize(t_date, count=sum(child + adult +     elderly, na.rm=TRUE))
```

    ## # A tibble: 2 x 2
    ##   sex       count
    ##   <chr>     <int>
    ## 1 female 15610599
    ## 2 male   27016456

Wykres liniowy sumarycznej liczby zachorowań wśród dzieci, dorosłych i osób starszych w kolejnych latach
--------------------------------------------------------------------------------------------------------

``` r
t_date<- group_by(data_source, year)

a <- summarize(t_date, count=sum(child + adult + elderly, na.rm=TRUE))
plot(a, ylab="count",type="l",col="red")
```

![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-3-1.png)

Wykres liniowy sumarycznej liczby zachorowań wśród dzieci, dorosłych i osób starszych w kolejnych latach z podzialem na kraje
-----------------------------------------------------------------------------------------------------------------------------

``` r
new_data<-data_source %>%
  group_split(country)

for(i in 1:length(new_data)) {
  a <- new_data[[i]]%>% group_by(year) %>%
  summarise(a_sum=sum(child + adult + elderly, na.rm=TRUE)) 
  plot(a, ylab="count",type="l",col=i,main=new_data[[i]][1,"country"])
}
```

![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-1.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-2.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-3.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-4.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-5.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-6.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-7.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-8.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-9.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-10.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-11.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-12.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-13.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-14.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-15.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-16.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-17.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-18.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-19.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-20.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-21.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-22.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-23.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-24.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-25.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-26.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-27.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-28.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-29.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-30.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-31.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-32.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-33.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-34.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-35.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-36.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-37.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-38.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-39.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-40.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-41.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-42.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-43.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-44.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-45.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-46.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-47.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-48.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-49.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-50.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-51.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-52.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-53.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-54.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-55.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-56.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-57.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-58.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-59.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-60.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-61.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-62.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-63.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-64.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-65.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-66.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-67.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-68.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-69.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-70.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-71.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-72.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-73.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-74.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-75.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-76.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-77.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-78.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-79.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-80.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-81.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-82.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-83.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-84.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-85.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-86.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-87.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-88.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-89.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-90.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-91.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-92.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-93.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-94.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-95.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-96.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-97.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-98.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-99.png)![](EMD_Zad1_files/figure-markdown_github/unnamed-chunk-4-100.png)
