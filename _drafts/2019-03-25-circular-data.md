Wrapping my head around circular means
================
Ruan van Mazijk

For the first proper blog-post on this blog, I thought I’d share a
recent statistical problem I’ve had as part of my Masters work.

One of my chapters is about comparing patterns of growth and flowering
phenology (the timing of these sorts of events during the year) across a
few dozen species of sedge (Cyperaceae)—gramminoid plants common here in
the fynbos in the Cape Floristic Region.

For one analysis, I am comparing flowering data between six clades. The
biological details are not the focus of this post. I am more interested
(for the moment) in sharing the analytical approach I’ve learnt.

Normally in ecology and related disciplines, when we wish to compare two
or more distributions of values, we would employ a \(t\)-test or
*ANOVA*. This is all very well if the values we wish to compare fall on
a number line.

This is not the case with phenological or seasonal data.

## A small introduction to circular data

A variable describing the time of year, time of day or season of an
event is an example of *circular data*. A simple example of could
involve one trying to estimate when, on average, people sleep:

``` r
# Make up some data
sleeping <- c(
  24, 23, 24, 23, 22, 24, 23, 21, 22, 24, 23, 20, 22, 23, 24, 24,
  1, 2, 2, 1, 3, 2, 2, 1, 1, 3, 4, 2, 3, 3, 4, 5, 5, 6, 3, 1, 1
)
# Plot its distribution
hist(sleeping,
  breaks = 24,
  xlab = "Time of day (hour)", ylab = "No. people sleeping",
  main = ""
)
```

![Histogram of sleeping
times.](2019-03-25-circular-data_files/figure-gfm/sleep-example-plot-linear-1.png)

From this made-up data it is clear that people sleep at night. But our
go-to statistic, the mean, fails at describing this:

``` r
mean(sleeping)
```

    ## [1] 11.37838

Nobody was asleep at 11h30 in the afternoon\! This statistic is not very
helpful. How can we better describe the average time of asleepness?

