#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  
  theme = shinytheme("sandstone"),
  "Cost estimation",
  # Top page (UI)------------
  tabPanel("Introduction",
           fluidRow(
             column(12, 
                    h2("Resource Requirements for Essential Universal Health Coverage", align = "center"),
                    h3("A modelling study based on findings from Disease Control Priorities, 3rd Edition", align = "center"),
                    br(),

fluidRow(
  column(1,""),
  column(10,
         h4(strong("Abstract"), align = "center"),
         h5(strong("Background:"),br(),"Disease Control Priorities, 3rd Edition (DCP3) recently published two model health benefits packages
            (HBPs). This study estimates the overall costs and components of costs of these packages in low- and
            lower-middle-income countries.", br(),
                       strong("Methods:"), br(),"We developed the Disease Control Priorities Cost Model (DCP-CM) for the 218 health sector
            interventions recommended in DCP3’s model HBP (termed “essential UHC” [EUHC]). Model inputs
            included published and grey literature data on intervention unit costs, demographic and epidemiological
            data, coverage indicators, and estimates of required health system costs to support direct service delivery.
            We estimated counterfactual annual costs for the year 2015. We disaggregated costs according to
            intervention characteristics and performed sensitivity analyses.",br(),
                       strong("Findings:"),br(),"At 80% population coverage, EUHC would cost about US$ 80 per capita (in 2016 US dollars) in lowincome countries and US$ 130 per capita in lower-middle-income countries. As a share of national
            income, additional investments would require about 8% and 4% in low- and lower-middle-income
            countries, respectively. A “highest priority” sub-package would cost roughly half these amounts.
            Mortality-reducing interventions would require about two-thirds of costs. Interventions addressing
            chronic health conditions and interventions delivered in health centres would each comprise the plurality
            of costs.",br(),
                       strong("Interpretation:"),br(),"Implementation of EUHC would require costly investment, especially in low-income countries. DCP-CM
            is available as an online tool that can inform local HBP deliberation and support efficient investment in
            UHC, especially as countries pivot towards noncommunicable disease and injury care.",br(),
                       strong("Funding:"), br(),"Bill & Melinda Gates Foundation, Trond Mohn Foundation, and Norwegian Agency for Development
            Cooperation (Norad)."
, align = "left"),
          br(),
          h5(strong("Data source:"),"All the source codes and input data are avaialable in the following GitHub account:",
            a(href="https://github.com/yoshitok/DCP3_LGH", "link to GitHub")),
          br(),
          h5(strong("Instruction to use this app:"),br(), 
             strong("Step 1:"), "Open 'INPUT Data' tab to check the original data and the assumptions we made for each intervention.",
             br(), 
             strong("Step 2:"), "Open 'EDITABLE TABLE' tab to modify the input data (i.e., adjusted unit cost (USD 2016), population in need, baseline coverage )",
             br(),
             strong("*Please open both LIC and LMIC tables in step 2. Without that, you would find an error message", style = "color:red"),
             br(),
             strong("Step 3:"), "Open 'RESULT' tab to see the summary table and figures based on the changes you made in the editable tables",
             br(),
             strong("Senario analysis"), "In 'SENARIO ANALYSIS' tab, you can conduct one-, two- or multi-way sensitivity analyses by changing the default settings 
             (i.e., target coverage, tradable ratio, ancillary facility cost and above facility cost as well as multipliers)"
             )),
          column(1,"")
),
fluidRow(column(1,""),
         column(10,h6("last updated 24 03 2020", align = "right")),
         column(1,""))





)
           ))
  ,
  
  tabPanel("Input data",
           fluidRow(
             column(1,""),
             column(5,strong("Instruction"),br(),"In this tab, you can check the detail of input data by clicking '+' button next to the 'Code' column.
                    Also, you can change the tradable ratio to see how the adjusted costs change in LIC and LMIC"),
             column(3, sliderInput(inputId = "tradable2",
                                    "Tradable ratio",
                                    min=0, max = 1, value=0.3,step=0.1)),
             column(2, downloadButton(outputId = "downloadinputdata", "Download input data")),
             column(1,"")),
             fluidRow(
               column(1,""),
               column(width = 10, height = "auto", DT::dataTableOutput("raw.table")),
               column(1,""))
           ),
  
  # Setting page (UI)------------
  tabPanel("Editable table",
           fluidRow(
             column(1,""),
             column(10, strong("Instruction"), br(),
                    p("In this tab, you can modify the following four values for each intervention to generate the results:
                      i) Adjusted unit cost (USD 2016), ii) population in need, iii) baseline coverage and iv) target coverage",
                      br(),
                      "Also, you can include/exclude the interventions in the analysis by changing 'Custom package' column. 
                      Based on the revised tables, the total and incremental costs will be automatically calculated in the 'RESULT' tab.",
                      strong("Again, please open both LIC and LMIC tables even if you do not want to change anything. 
                           It is the necessary action to calculate the results", style = "color:red"))
                    ),
             column(1,"")
                    ),
           fluidRow(
             column(1,""),
             column(10,  height = "auto",            
                    tabsetPanel(type = "tabs",
                                tabPanel("LIC", rHandsontableOutput("hot")),
                                tabPanel("LMIC", rHandsontableOutput("hot.lmic"))
             ),
             downloadButton(outputId = "downloadeditData_LIC", "Download the LIC editable table"),
             downloadButton(outputId = "downloadeditData_LMIC", "Download the LMIC editable table")
             
             ),
             column(1,"")
           )

),
  tabPanel("Result",
           sidebarPanel(
             h5(strong("Results based on the editable tables"), align = "center" ),
             p("The 'custom package'in the right table and figures are based on the changes you made in the 'EDITABLE TABLE' tab.",
               strong("If you see the error message, please go to 'EDITABLE TABLE' tab and open both LIC and LMIC tables.", style = "color:red"),
               br(), br(),
                "The percentages of ancillary facility cost and above health facility costs are fixed as 17% and 50% respectively.
               Also, the total and incremental costs in the table are shown with two significant digits.", 
               br(), br(),
               "If you do not change anything in 'EDITABLE TABLE' tab, the result of custom package should be the same as that of HPP.",
               br(),
               "You can also download the result table.",
               br()),
             downloadButton(outputId = "downloadData", "Download final result")),
           
           mainPanel(
             fluidRow(
               column(width = 12, height = "auto", tableOutput("final.result"))
             ),
             fluidRow(
               tabsetPanel(type = "tabs",
                           tabPanel("Figure 1: by Urgency & Platform", plotOutput("figure_urgency")),
                           tabPanel("Figure 2: current & increment costs by objective", plotOutput("figure_objective"))
                           )
               #column(width = 6, height = "auto", plotOutput("figure_urgency"))
             )
           )),
