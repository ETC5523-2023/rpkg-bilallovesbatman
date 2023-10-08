library(tvrating)
library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(DT)
library(markdown)

ui <- dashboardPage(
  dashboardHeader(title = "The Golden Era of TV"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "introduction"),
      menuItem("Genres", tabName = "genres"),
      menuItem("Shows", tabName = "shows"),
      menuItem("About", tabName = "about")
    ),
    includeCSS("styles.css")
  ),
  dashboardBody(
    tabItems(
      tabItem("introduction",
              h1(strong("Welcome to the", em(style = "color: darkorange;", "Golden"), " Era of TV!", "\U0001F4FA")),
              p(style = "font-size: 22px;",
                "In this shiny app, we will explore what is dubbed as 'The Golden Age of TV'. The era is normally disputed where 1950s was originally called the golden era.
              However, there is belief that the era either refreshes periodically or continues on. For all we know, we have been treated with some", strong("quality"), "shows over the years.
              So, we will dive into the genres and see how they heave performed.
                Once we are satisfied by the genre performances, we go deeper and explore what shows are analyzed and how they have performed together with how many seasons of a show
                were released. So..."

                ),

              h1(style = "text-align: center;",strong("Who Takes The Throne?", "\U0001F5E1")),
              img(src = "throne.jpg", style = "display: block; margin: 0 auto; width: 700px; height: 500px;")
      ),
      tabItem("genres",
              h2("Analyzing the Genres", "\U0001F3A4"),
              p(style = "font-size: 16px;",
                "Genre is a term that baffles a lot of people when you question
                them 'Hey, what genre of shows do you prefer?' I always wondered that does it even matter?
                It just might...", "\U0001F914"),
              fluidRow(
                box(title = "Distribution by Genre",
                    width = 9,
                    plotlyOutput("genre_plot")),
                box(width = 3,
                    radioButtons("top_genres",
                                 label = "Please Select Top Genres:",
                                 choices = c("Top 3" = 3,
                                             "Top 5" = 5,
                                             "Top 10" = 10),
                                 selected = 3))
              ),
              fluidRow(
                box(title = "Performance by Genre",
                    width = 9,
                    selectInput("radar_attribute",
                                label = "Select Option:",
                                choices = c("Average Rating", "Share"),
                                selected = "Average Rating"),
                    plotlyOutput("radar_chart"))
              )
      ),
      tabItem("shows",
              h2("Explore TV Shows \U0001F3A5"),
              fluidRow(
                box(title = "Show Popularity Over Time",
                    width = 6,
                    selectInput("selected_show",
                                label = "Select a Show: ",
                                choices = unique(tv_ratings$title),
                                ifelse("Game of Thrones" %in% unique(tv_ratings$title), "Game of Thrones", unique(tv_ratings$title)[1])),
                    plotlyOutput("show_popularity_plot")),
                box(title = "Shows by Most Shares",
                    width = 6,
                    DTOutput("shows_table"))
              ),
              fluidRow(
                box(title = "Show Continuity (Seasons)",
                    width = 6,
                    plotlyOutput("show_duration_plot")),

                box(title = "Top Rated Seasons",
                    width = 6,
                    plotlyOutput("top_rated_seasons")),
                box(title = "Relationships",
                    width = 12,
                    radioButtons("relationship_radio",
                                 label = "Select Relationship: ",
                                 choices = c("Number of Seasons vs Average Ratings",
                                             "Popularity vs Average Ratings"),
                                 selected = "Number of Seasons vs Average Ratings"),
                    plotlyOutput("relationship_plot"))
              )
              ),
      tabItem("about",
              h2("About"),
              div(class = "about",
                  includeMarkdown("about.md")))
  )
  )
)

