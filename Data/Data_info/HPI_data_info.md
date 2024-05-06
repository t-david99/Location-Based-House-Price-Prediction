# The California Healthy Places Index (HPI)

**Primary file: Cleaned and combined data**: [HPI_clean.csv](https://www.dropbox.com/scl/fi/cyjn3u50roha4l2esz3yx/HPI_clean.csv?rlkey=euyagrhsjtbg56ziyat5loexq&dl=0)
- Includes zip code, population and the 'value' column for each indicator
- Does not include percentile, numerator, denominator, or se columns. Chose value over percentile since that is more stable if this analysis was expanded to other regions. Numerator, denominator and se are not included since they are only present for about half of the indicators. Does not include population column because we are using popultion from census dataset. 

**Combined data including columns with NA values**: [HPI_all.csv](https://www.dropbox.com/scl/fi/8eaeu41wvdrn3kw1vlqk0/HPI_all.csv?rlkey=zcam1cr4uirbtictl4ze5zbs9&dl=0)
- 2 columns included in this file that are removed from above due to NA values are: preschool and highschool_enrollment
- Also includes population column (removed to prevent duplication with census data) 

**Main site**: https://www.healthyplacesindex.org/

**1 page info doc**: https://assets.website-files.com/613a633a3add5db901277f96/6249ff8a57c7733472b2c721_HPI_onepager_FINAL.pdf 

- To get access to this data you must create a free account. You will then automatically be provided with an API key. 

- Download JSON or CSV files with desired infomation at: https://api.healthyplacesindex.org/documentation

*Key selectors*: 
1. Level of geography. For example, County, Zip code, Census Track, City/Town, Elementary School District, etc.
2. Indicator. You can select only 1 indicator at a time. One option is HPI score (overall combination score, from 1-99, based on 23 key drivers of health and life expectancy at birth) or any of the seporate inputs that form the HPI (e.g. per capita income, bachelor's education or higher, home ownership, park access, etc.)
3. Year- different indicators have different years avaible. For now, most recent but when confirm 2nd dataset, should pick year closest to that data. 

Note that in addition to location and score, population for that geographic area is provided.

Since we are not supposed to store data on GitHub, I have put the test csv files on DropBox. To use, download locally and place within the Data folder.

- hpi score by zip code: https://www.dropbox.com/scl/fi/yntl3dcamm5otgx0z5ich/hpiscore_zipcode.csv?rlkey=94w1wh9iv94emjczsyjxt30d2&dl=0
- pm 2.5 by city/town: https://www.dropbox.com/scl/fi/86jgs5r8x4snuvjb1stfo/pm25_city.csv?rlkey=wuzuv0k8gd9bjrdcb494yx1ig&dl=0
- tree canopy by county: https://www.dropbox.com/scl/fi/iltfo1k8q0vbt7qr22p1w/treecanopy_county.csv?rlkey=70g6ddc8tdo8z8dtl4e4fbkbg&dl=0

Also see *dataset*_summary.html files in the Data/Data_info folder to see general summary stats + historgrams for these data sets.