tabPanel("Scenario analysis",
         sidebarPanel(
           h5(strong("Scenario analysis"), align = "center" ),
           p("The default setting of cost estimation in the paper used the following settings;"),
           p("- Target coverage = 80%", br(),
             "- Tradable cost ratio = 0.3", br(), 
             "- Ancillary health facility cost = 50%", br(),
             "- Above health facility cost = 17%"
           ),
           strong("You can change these settings as well as the multipliers for the sensitivity analysis.*") ,
                  p("*If the incremental costs based on your change are lower than the costs of default setting, the difference between the two costs is assumed as 0", br(),br()),
           fluidRow(column(6,sliderInput(inputId = "target",
                                         "Target coverage (%)",
                                         min=0, max =100,step=1, value = 80)),
                    column(6,sliderInput(inputId = "tradable",
                                         "Tradable ratio",
                                         min=0, max = 1, value=0.3,step=0.1))),
           fluidRow(column(6,sliderInput(inputId = "HF_cost",
                                         "Ancillary facility cost (%)",
                                         min=0, max = 100, value=50,step=1)),
                    column(6,sliderInput(inputId = "above_cost",
                                         "Above facility cost (%)",
                                         min=0, max = 100, value=17,step=1))),  
           
           strong("Multipliers for sensitivity analysis", br()),
           fluidRow(column(6,sliderInput(inputId = "UC_multi",
                                         "Unit cost multiplier",
                                         min=0.7, max = 1.3, value=1, step=0.1)),
                    column(6,sliderInput(inputId = "coverage_multi",
                                         "Baseline coverage adjustment",
                                         min=-0.15, max = 0.15, value=0,step=0.01))
           ), 
           fluidRow(
                    column(4,sliderInput(inputId = "PIN_multi",
                                  "Population in need multiplier",
                                  min=0.5, max = 1.5, value=1, step=0.1)),
                    column(4,sliderInput(inputId = "fertility_multi_lic",
                                         "Total fertility rate (LICs) multiplier",
                                         min=0.87, max = 1.1, value=1,step=0.01)),
                    column(4,sliderInput(inputId = "fertility_multi_lmic",
                                         "Total fertility rate (LMICs) multiplier",
                                         min=0.8, max = 1.2, value=1,step=0.01))), 
           br(),
           strong("You can download the detail input data based on your inputs"),
           downloadButton(outputId = "downloadData_detail_LIC", "Download LIC data"),
           downloadButton(outputId = "downloadData_detail_LMIC", "Download LMIC data")
         ),
         
         mainPanel(
           fluidRow(
             column(width = 12, height = "auto", tableOutput("result.user.table")),
             column(width = 12, height = "auto", plotOutput("result.figure1"))
             
           )
         )
)


)
)