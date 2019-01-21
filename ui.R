library(shiny)
library(shinythemes)
library(shinyjs)
library(markdown)
library(DT)
library(shinyjqui)
library(shinycssloaders)

shinyUI(fluidPage(
  # Add Javascript
  tags$head(
    tags$link(rel="stylesheet", type="text/css",href="style.css"),
    tags$head(includeScript("google-analytics.js")),
    tags$script(type="text/javascript", src = "md5.js"),
    tags$script('!function(d,s,id){var js,fjs=d.getElementsByTagName(s)    [0],p=/^http:/.test(d.location)?\'http\':\'https\';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");')
    
  ),
  
  useShinyjs(),
  headerPanel(
    list(tags$head(tags$style("body {background-color: white; }")),
         "PhenoCLIM", HTML('<img src="picture2.png", height="100px",  
                           style="float:left"/>','<p style="color:orange"> Phenotype x Environment explorer </p>' ))
  ),
  
  
  
  theme = shinytheme("journal") , 
  tabsetPanel(              
    tabPanel(type = "pills", title = "Climate explorer",
  
  uiOutput("app"),

  # Sidebar 
  # Sidebar
  jqui_draggabled((
    sidebarPanel(
      width = 3,
      wellPanel(
        uiOutput('xvar'),
        uiOutput('yvar'),
        selectInput("pal", "Color palette",
                    selected = 'Spectral',
                    rownames(subset(
                      brewer.pal.info, category %in% c("seq", "div")
                    ))),
        uiOutput("ui")
      ),
      wellPanel(a(h4('Please cite us in any publication that utilizes information from CLIMtools:'),  href = "https://www.nature.com/articles/s41559-018-0754-5", h6('Ferrero-Serrano, Á & Assmann SM. Phenotypic and genome-wide association with the local environment of Arabidopsis. Nature Ecology & Evolution. doi: 10.1038/s41559-018-0754-5 (2019)' ))),
      wellPanel(
        a("Tweets by @ClimTools", class = "twitter-timeline"
          , href = "https://twitter.com/ClimTools"),
        style = "overflow-y:scroll; max-height: 1000px"
      ),
      h6('Contact us: clim.tools.lab@gmail.com'), wellPanel(tags$a(div(
        img(src = 'github.png',  align = "middle"), style = "text-align: center;"
      ), href = "https://github.com/CLIMtools/PhenoCLIM"))
    )
    
    
    ###################################################
  )),
  
  
  
  
  mainPanel(

    fixedRow(column(
      12, h3(textOutput("selected_var")), wellPanel(leafletOutput("map"))
    )),
    fixedRow(
      column(
        12,
        jqui_draggabled(fluidRow(
          wellPanel(
            div(style = "height: 435px;", style = "padding:20px;",
                ggvisOutput("p"))
          ))),
        jqui_draggabled(wellPanel(fluidRow(
          column(
            width = 6,
            h3(textOutput("selected_bothb")),
            div(style = "height: 250px;",
                ggvisOutput("p2"))
          ),
          column(
            width = 6,
            h3(textOutput("selected_bothc")),
            div(style = "height: 250px;",
                ggvisOutput("p3"))
          )
        )))
      )
    )
  )
    ),
 tabPanel(title = "Description of Phenotypes",  mainPanel(fixedRow(width=4,
                                                                          withSpinner(dataTableOutput("PHENOTYPES"))))),
 tabPanel(title = "Description of climate variables",  mainPanel(fixedRow(width=4,
                                                                           withSpinner(dataTableOutput("a"))))),
tabPanel(title = "About",  mainPanel(h1(div('About PhenoCLIM', style = "color:red")), 
                                     h3(div('PhenoCLIM, provides an intuitive tool to define the environment at the site of origin of each of the 1,131 geo-referenced accessions sequenced as part of the 1,001 Genomes Project', style = "color:grey")),
                                     h3(div(strong("PhenoCLIM"),'PhenoCLIM is a SHINY component of CLIMtools. PhenoCLIM provides an interactive spatial analysis web platform using Leaflet. Data points represent the sites of collection of sequenced accessions in an interactive world map. ', style = "color:grey")),
                                     h3(div('PhenoCLIM allows the user to analyze a phenotypic trait of interest with the local environmental conditions for these 1,131 accessions using the ggvis package in SHINY. The phenotypic variable selected on the map can be compared with any environmental variable that is user-specified; for intial data inspection, the two variables are displayed with a reactive linear correlation providing a correlation between the phenotipic trait and environmental variable of interest. We also provide two different interactive tabulated databases describing the phenotypic and environmental variables available at PhenoCLIM using the DT package in SHINY.', style = "color:grey")),
                                     h3(''),
                                     
                                     
                                     div(tags$a(img(src='shiny.png',  height="100px"),href="https://shiny.rstudio.com/"),
                                         tags$a(img(src='rstudio.png',  height="100px"),href="https://www.rstudio.com/"),
                                         tags$a(img(src='leaflet.png',  height="100px"),href="http://leafletjs.com/"),
                                         tags$a(img(src='1001.png',  height="100px"),href="http://1001genomes.org/"),  align="middle", style="text-align: center;"),
                                     
                                     h3(''),
                                     h3(''),
                                     tags$a(div(img(src='climtools.png',  align="middle"), style="text-align: center;"), href="http://www.personal.psu.edu/sma3/CLIMtools.html"),
                                     tags$a(div(img(src='climtools logo.png',  align="middle"), style="text-align: center;"), href="http://www.personal.psu.edu/sma3/CLIMtools.html"),
                                     
                                     h3(''),
                                     tags$a(div(img(src='assmann_lab.png',  align="middle"), style="text-align: center;"), href="http://www.personal.psu.edu/sma3/index.html")


  )))

))