server <- function(input, output) {

  separate_genres <- tv_ratings |>
    separate_rows(genres, sep = ",")

  output$genre_plot <- renderPlotly({
    top_genres <- as.numeric(input$top_genres)

    genre_count <- separate_genres |>
      count(genres, sort = TRUE) |>
      slice_max(order_by = n, n = top_genres)


    p1 <- ggplot(genre_count,
                 aes(
                   x = reorder(genres, n),
                   y = n,
                   text = paste("Genre: ", genres, "<br>Count: ", n)
                 )) +
      geom_bar(stat = "identity",
               fill = "navy") +
      coord_flip() +
      labs(x = "Genre",
           y = "Number of Shows") +
      theme_classic() +
      theme(axis.text.x = element_text(size = 15),
            axis.text.y = element_text(size = 15),
            axis.title.x = element_text(size = 15),
            axis.title.y = element_text(size = 15))

    ggplotly(p1)
  })

  output$radar_chart <- renderPlotly({
    top_genres <- as.numeric(input$top_genres)
    selected_attribute <- input$radar_attribute

    if (selected_attribute == "Average Rating") {
      genre_ratings <- separate_genres %>%
        group_by(genres) %>%
        summarise(attribute = mean(av_rating)) %>%
        slice_max(order_by = attribute, n = top_genres)
    } else if (selected_attribute == "Share") {
      genre_ratings <- separate_genres %>%
        group_by(genres) %>%
        summarise(attribute = mean(share)) %>%
        slice_max(order_by = attribute, n = top_genres)
    }

    p2 <- plot_ly(genre_ratings,
              theta = ~genres,
              r = ~attribute,
              type = "scatterpolar",
              fill = "toself",
              text = ~paste("Genre: ", genres, "<br>", selected_attribute, ": ", attribute))

    p2
  })

  output$show_duration_plot <- renderPlotly({
    show_durations <- tv_ratings |>
      group_by(title) |>
      summarise(num_season = n_distinct(seasonNumber))

    p3 <- ggplot(show_durations,
                 aes(
                   x = num_season
                 )) +
      geom_histogram(binwidth = 1, fill = "darkred", color = "black") +
      labs(x = "Number of Seasons",
           y = "Number of Shows",
           title = "Distribution of Show Durations") +
      theme_minimal()

    ggplotly(p3)

  })

  output$show_popularity_plot <- renderPlotly({

    selected_show <- input$selected_show

    selected_show_data <- tv_ratings |>
      filter(title == selected_show) |>
      mutate(date = as.Date(date))

    p4 <- plot_ly(selected_show_data,
                  x = ~date,
                  y = ~share,
                  type = "scatter",
                  mode = "lines + markers",
                  text = ~paste("Season: ", seasonNumber,
                                "<br>Share: ", share,
                                "<br>Date: ", format(date, "%Y-%m-%d"))) |>
      layout(title = paste("Popularity Trend for", selected_show),
             xaxis = list(title = "Release Date"),
             yaxis = list(title = "Share"))
    p4

  })

  output$top_rated_seasons <- renderPlotly({
    top_rated <- tv_ratings |>
      group_by(title) |>
      summarise(avg_rating = mean(av_rating),
                num_seasons = n_distinct(seasonNumber)) |>
      arrange(desc(avg_rating)) |>
      slice_max(avg_rating, n = 10)

    top_rated$avg_rating <- round(top_rated$avg_rating, 2)

    p5 <- plot_ly(top_rated,
                  x = ~avg_rating,
                  y = ~reorder(title, avg_rating),
                  type = "bar",
                  hoverinfo = "y+text",
                  text = ~paste("<br>Seasons: ", num_seasons, "<br>Avg Rating: ", avg_rating),
                  marker = list(color = "darkgreen")) |>
      layout(title = "Top Rated Shows",
             xaxis = list(title = "TV Show"),
             yaxis = list(title = "Average Rating"))
    p5
  })

  output$relationship_plot <- renderPlotly({
    selected_relationship <- input$relationship_radio

    if (selected_relationship == "Number of Seasons vs Average Ratings") {
      seasons_rating_scatter <- tv_ratings |>
        group_by(title) |>
        summarise(avg_rating = round(mean(av_rating), 2),
                  num_seasons = n_distinct(seasonNumber)) |>
        arrange(num_seasons)

      p6 <- plot_ly(seasons_rating_scatter,
                    x = ~num_seasons,
                    y = ~avg_rating,
                    type = "scatter",
                    mode = "markers",
                    text = ~paste("Show: ", title, "<br>Seasons: ", num_seasons, "<br>Avg Rating: ", avg_rating),
                    hoverinfo = "text",
                    marker = list(color = "#6A0DAD")) |>
        layout(title = "Number of Seasons vs Average Ratings",
               xaxis = list(title = "Number of Seasons"),
               yaxis = list(title = "Average Rating"))
      p6
    } else if (selected_relationship == "Popularity vs Average Ratings") {
      popularity_rating_scatter <- tv_ratings |>
        group_by(title) |>
        summarise(avg_rating = round(mean(av_rating), 2),
                  avg_share = round(mean(share), 2))
      p7 <- plot_ly(popularity_rating_scatter,
                    x = ~avg_rating,
                    y = ~avg_share,
                    type = "scatter",
                    mode = "markers",
                    text = ~paste("Show: ", title,"<br>Average Rating: ", avg_rating, "<br>% Average Share: ", avg_share),
                    hoverinfo = "text",
                    marker = list(color = "#6A0DAD")) |>
        layout(title = "Popularity vs Average Ratings",
               xaxis = list(title = "Average Rating"),
               yaxis = list(title = "% Average Share"))
      p7
    }
  })

  output$shows_table <- renderDataTable({

    all_show_data <- tv_ratings |>
      select(title, seasonNumber, date, share) |>
      mutate(date = format(as.Date(date), "%d-%m-%Y"),
             seasonNumber = as.integer(seasonNumber),
             share = round(share, 2))

    datatable(all_show_data, options = list(pageLength = 10))
  })
}

shinyApp(ui = ui, server = server)