Part of this issue is that time-of-day is not a *linear* measurement,
but a *circular* one. It does not fall on a number line, as 24h00 is the
same “thing” as 00h00. Our sleeping data would be better visualised as
follows (using the R-package
[`ggplot2`](https://ggplot2.tidyverse.org/)) (Wickham 2009):

``` r
library(ggplot2)
# Set theme to something simpler, cleaner
theme_set(theme_minimal())
ggplot(as.data.frame(sleeping), aes(sleeping)) +
  geom_histogram(bins = 24) +  # because 24hrs in a day
  scale_x_continuous(
    breaks = seq(0, 24, 2), 
    labels = paste0(seq(0, 24, 2), "h00")  # 01h00, 02h00 etc.
  ) +
  # Make the plot circular
  coord_polar() +
  theme(
    axis.title.x = element_blank(),
    # Remove non-sensical y-axis details now that plot is circular
    axis.title.y = element_blank(),
    axis.text.y = element_blank()
  )
```

![Circular histogram of sleeping
times.](2019-03-25-circular-data_files/figure-gfm/sleep-example-plot-circular-1.png)

Here, it is much clearer that people tend to be asleep around 00h00 to
01h00. The R-package
[`circular`](https://cran.r-project.org/web/packages/circular/index.html)
(Agostinelli and Lund 2017) provides an interface to this common form of
data in the social sciences and ecology. It enables us to calculate
statistics such as the *circular mean*, which accounts for the fact that
our data live on a circle and not a number line.

To convert data into explicitly circular data, we use
`circular::as.circular()`, which takes a vector as input:

``` r
library(circular)
```

    ## 
    ## Attaching package: 'circular'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     sd, var

``` r
sleeping <- as.circular(sleeping, 
  type = "directions",
  units = "hours", template = "clock24"
)
```

    ## Warning in as.circular(sleeping, type = "directions", units = "hours", template = "clock24"): an object is coerced to the class 'circular' using default value for the following components:
    ##   modulo: 'asis'
    ##   zero: 0
    ##   rotation: 'counter'
    ## evalexprenvirenclos

``` r
sleeping
```

    ## Circular Data: 
    ## Type = directions 
    ## Units = hours 
    ## Template = clock24 
    ## Modulo = asis 
    ## Zero = 1.570796 
    ## Rotation = clock 
    ##  [1] 24 23 24 23 22 24 23 21 22 24 23 20 22 23 24 24  1  2  2  1  3  2  2
    ## [24]  1  1  3  4  2  3  3  4  5  5  6  3  1  1

``` r
plot(sleeping)
```

![The default plot produced by the `plot.circular()`
method.](2019-03-25-circular-data_files/figure-gfm/sleep-example-circular-pkg-1.png)

Now, the mean makes much more sense:

``` r
mean(sleeping)
```

    ## Circular Data: 
    ## Type = directions 
    ## Units = hours 
    ## Template = clock24 
    ## Modulo = asis 
    ## Zero = 1.570796 
    ## Rotation = clock 
    ## [1] 1.975252

``` r
plot(sleeping)
points(mean(sleeping), col = "red")
```

![The mean is now more sensible, thanks to
`circular::`.](2019-03-25-circular-data_files/figure-gfm/sleep-example-circular-mean-1.png)

## My data: flowering times in Cape sedges

I mentioned at the top that my motivation for this post was to share the
application of circular statistics to some data for my Masters (albeit a
small example thereof).

As above, I am comparing flowering data between six clades of gramminoid
fynbos plants (Cyperaceae, Tribe Schoeneae), namely the genera
*Schoenus* L. and *Tetraria* Beauv. *Tetraria* is known to be
polyphyletic, and until recently the only *Schoenus* species in southern
Africa was the cosmopolitain *S. nigricans* L. The rest, used below,
have been transferred from *Tetraria* Beauv. to *Schoenus* L. by (n.d.).

The last large-scale conspectus of the Cape flora was by Manning and
Goldblatt (2012). The data I use here are from that flora, with species
names ammended to much current taxonomy (as in n.d.).

| Species                 | Start | End  |
| :---------------------- | :---- | :--- |
| Schoenus adnatus        | Feb   | Aug  |
| Schoenus complanatus    | Dec   | Mar  |
| Schoenus dregeanus      | Dec   | Apr  |
| Schoenus gracilimus     | Dec   | Mar  |
| Schoenus lucidus        | Dec   | Dec  |
| Schoenus quadrangularis | Nov   | May  |
| Schoenus neovillosus    | Jan   | Feb  |
| Schoenus arenicola      | Jul   | Nov  |
| Schoenus compar         | Apr   | Jun  |
| Schoenus pictus         | Dec   | May  |
| Schoenus bolussi        | Jul   | Aug  |
| Schoenus compactus      | Aug   | Nov  |
| Schoenus crassus        | Apr   | Jun  |
| Schoenus cuspidatus     | Aug   | Nov  |
| Schoenus exilis         | Apr   | Jun  |
| Schoenus graminifolius  | Jul   | Nov  |
| Schoenus laticulmis     | May   | Dec  |
| Schoenus variabilis     | Apr   | June |
| Schoenus nigricans      | May   | Oct  |
| Tetraria capillacea     | Oct   | Nov  |
| Tetraria crinifolia     | Aug   | Oct  |
| Tetraria fasciata       | Nov   | May  |
| Tetraria ferruginea     | Mar   | Jul  |
| Tetraria flexuosa       | Jan   | May  |
| Tetraria fourcadei      | Jan   | May  |
| Tetraria maculata       | Dec   | Feb  |
| Tetraria ustulata       | Jan   | May  |
| Tetraria cernua         | Oct   | Nov  |
| Tetraria burmanii       | Nov   | Apr  |
| Tetraria fimbriolata    | Jan   | Apr  |
| Tetraria microstachys   | Dec   | Feb  |
| Tetraria nigrovaginata  | Jan   | Apr  |
| Tetraria pillansii      | Jan   | Feb  |
| Tetraria pubescens      | Oct   | Apr  |
| Tetraria pygmaea        | Feb   | Apr  |
| Tetraria vaginata       | Sep   | Apr  |
| Tetraria bromoides      | Oct   | Feb  |
| Tetraria eximia         | May   | Aug  |
| Tetraria involucrata    | Jan   | Apr  |
| Tetraria robusta        | Feb   | Mar  |
| Tetraria secans         | Apr   | May  |
| Tetraria thermalis      | Jun   | Oct  |
| Tetraria triangularis   | Feb   | Apr  |

Flowering times (start and end) for *Schoenus* L. and *Tetraria* Beauv.
(Cyperaceae, Tribe Schoeneae), from Manning and Goldblatt (2012).

Along with these data, taxonomic research groups these species into
three clades in each genus (*Schoenus* and *Tetraria*). That merely
explain the colour-coding used in the figures below.

For now, let’s unpack how to take `"Jan"`, `"Feb"`, `"Mar"` and turn it
into meaningful numerical data, and treat that data circularly such that
December and January are adjecent.

I will be using the [`tidyverse`]()-suite of packages for wrangling
these data. Briefly, if you are unfamiliar, the logic of
`tidy`-functions is:

``` r
data %>%
  verb1() %>%
  verb2() %>%
  verb3()
```

where `%>%` (the forward pipe) passes the results before the pipe to the
function ahead of the pipe, so that instead of `f(g(h(x)))` (nesting
gets confusing), we use `x %>% f() %>% g() %>% h()`, as in the above
example with `data` and `verb*()`.

### Flowering months as numerical data

First, we need to convert the monthly abbreviations into numbers. Simple
enough: `"Jan"` = 1, `"Feb"` = 2, etc. I apply this process for each
rows’ `flowering_start` and `flowering_end` values, row-by-row, using
[`purrr`]()–a functional programming package for R.

``` r
get_month_int <- function(month_abb) {
  # Converts "Jan", "Feb", etc. -> 1, 2, etc.
  map_int(month_abb, ~ifelse(.x %in% month.abb,
    which(month.abb == .x),
    NA
  ))
}
# Apply get_month_int() to the data
flowering_times <- flowering_times %>%
  mutate(
    flowering_start = get_month_int(flowering_start),
    flowering_end   = get_month_int(flowering_end)
  )
flowering_times
```

    ## # A tibble: 43 x 4
    ##    clade               species               flowering_start flowering_end
    ##    <chr>               <chr>                           <int>         <int>
    ##  1 Epischoenus spp.    Schoenus adnatus                    2             8
    ##  2 Epischoenus spp.    Schoenus complanatus               12             3
    ##  3 Epischoenus spp.    Schoenus dregeanus                 12             4
    ##  4 Epischoenus spp.    Schoenus gracilimus                12             3
    ##  5 Epischoenus spp.    Schoenus lucidus                   12            12
    ##  6 Epischoenus spp.    Schoenus quadrangula…              11             5
    ##  7 Epischoenus spp.    Schoenus neovillosus                1             2
    ##  8 S. compar-S. pictus Schoenus arenicola                  7            11
    ##  9 S. compar-S. pictus Schoenus compar                     4             6
    ## 10 S. compar-S. pictus Schoenus pictus                    12             5
    ## # ... with 33 more rows

Now, let’s create sequences of months that a species is in flower for,
starting at `flowering_start`, ending at `flowering_end`. This will be
embedded within the dataframe as a [*list-column*]()–where each entry in
the column is itself a list, nested in the dataframe. I apply this
process for each pair of `flowering_start`-`flowering_end` values,
again, using [`purrr`]()–a functional programming package for R.

``` r
get_month_seq <- function(start, end) {
  # Creates seq from start to end, unless end < start
  map2(start, end, function(.start, .end) {
    if (any(is.na(c(.start, .end)))) {
      return(NA)
    } else if (.start > .end) {
      return(c(.start:12, 1:.end))  # e.g. Dec->Apr = 12, 1, 2, 3, 4
    } else if (.start <= .end) {
      return(.start:.end)
    }
  })
}
flowering_times <- flowering_times %>%
  mutate(flowering_months = get_month_seq(flowering_start, flowering_end))
flowering_times
```

    ## # A tibble: 43 x 5
    ##    clade       species      flowering_start flowering_end flowering_months
    ##    <chr>       <chr>                  <int>         <int> <list>          
    ##  1 Epischoenu… Schoenus ad…               2             8 <int [7]>       
    ##  2 Epischoenu… Schoenus co…              12             3 <int [4]>       
    ##  3 Epischoenu… Schoenus dr…              12             4 <int [5]>       
    ##  4 Epischoenu… Schoenus gr…              12             3 <int [4]>       
    ##  5 Epischoenu… Schoenus lu…              12            12 <int [1]>       
    ##  6 Epischoenu… Schoenus qu…              11             5 <int [7]>       
    ##  7 Epischoenu… Schoenus ne…               1             2 <int [2]>       
    ##  8 S. compar-… Schoenus ar…               7            11 <int [5]>       
    ##  9 S. compar-… Schoenus co…               4             6 <int [3]>       
    ## 10 S. compar-… Schoenus pi…              12             5 <int [6]>       
    ## # ... with 33 more rows

Lastly, we just need to reshape this data into a form `ggplot2` can
understand: long-form data.

``` r
flowering_times <- flowering_times %>%
  unnest() %>% # unnest the list-columns so ggplot can understand
  # Arrange species by sub-generic clade
  arrange(clade) %>%
  mutate(species = factor(species, levels = unique(species)))
flowering_times
```

    ## # A tibble: 179 x 5
    ##    clade            species flowering_start flowering_end flowering_months
    ##    <chr>            <fct>             <int>         <int>            <int>
    ##  1 Epischoenus spp. Schoen…               2             8                2
    ##  2 Epischoenus spp. Schoen…               2             8                3
    ##  3 Epischoenus spp. Schoen…               2             8                4
    ##  4 Epischoenus spp. Schoen…               2             8                5
    ##  5 Epischoenus spp. Schoen…               2             8                6
    ##  6 Epischoenus spp. Schoen…               2             8                7
    ##  7 Epischoenus spp. Schoen…               2             8                8
    ##  8 Epischoenus spp. Schoen…              12             3               12
    ##  9 Epischoenus spp. Schoen…              12             3                1
    ## 10 Epischoenus spp. Schoen…              12             3                2
    ## # ... with 169 more rows

### Plotting flowering times

Now we can really plot this data:

``` r
flowering_plot <- 
  ggplot(flowering_times, aes(flowering_months, species, fill = clade)) +
    geom_tile() +
    scale_x_continuous(breaks = 1:12, labels = month.abb) +
    theme(
      axis.title.x = element_blank(),  # No need for x-axis title
      axis.text.y  = element_text(hjust = 0)  # Left-justify species names
    )
flowering_plot
```

    ## Warning: Removed 1 rows containing missing values (geom_tile).

![](2019-03-25-circular-data_files/figure-gfm/plot-flowering-times-linear-1.png)<!-- -->

It’s clear that all the (austral) summer flowering species
(`"Dec"`–`"Feb"`) could really benefit from a circular plot. Thus:

``` r
flowering_plot +
  # Make the plot circular
  coord_polar() +
  # Remove non-sensical y-axis details now that plot is circular
  theme(
    axis.text.y  = element_blank(),
    axis.title.y = element_blank()
  )
```

    ## Warning: Removed 1 rows containing missing values (geom_tile).

![](2019-03-25-circular-data_files/figure-gfm/plot-flowering-times-circular-1.png)<!-- -->

This is much more realistic. Problem is, it squashes up all the species
in the centre of the circle.

Perhaps a better summary would be a count of the number of species in
flower in a given month, for each clade. Like so:

``` r
flowering_times %>%
  filter(clade != "S. nigricans") %>%  # nly 1 species, remove for this plot
  ggplot(aes(flowering_months, fill = clade)) +
    geom_bar() +
    scale_x_continuous(breaks = 1:12, labels = month.abb) +
    coord_polar() +
    facet_wrap(~clade) +
    theme(
      axis.title.x    = element_blank(),
      axis.text.y     = element_blank(),
      axis.title.y    = element_blank(),
      strip.text      = element_blank()  # legend duplicates facet labels
    )
```

    ## Warning: Removed 1 rows containing non-finite values (stat_count).

![](2019-03-25-circular-data_files/figure-gfm/plot-flowering-times-circular-bars-1.png)<!-- -->

## Session info

I present here my machine’s state at time of writing, for
reproducibility’s sake.

``` r
sessionInfo()
```

    ## R version 3.5.0 (2018-04-23)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS  10.14.3
    ## 
    ## Matrix products: default
    ## BLAS: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] bindrcpp_0.2.2  forcats_0.3.0   stringr_1.3.1   dplyr_0.7.5    
    ##  [5] purrr_0.2.5     readr_1.1.1     tidyr_0.8.1     tibble_1.4.2   
    ##  [9] tidyverse_1.2.1 here_0.1        circular_0.4-93 ggplot2_2.2.1  
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] tidyselect_0.2.4 reshape2_1.4.3   haven_1.1.1      lattice_0.20-35 
    ##  [5] colorspace_1.3-2 htmltools_0.3.6  yaml_2.1.19      utf8_1.1.4      
    ##  [9] rlang_0.2.1      pillar_1.2.3     foreign_0.8-70   glue_1.2.0      
    ## [13] modelr_0.1.2     readxl_1.1.0     bindr_0.1.1      plyr_1.8.4      
    ## [17] cellranger_1.1.0 munsell_0.4.3    gtable_0.2.0     rvest_0.3.2     
    ## [21] mvtnorm_1.0-8    psych_1.8.4      evaluate_0.10.1  labeling_0.3    
    ## [25] knitr_1.20       parallel_3.5.0   highr_0.6        broom_0.4.4     
    ## [29] Rcpp_0.12.18     scales_0.5.0     backports_1.1.2  jsonlite_1.5    
    ## [33] mnormt_1.5-5     hms_0.4.2        digest_0.6.15    stringi_1.2.2   
    ## [37] grid_3.5.0       rprojroot_1.3-2  cli_1.0.0        tools_3.5.0     
    ## [41] magrittr_1.5     lazyeval_0.2.1   crayon_1.3.4     pkgconfig_2.0.1 
    ## [45] xml2_1.2.0       lubridate_1.7.4  rstudioapi_0.7   assertthat_0.2.0
    ## [49] rmarkdown_1.9    httr_1.3.1       R6_2.2.2         boot_1.3-20     
    ## [53] nlme_3.1-137     compiler_3.5.0

## Further reading

## References

<div id="refs" class="references">

<div id="ref-circular">

Agostinelli, C., and U. Lund. 2017. *R Package `circular`: Circular
Statistics (Version 0.4-93)*. CA: Department of Environmental Sciences,
Informatics; Statistics, Ca’ Foscari University, Venice, Italy. UL:
Department of Statistics, California Polytechnic State University, San
Luis Obispo, California, USA.
<https://r-forge.r-project.org/projects/circular/>.

</div>

<div id="ref-manning2012">

Manning, John, and Peter Goldblatt. 2012. *Plants of the Greater Cape
Floristic Region. 1: The Core Cape Flora.* South African National
Biodiversity Institute.

</div>

<div id="ref-ggplot2">

Wickham, Hadley. 2009. *Ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York. <http://ggplot2.org>.

</div>

<div id="ref-elliott2018">

n.d.

</div>

</div>
