# Team-1
Team 1's group project GitHub repository for MGT 6203 (Canvas) Spring of 2024 semester. 

### Project Topic
**How to Best Invest in Neighborhoods to Increase Home Values**
We investigate the impact of economic and environmental factors on a home’s price to determine how to best
invest in neighborhoods to increase home values. Our goal is be able to provide concrete suggestions for how
cities/counties could prioritize their investment decisions in different communities. 

### Team members:
Tyler David: tdavid9@gatech.edu \
Kristie Garrison: kelliott35@gatech.edu \
Bao Ly: bly31@gatech.edu \
Phat Ngo: pngo36@gatech.edu \
Allison Weber: aweber47@gatech.edu 

### Directory Structure:
We maintained the directory structure provided when the repo was initialized. 
- Code folder contains R code files
- Data folder contains data (stored on Dropbox and added locally rather than being stored on GitHub), and two code files: one generates the interest rate data that includes all California zipcodes (Note: this is the only file that contains Python code, and is optional to run to obtain the data) and the other merges all individual datasets into one dataset that is used to fit our models. 
    - The Data/Data_info subfolder contains supplimental text explaining data details and html files from EDA

### Data Source
**Final Combined Dataset:** Download modified_all_data.csv from [Dropbox](https://www.dropbox.com/scl/fi/j83hxjqj6vtdw5tluniq6/modified_all_data.csv?rlkey=rkxvcj2hqg0nawc0jr3mmi9u9&dl=0), place in "Data" folder on your local copy of the repo.
          
### Tools
We used the R programming langauge to build this project, with RStudio as our perfered IDE.
Data files are stored on DropBox (see links above).  
Version control through Git/GitHub.  

### How to run
- See Data Source section below for instructions on how to replicate the data cleaning.
- First ensure the enviroment is setup correctly:
1) Make sure to have all of the packages required listed in requirements.txt
2) Make sure copy of [modified_all_data.csv](https://www.dropbox.com/scl/fi/j83hxjqj6vtdw5tluniq6/modified_all_data.csv?rlkey=rkxvcj2hqg0nawc0jr3mmi9u9&dl=0) is downloaded and placed in the Data folder
- Model Output will be printed to console + plots generated.
- To create the models:
  - *Linear regression*: Run 'Code/linear_regression_all_data v2.R'
  - *Step-wise Regresssion (feature selection)*: Run Code/stepwise_regression.R.      
  - *Lasso regression*: Run 'Code/Lasso Regression.R'    
        - In case the data for all_data isn't being pulled from dropbox, replace the variable all_data with ```all_data <-       read.csv('../Data/modified_all_data.csv')```  
        - Explore_Data_all_data.R: run if you're interested in just checking out the correlation before the Lasso regression take place      
  - *k-Nearest Neighbors (KNN) Regression*: Run Code/MGT6203_ProjectKNN_Models.Rmd.
  - *Random Forest and Regression Tree (CART)*: Run Code/RF_and_CART.R 

**Cleaned Individual Datasets:**    

Follow the instructions below to clean each individual dataset and combine them (creating the  modified_all_data.csv mentioned above).

*Zillow*: Zillow Housing Data can be retrieved by going to the website and selecting the [Data](https://www.zillow.com/research/data/) tab. The original data that would be used in the project would be ZHVI Single-Family Home Time Series ($) with a selection for geography as “Zip Code” and it's also stored on [Dropbox](https://www.dropbox.com/scl/fi/59et4i3df319pzzgib79u/ZHVI-Single-Family-Homes-Time-Series.csv?rlkey=b8fi4w9y4ecs8knjsaf8sktrt&dl=0).
-1) When opening the file make sure to have the required packages. Run the command: 
#install.packages(c("dplyr", "lubridate", "openxlsx", "tidyverse"))
2) Once the packages are installed, run the code and you'll get all the output. 
3) In case the data for all_data isn't being pulled then do this step: 
- Download the file: [ZHVI Single-Family HomesTimeSeries($).csv](https://www.dropbox.com/scl/fi/59et4i3df319pzzgib79u/ZHVI-Single-Family-Homes-Time-Series.csv?rlkey=b8fi4w9y4ecs8knjsaf8sktrt&dl=1')and placed in the Data folder. Then replace the variable ZHVI_Zillion_SF_Raw_Data with "ZHVI_Zillion_SF_Raw_Data <-read.csv('../Data/ZHVI Single-Family Homes Time Series($).csv')"

*Census*:
- The original Census data can be obtained from https://data.census.gov/table
- The tables that you will need to download are:
  - Total Population
  - Race
  - Age
  - Education Attainment
- These tables as well as the combined table can be found on the Census Dropbox: https://www.dropbox.com/scl/fo/nalxwdt1y8oowdnvpjemv/h?rlkey=fl1jtnoq4ouzr7ryorihr0lpo&st=f0v7tkcv&dl=0

*Intrest Rates*: 
- Original data downloaded from FrddieMac website by creating and signing into account (https://www.freddiemac.com/research/datasets/sf-loanlevel-dataset).
- Files downloaded from FreddieMac and used for LoanLevelData_Cleaning can be found here: https://www.dropbox.com/scl/fo/phz9mlme2qmfkqper15vs/h?rlkey=ygcqcndmdumpuk7xe2dx4gfa7&st=hstcp2rc&dl=0
- This dataset did not explicitly include all California zipcodes. There are two options to obtain the interest rate data for all zipcodes:
  1) *Option 1*\
    a) Download the file directly from [Dropbox](https://www.dropbox.com/scl/fi/5ez1lfd9d5p6glmha7g7q/median_interest_rate_all_zipcodes.csv?rlkey=m2rfsltcdesd0jj6vzqrvgulz&dl=0).\
    b) Place the dataset in the Data folder for the subsequent steps of this project.
  2) *Option 2*\
    a) Uncomment the last cell of Data/Create_New_Interest_Rate_Dataset.ipynb to allow it to write and save the resulting median_interest_rate_all_zipcodes.csv in the Data folder.\
    b) Run Data/Create_New_Interest_Rate_Dataset.ipynb. This is the only notebook that was coded in Python for this project, and the Pandas and Numpy libraries were used.\
    c) The uncommented last cell of Data/Create_New_Interest_Rate_Dataset.ipynb will automatically save median_interest_rate_all_zipcodes.csv into the Data folder.

