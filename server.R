library(shiny)
scotland<-structure(list(
     council = structure(1:32, .Label = c("Aberdeen", 
                                          "Aberdeenshire", "Angus", "Argyll and Bute", "Clackmannanshire", 
                                          "Dumfries and Galloway", "Dundee", "East Ayrshire", "East Dunbartonshire", 
                                          "East Lothian", "East Renfrewshire", "Edinburgh", "Eilean Siar", 
                                          "Falkirk", "Fife", "Glasgow", "Highland", "Inverclyde", "Midlothian", 
                                          "Moray", "North Ayrshire", "North Lanarkshire", "Orkney", "Perth and Kinross", 
                                          "Renfrewshire", "Scottish Borders", "Shetland Islands", "South Ayrshire", 
                                          "South Lanarkshire", "Stirling", "West Dunbartonshire", "West Lothian"
     ), class = "factor"),
     waste_2011 = c(97184L, 148053L, 62200L, 46301L, 30598L, 81526L, 68368L, 61087L, 58997L, 53163L,
                    45193L, 189697L, 16497L, 78177L, 214551L, 250708L, 125455L, 33937L, 43849L, 52334L, 68312L,
                    160248L, 10255L, 79918L, 82571L, 53822L, 11792L, 58475L, 163214L, 44024L, 41169L, 74988L),
     waste_2012 = c(97242L, 134708L, 60803L, 48509L, 27737L, 77709L, 70103L, 58793L, 55233L, 52346L, 
                    43986L, 187741L, 14299L, 76111L, 195595L, 234209L, 126183L, 33248L, 42701L, 49883L, 62729L,
                    155838L, 10233L, 75015L, 82126L, 52861L, 10865L, 57627L, 151923L, 43190L, 38944L, 72345L),
     waste_2013 = c(94117L, 131811L, 54258L, 49244L, 26797L, 75501L, 61485L, 58282L, 51997L, 49335L,
                    44057L, 184360L, 12738L, 71950L, 190784L, 227940L, 125651L, 29183L, 40177L, 47533L, 61908L,
                    152729L, 9923L, 74267L, 78417L, 51242L, 10141L, 55423L, 144734L, 39923L, 36206L, 70592L),
     recycling_2011 = c(35.7, 33.6, 41.8, 29.6, 52, 21.5, 32.4, 46.8, 37.7, 44.1, 53.2, 31.1, 26.5,
                        52.7, 54, 26.7, 44.5, 41.2, 47.2, 44.6, 51.8, 39.4, 30.1, 52.3, 42.3, 46.3, 16.7, 48.2, 35.3,
                        53.5, 45, 43.6),
     recycling_2012 = c(37.3, 35.6, 40.1, 31.5, 58.9, 22.2, 29.7, 44.4, 38.7, 44.8, 54.2, 36.7, 29.7,
                        55.2, 52.8, 29.5, 44.3, 50.7, 45.3, 51.9, 51.8, 39.8, 22.5, 55, 38.9, 42.8, 13.5, 47.5, 37.4, 
                        55.7, 44.1, 43),
     recycling_2013 = c(37.1, 35.8, 43.2, 36.1, 59.9, 23.9, 31.1, 48.8, 44.9, 42.3, 56.3, 38.1, 33.6,
                        53, 55.9, 26.9, 45, 55.5, 42.3, 51.4, 56.1, 42.3, 30.8, 54, 44.3, 41.3, 12.2, 44.3, 39.1,
                        53.7, 44, 44.3)),
     .Names = c("council", 
                "waste_2011", "waste_2012", "waste_2013", "recycling_2011", "recycling_2012",
                "recycling_2013"), class = "data.frame", row.names = c(NA, -32L
                ))

# This grabs the data values for the text report
grabvalues<-function (authority,query) {
 waste<-2:4; recycling<-5:7
 scotland[which(scotland$council==authority),eval(parse(text=query))]
}

#This generates the output plot
makeplot<-function(authority,query) {
 waste<-2:4; recycling<-5:7; year<-(2011:2013)
 la_index<-which(scotland$council==authority)
 if (query=="waste") {
  z<-waste
  plotdata<-scotland[la_index,z]
  aveval<<-sapply(X = scotland[,z], median)
  max_y<-max(c(max(aveval),max(plotdata)))+10000
  mid_y<-max_y/2
  plot(x=year,y=plotdata,type="l",col="red",ylim=c(0,max_y),axes=FALSE,xlab="Year",ylab="Household waste (tonnes)")
  axis(side=1,at=year)
  axis(side=2, at=c(0,round(mid_y,-3),round(max_y,-3)))
  lines(x=year,y=aveval,col="blue")
  legend("bottom",legend = c(authority, "Scottish median"),lty=1,col=c("red","blue"))
 } else {
  z<-recycling
  plotdata<-scotland[la_index,z]
  aveval<<-sapply(X = scotland[,z], median)
  max_y<-max(c(max(aveval),max(plotdata)))+10
  mid_y<-max_y/2
  plot(x=year,y=plotdata,type="l",col="red",ylim=c(0,max_y),axes=FALSE,xlab="Year",ylab="Recycling rate (%)")
  axis(side=1,at=year)
  axis(side=2, at=c(0,round(mid_y,-1),round(max_y,-1)))
  lines(x=year,y=aveval,col="blue")
  legend("bottom",legend = c(authority, "Scottish median"),lty=1,col=c("red","blue"))
 }
}

shinyServer(
 function(input,output) {
  output$council<-renderPrint({input$la})
  output$values<-renderPrint ({grabvalues(input$la,input$variable)})
  output$plot<-renderPlot({
   makeplot(input$la,input$variable)
  })
 }
)
 
 