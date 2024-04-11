# determinants-of-debt-maturity-structure
**_License:
This is a personal project of Tung Pham in order to serve as the final project for the Package for financial application 2 course taken at the University of Economics and Law (VNU-HCM)_**

**Project Title:** Examining the Determinants of Debt maturity structure Pre and Post COVID19 era in Vietnam

**Project Description:** This project is focused on analyzing the relationship between Cash holding, Leverage, Asset tangibility and Liquidity risk effect Debt maturity structure of a company in Vietnam. The project utilizes a Balance sheet dataset of CMC Technology Joint Stock Company in Vietnam from 2010 to present to provide descriptive statistic, perform exploratory data analysis (EDA) and build regression models with COVID dummy variable to assess the effect of COVID period to the company performance. The goal of the project is to investigate the potential impact of determinants on debt maturity structure, compared figure pre and post COVID period and draw meaningful conclusions from the analysis.

**Dataset description:**
- Source: Cafef.vn (dataset was imported directly to excel file)
- Company: CMC Technology Group Joint Stock Company (CMG) 
- Document type: Quarterly Balance Sheet 
- Format: Excel format (xlsx)
- Time period: First quarter of 2010 to fourth quarter of 2022 (Q1-2010 to Q4-2022)

**Project Structure:** The project follows the typical data analysis workflow, including the following main steps:

- Conduct Literature Review: Conduct a thorough literature review to identify variables that influence the debt maturity structure, which can be derived from a company's balance sheet. These variables include cash holding, leverage, asset tangibility, and liquidity risks.
- Perform Coding Tasks: Utilize the R programming language to write scripts for data cleaning and processing. Transform the data into a suitable format, converting it from an Excel file to a dataframe for convenient evaluation and analysis in subsequent steps.
- Provide Descriptive Statistics: Present descriptive statistics that offer a summary and description of the data under consideration. These statistics may include measures such as means, medians, standard deviations, and other relevant statistical indicators, providing a comprehensive overview of the dataset.
- Visualization: Employ visual representations, such as graphs or charts, to illustrate patterns, trends, and relationships within the data. Visualization techniques enhance the understanding and interpretation of complex information, making it easier to communicate findings effectively.
- Perform Multiple Regression: Conduct a multiple regression analysis to explore the relationship between the dependent variable (debt maturity structure) and multiple independent variables. This statistical technique helps determine the extent to which the independent variables predict or explain the variation in the dependent variable.
- Machine Learning (ARIMA) Model: Utilize the Autoregressive Integrated Moving Average (ARIMA) model, a popular machine learning technique, to analyze time-series data. ARIMA models capture and predict patterns and trends in data, enabling forecasting and predictive analysis based on historical patterns.

**Conclusion:** Cash holding, Leverage and Liquidity risk have a statistically significant positive effect on debt maturity structure, while assets tangibility has a statistically significant negative influence. During the COVID-19 period, the coefficients for the interaction variables are not statistically significant, indicating that the relationships between these variables and the debt maturity structure did not change significantly during that period.

**Note:** Please note that this project has limitations, including the sample size of the chossen company and the specific context of Vietnam's business environment. Further research and analysis are recommended to validate the findings and explore additional factors that may affect debt maturity credit in Vietnam.