*Healthy Places index (HPI)*: Combined HPI data file (HPI_clean.csv) stored on [Dropbox](https://www.dropbox.com/scl/fi/cyjn3u50roha4l2esz3yx/HPI_clean.csv?rlkey=euyagrhsjtbg56ziyat5loexq&dl=0). 
- Orginial data accessed and downloaded via [API](https://api.healthyplacesindex.org/documentation). These files are also all stored in an HPI_Indicators folder on [Dropbox](https://www.dropbox.com/scl/fo/5kq5zjpfqui1g5bxm37jv/h?rlkey=cujjyrdxpfyigaq9bz4iepunp&dl=0)
- To create the combined + cleaned HPI dataset from scratch: 
  1) Download the HPI_Indicators folder from [Dropbox] and place it with in the Data folder in your local copy of the repo (Data/HPI_Indicators).  
  2) Run Code/clean_HPI.R. This will create the final combined HPI dataset and place it in the Data folder (Data/HPI_clean.csv). As mentioned above, this file is also stored on [Dropbox](https://www.dropbox.com/scl/fi/cyjn3u50roha4l2esz3yx/HPI_clean.csv?rlkey=euyagrhsjtbg56ziyat5loexq&dl=0).  
  3) TO see results of exploratory data analysis on HPI data set: Run explore_data_HPI.R. This creates html files (e.g. hpi_indicators_summary.html) and places them in the Data/Data_info/ folder. 

*Combining all the datasets into 1*:
- All datasets were combined by zipcode using multiple merge statements in R.
- To create the combined dataset:
  1) First, ensure the above datasets are placed in the Data folder. Here's a list:\
     a) *Healthy Places Index (HPI) Dataset:* HPI_clean.csv\
     b) *Zillow Housing Dataset:* Zillow data (6 Month Avg).csv\
     c) *U.S. Census Dataset:* merged_census_removed_columns.csv\
     d) *CA Median Interest Rate Dataset (all Zipcodes):* median_interest_rate_all_zipcodes.csv
  2) Open Data/MGT6203_Project_MergeDatasets.Rmd and uncomment the last code chunk, which will write and save the combined dataset into the Data folder under the name all_data.csv.
  3) Run Data/MGT6203_Project_MergeDatasets.Rmd.
  4) As mentioned above, the resulting dataset will automatically be saved in the Data folder.
- The combined dataset is also stored on [Dropbox](https://www.dropbox.com/scl/fi/emtpoaui9r1rhwba2gs7h/all_data.csv?rlkey=p4cmhe570oqd9cdsvd113cu59&dl=0) as all_data.csv.
- Then, ensure all_data.csv is placed in the Data folder and run modify_combined_data.R. This will create the final cleaned dataset Data/modified_all_data.csv, which as mentioned above, is also stored on [Dropbox](https://www.dropbox.com/scl/fi/j83hxjqj6vtdw5tluniq6/modified_all_data.csv?rlkey=rkxvcj2hqg0nawc0jr3mmi9u9&dl=0).





