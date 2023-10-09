TV Ratings
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

# tvrating

<!-- badges: start -->
<!-- badges: end -->

The goal of tvrating is tointroduce the user to the package and aid them
with using it.

## Installation

You can install the development version of tvrating from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ETC5523-2023/rpkg-bilallovesbatman")
```

# Loading the Package

To be able to use the package and access the data, the user must load
`tvrating` from the library and calling the object `tvrating`

# Use-case Examples

## Example 1: 5-Number Summary

This package contains functions that allows users to be able to process
or manipulate the data. As an example, the user can use the `summary_tv`
function to calculate the famous **five number summary** of the show
ratings (column: `av_rating`) i.e. minimum, Q1, median, Q3, maximum.
Returns NULL if inputs are less than a total of 5.

``` r
summary_tvrating(tv_ratings)
#>           Statistic   Value
#> 1           Minimum 2.70390
#> 2 1st Quartile (Q1) 7.73130
#> 3            Median 8.11485
#> 4 3rd Quartile (Q3) 8.48985
#> 5           Maximum 9.68240
```

## Example 2: Genre Distribution

Another example is being able to plot the genre distribution plot based
on the selected top genres using the filter. The user must use the
following command:

``` r
genre_plot(tv_ratings, selected_genre = 5)
#> PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
```

<div class="plotly html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-4627c4a279137f55852b" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-4627c4a279137f55852b">{"x":{"data":[{"orientation":"h","width":[0.90000000000000036,0.90000000000000036,0.90000000000000036,0.90000000000000013,0.89999999999999991],"base":[0,0,0,0,0],"x":[2266,822,558,516,387],"y":[5,4,3,2,1],"text":["reorder(genres, n): Drama<br />n: 2266<br />Genre:  Drama <br>Count:  2266","reorder(genres, n): Crime<br />n:  822<br />Genre:  Crime <br>Count:  822","reorder(genres, n): Mystery<br />n:  558<br />Genre:  Mystery <br>Count:  558","reorder(genres, n): Comedy<br />n:  516<br />Genre:  Comedy <br>Count:  516","reorder(genres, n): Action<br />n:  387<br />Genre:  Action <br>Count:  387"],"type":"bar","textposition":"none","marker":{"autocolorscale":false,"color":"rgba(0,0,128,1)","line":{"width":1.8897637795275593,"color":"transparent"}},"showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":26.228310502283104,"r":7.3059360730593621,"b":53.731838937318386,"l":100.62266500622668},"plot_bgcolor":"rgba(255,255,255,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.611872146118724},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-113.30000000000001,2379.3000000000002],"tickmode":"array","ticktext":["0","500","1000","1500","2000"],"tickvals":[1.4210854715202004e-14,499.99999999999994,1000,1500.0000000000002,2000.0000000000002],"categoryorder":"array","categoryarray":["0","500","1000","1500","2000"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0.66417600664176002,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":19.9252801992528},"tickangle":-0,"showline":true,"linecolor":"rgba(0,0,0,1)","linewidth":0.66417600664176002,"showgrid":false,"gridcolor":null,"gridwidth":0,"zeroline":false,"anchor":"y","title":{"text":"Number of Shows","font":{"color":"rgba(0,0,0,1)","family":"","size":19.9252801992528}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.40000000000000002,5.5999999999999996],"tickmode":"array","ticktext":["Action","Comedy","Mystery","Crime","Drama"],"tickvals":[1,2,3,4,5],"categoryorder":"array","categoryarray":["Action","Comedy","Mystery","Crime","Drama"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.6529680365296811,"tickwidth":0.66417600664176002,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":19.925280199252807},"tickangle":-0,"showline":true,"linecolor":"rgba(0,0,0,1)","linewidth":0.66417600664176002,"showgrid":false,"gridcolor":null,"gridwidth":0,"zeroline":false,"anchor":"x","title":{"text":"Genre","font":{"color":"rgba(0,0,0,1)","family":"","size":19.9252801992528}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.8897637795275593,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.68949771689498}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"source":"A","attrs":{"7102bfa30df":{"x":{},"y":{},"text":{},"type":"bar"}},"cur_data":"7102bfa30df","visdat":{"7102bfa30df":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

The distribution of different genres is plotted based on the user’s
selection on the filter.
