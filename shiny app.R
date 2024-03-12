
library(jpeg)
library(raster)
library(shiny)
library(DT)

button_color_css <- "
#DivCompClear, #FinderClear, #EnterTimes{
/* Change the background color of the update button
to blue. */
background: DodgerBlue;
/* Change the text size to 15 pixels. */
font-size: 15px;
}"

intro_panel <- tabPanel(
  "Introduction", icon = icon("fa-sharp fa-solid fa-house"),
  
  titlePanel("Introduction"),
  p(h3("Group members: Kaiwei Xiao, Zijia Wang and Tianjie Xie.", align = "center")),
  HTML('<center><img src = "https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F398354579%2F86754714571%2F1%2Foriginal.20221122-210150?w=940&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C417%2C1666%2C833&s=99eca437d872c3fc8df7c1a2de2fc0e2" width="400"></center>'),
  p("This is a R shiny app for Innovate CO Data Challenge. Our group designs an app to analyze the question 3:"), 
  p( em("How can Colorado address the challenge of balancing energy demands for its growing population and economy with the need for conservation and sustainability?")),
  p("As Colorado's population and economy continue to grow, so too does the demand for energy. However, as we strive towards a sustainable future, it is crucial to balance this energy demand with the need for conservation and sustainability. Colorado faces a unique challenge in this regard, as it is home to a diverse range of communities and industries with varying energy needs. In order to address this challenge, it is important to consider a range of strategies and solutions, such as increasing the use of renewable energy sources, improving energy efficiency, and promoting sustainable practices in both the public and private sectors. By taking a comprehensive and collaborative approach, we can work towards a more sustainable and resilient energy future for Colorado."),
  HTML('<center><img src = "https://www.solarreviews.com/content/images/blog/post/focus_images/953_renewable-resources-no-title.png" width="600"></center>'),
  p("As we explore strategies for balancing energy demands in Colorado, it is important to consider a range of renewable energy resources. Four key resources that we will consider are solar, wind, biofuel, and nuclear. Solar energy is abundant in Colorado, with an average of 300 days of sunshine per year, making it a promising option for renewable energy. Wind energy is also a viable option in certain regions of the state. However, it is worth noting that the map shows limited potential for wind power generation in Colorado. Biofuel is another renewable energy resource, but due to concerns about land use and food security, we will not consider it as a primary option in this analysis. Finally, nuclear energy, while often touted as a viable option for clean energy, is not currently utilized in Colorado, with the state having no nuclear power plants. By considering the potential of solar and wind energy, as well as exploring new options for clean energy, we can work towards a more sustainable and resilient energy future for Colorado.")
)

second_panel <- tabPanel("Wind Map",icon = icon("globe-americas"), 
                         p(h3("US Continues 100m mean wind map", align = "center")),
                         plotOutput("wind"),
                         p("Based on the US Continues 100m mean wind map, we can see that most of the strong wind resources are located offshore, while the onshore wind resources are generally weaker. This means that areas such as Colorado may have limited potential for wind power generation, as the wind speeds may not be sufficient to generate significant amounts of electricity. However, this discovery has led us to explore other renewable resources such as solar power. With its abundant sunshine, Colorado has great potential for solar power generation, making it a viable alternative to wind power."))

last_panel <- tabPanel("Data", DT::dataTableOutput("data"),icon = icon("table"))
  
ui <- navbarPage(
  "Innovate CO Data Challenge",
  intro_panel,
  second_panel,
  last_panel
)


windmaprgb <- brick("wtk_conus_100m_mean_masked.tif")
spg <- read.csv("spg.csv")

server <- function(input, output) {
  # assign values to `output` here
  
  
  output$wind = renderPlot({plot(windmaprgb)
  })  
  
  output$data <-DT::renderDataTable(datatable(spg))
}

shinyApp(ui = ui, server = server)