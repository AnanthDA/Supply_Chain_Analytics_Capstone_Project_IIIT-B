### Synopsis: -

The open-pit mine is facing problems of inefficient production and is losing customers' trust as they are not able to meet their demands even though there has been no surge in demand. The mine operators are sure that this is a problem at their end and want to first understand their tracking and operations on the field in detail, as it is not possible to keep track of all operations at one go due to the vast expanse of the mine.

As an analyst, you have been approached to build a smart live monitoring system. You, as an individual, have been assigned the task to understand the key metrics explained by the client and apply your knowledge of supply chains to get track inventory and quantity available and understand what is happening on the ground at each location. You have been given some key metrics to capture and what operations are going on in the mine.

### Problem Statement: -

- Understand the problem faced by the mine and take an understanding of the data shared by the client.
- Since the client is not very tech-savvy, you need to prepare a cleaned dataset using the dataset provided by him.
- Analyse the data using the MySQL Workbench 8.0 and prepare a live tracking system using some set of dashboards using either Tableau or Power BI.
- At last, present the findings or key insights to your senior technical manager using a ppt of not more than 8 - 12 slides who wishes to understand the key workings of your analysis along with the insights derived out it.


### Data Methodology: -

- All the datasets such as Cycle, Location and Movement were loaded on Jupyter Notebook for cleaning, understanding, manipulation and extract the key indicators from all the datasets.
- Once it is done, the cleaned datasets are imported into MySQL Workbench for creating a stored procedure for each table and perform OEE calculations along with it.
- These formulae are applied for all the datasets repectively.
- OEE Calculations: -
- Availability = (Net Available Time - Down Time) / (Net available time) * 100
- Performance  = (Operating Time - Speed Loses) / (Operating Time) * 100
- Quality      = (Net Operating Time - Defect Loses) / (Net Operating Loss) * 100
- OEE = Availability * Performance * Quality
- Finally, with the help of Tableau all the datasets are imported to find the Equipment Level Production, Efficiency, Accuracy, Quality of Equipments, Key Metrics of Low Performing Equipments and Top Performing Equipments.
