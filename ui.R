library(shiny)
menuoptions<-c("Aberdeen", "Aberdeenshire", "Angus", "Argyll and Bute", "Clackmannanshire", 
               "Dumfries and Galloway", "Dundee", "East Ayrshire", "East Dunbartonshire", 
               "East Lothian", "East Renfrewshire", "Edinburgh", "Eilean Siar", 
               "Falkirk", "Fife", "Glasgow", "Highland", "Inverclyde", "Midlothian", 
               "Moray", "North Ayrshire", "North Lanarkshire", "Orkney", "Perth and Kinross", 
               "Renfrewshire", "Scottish Borders", "Shetland Islands", "South Ayrshire", 
               "South Lanarkshire", "Stirling", "West Dunbartonshire", "West Lothian"
)

shinyUI(pageWithSidebar(
 headerPanel ("Scottish local authority waste and recycling, 2011-2013"),
 sidebarPanel(
  h3("Use this menu to choose the target local authority and the data you want to see"),
  selectInput("la",label = "Choose your local authority",choices = menuoptions,selected = "Aberdeen"),
  h3("Use this menu to choose the target local authority and the data you want to see"),
  selectInput(inputId="variable",label = "Choose your variable",choices = c("waste","recycling"),selected = "waste")
  ),
 mainPanel (
  h5 ("To use this page, select a local authority and a variable (total waste arising in tonnes 
      or percentage recycling rate) from the dropdown menus on the left. This page will return the 
      values for the calendar years 2011-13, and will plot these values alongside the median value 
      for all Scottish councils. All data are taken from the website of the Scottish Environmental 
      Protection Agency (SEPA). Data for 2014 are due to be published in September 2015."),
  h1 ("Results"),
  h3 ("Council you chose"),
  verbatimTextOutput("council"),
  h3 ("The score values for your council"),
  verbatimTextOutput("values"),
  h3 ("Selected authority performance relative to Scottish median performance"),
  plotOutput("plot")
 )
)
)