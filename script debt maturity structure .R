library(dplyr) # for manipulate data
library(readxl) # library use to read excel file
library(ggplot2) # library for plotting and data visualization
library(tidyverse) # for all the other library
library(car) # for VIF use
library(forecast) 
# this package is included in the program because it contains auto.arima which
# is mentioned in the document Phan 7 Time series regression

df = read_excel("C:/Users/Admin/Desktop/courses/Gói phần mềm ứng dụng trong tài chính 2/final project/K214140961.xlsx")
View(df)

# According to the chosen variables, we just need to select a few rows in the dataset that we have
# So now Im gonna check for NA values, type of data and fill NA in the needed rows

# I. Check and handle data

## 1. Debt maturity structure
### 1.1. Long debt 
#### check for NA values in long debt 
sum(is.na(df[82,]))
#### check for the type of data of long debt
sum(!is.na(as.numeric(df[82,-1])))

### 1.2. Total debt
#### check for NA values in total debt 
sum(is.na(df[66,]))
#### check for the type of data of total debt
sum(!is.na(as.numeric(df[66,-1])))

## 2.Cash holding
### 2.1. Cash
#### check for NA values in cash 
sum(is.na(df[3,]))
#### check for the type of data of cash
sum(!is.na(as.numeric(df[3,-1])))

### 2.2. Equivalent to cash
#### check for NA values in equivalent to cash 
sum(is.na(df[4,]))
#### check for the type of data of equivalent to cash
sum(!is.na(as.numeric(df[4,-1])))
#### fill the NA value with 0, because it not missing data, they just dont have that
df[4,-1][is.na(df[4,-1])] <- 0

### 2.3. Short term investment
#### check for NA values in short term investment 
sum(is.na(df[5,]))
#### check for the type of data of short term investment
sum(!is.na(as.numeric(df[5,-1])))
#### fill the NA value with 0
df[5,-1][is.na(df[5,-1])] <- 0

## 3. Leverage
### 3.1. Total debt (done)

### 3.2.Total assets
#### check for NA values in total assets 
sum(is.na(df[64,]))
#### check for the type of data of total assets
sum(!is.na(as.numeric(df[64,-1])))

## 4. Asset tangibility
### 4.1. Total assets (done)
### 4.2. Total debt (done)
### 4.3. Intangible assets
#### check for NA values in intangible assets 
sum(is.na(df[43,]))
#### check for the type of data of intangible assets
sum(!is.na(as.numeric(df[43,-1])))
#### fill the NA value with 0
df[43,-1][is.na(df[43,-1])] <- 0

### 4.4. Long term financial investment
#### check for NA values in long term financial investment 
sum(is.na(df[52,]))
#### check for the type of data of long term financial investment
sum(!is.na(as.numeric(df[52,-1])))

### 4.5. Other long term assets
#### check for NA values in other long term assets 
sum(is.na(df[58,]))
#### check for the type of data of other long term assets
sum(!is.na(as.numeric(df[58,-1])))

## 5. Liquidity risk
### 5.1. Short term assets
#### check for NA values in short term assets 
sum(is.na(df[1,]))
#### check for the type of data of short term assets
sum(!is.na(as.numeric(df[1,-1])))

### 5.2. Inventory
#### check for NA values in inventory 
sum(is.na(df[18,]))
#### check for the type of data of inventory
sum(!is.na(as.numeric(df[18,-1])))

### 5.3. Short debt
#### check for NA values in short debt 
sum(is.na(df[67,]))
#### check for the type of data of short debt
sum(!is.na(as.numeric(df[67,-1])))

### 5.4. Other short term assets
#### check for NA values in other short term assets 
sum(is.na(df[21,]))
#### check for the type of data of other short term assets
sum(!is.na(as.numeric(df[21,-1])))

## 6. Create a new dataframe with just usable data
df <- df[c(82,67,3,4,5,66,64,43,52,58,1,18,21), ]
#### transpose the dataframe for manipulation
df = t(df)
#### rename columns
column_names <- c("longdebt",
               "shortdebt",
               "cash",
               "equivalentcash",
               "shortinvest",
               "totaldebt",
               "totalassets",
               "intangibleassets",
               "longfinancialinvest",
               "otherlongassets",
               "shortassets",
               "inventory",
               "othershortassets")
colnames(df) = column_names
#### remove the first row
df = df[-1,]
#### apply the df property
df <- as.data.frame(df)
#### turn character to numeric values
df <- as.data.frame(lapply(df, as.numeric))
#### create a list of time periods 
listtimenames = list()
for (i in 2010:2022) {
  for (j in 1:4) {
    listtimenames = append(listtimenames, paste0("Q",j,i))
  }
}

df$Time <- listtimenames
df <- df[, c("Time", names(df)[-ncol(df)])]
#### view the new dataframe
View(df)

# II. Create a variable dataframe
## 1. Debt maturity structure
df$debtmaturitystructure <- df$longdebt / df$totaldebt
variable_df <- data.frame(debtmaturitystructure = df$debtmaturitystructure)

## 2. Cash holding
df$cashholding <- df$cash + df$equivalentcash + df$shortinvest
variable_df <- cbind(variable_df, cashholding = df$cashholding)

## 3. Leverage
df$leverage <- df$totaldebt / df$totalassets
variable_df <- cbind(variable_df, leverage = df$leverage)

## 4. Assets tangibility
df$assetstangibility <- df$totalassets - df$totaldebt - df$intangibleassets - df$longfinancialinvest - df$otherlongassets
variable_df <- cbind(variable_df, assetstangibility = df$assetstangibility)

## 5. Liquidity risk
df$liquidityrisk <- (df$shortassets - df$inventory - df$othershortassets) / df$shortdebt
variable_df <- cbind(variable_df, liquidityrisk = df$liquidityrisk)

## 6. View variable dataframe
View(variable_df)

# III. Provide descriptive statistics 
## 1. Entire period
summary(variable_df)
stats_variable_df <- sapply(variable_df, function(x) c(min = min(x), max = max(x), mean = mean(x), median = median(x), sd = sd(x)))
print(stats_variable_df)

## 2. Before period (all the periods before 2020)
summary(variable_df[1:40,])
stats_variable_df_before <- sapply(variable_df[1:40,], function(x) c(min = min(x), max = max(x), mean = mean(x), median = median(x), sd = sd(x)))
print(stats_variable_df_before)

## 3. After period (8 periods after 2020)
summary(variable_df[41:48,])
stats_variable_df_after <- sapply(variable_df[41:48,], function(x) c(min = min(x), max = max(x), mean = mean(x), median = median(x), sd = sd(x)))
print(stats_variable_df_after)

# IV. Provide box & whisker plot and histogram of the debt maturity structure 
## 1. Entire period
### Boxplot 
ggplot(data = variable_df, aes(x = "", y = debtmaturitystructure)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(title = "Boxplot of Debt maturity structure", x = "", y = "Debt maturity structure") +
  theme_minimal()
### Histogram
ggplot(data = variable_df, aes(x = debtmaturitystructure)) +
  geom_histogram(fill = "lightblue", color = "black") +
  labs(title = "Histogram of Debt maturity structure", x = "Debt maturity structure", y = "Frequency") +
  theme_minimal()

## 2. Before period (all the periods before 2020)
### Boxplot 
ggplot(data = variable_df[1:40,], aes(x = "", y = debtmaturitystructure)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(title = "Boxplot of Debt maturity structure (Before Period)", x = "", y = "Debt maturity structure") +
  theme_minimal()
### Histogram
ggplot(data = variable_df[1:40,], aes(x = debtmaturitystructure)) +
  geom_histogram(fill = "lightblue", color = "black") +
  labs(title = "Histogram of Debt maturity structure (Before Period)", x = "Debt maturity structure", y = "Frequency") +
  theme_minimal()

## 3. After period (8 periods after 2020)
### Boxplot 
ggplot(data = variable_df[41:48,], aes(x = "", y = debtmaturitystructure)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  labs(title = "Boxplot of Debt maturity structure (After Period)", x = "", y = "Debt maturity structure") +
  theme_minimal()
### Histogram
ggplot(data = variable_df[41:48,], aes(x = debtmaturitystructure)) +
  geom_histogram(fill = "lightblue", color = "black") +
  labs(title = "Histogram of Debt maturity structure (After Period)", x = "Debt maturity structure", y = "Frequency") +
  theme_minimal()

# V. Perform multiple regression 
## 1. Model 1: With all the individual variables 
### 1.1. Running the model
model1 <- lm(debtmaturitystructure ~ 
               cashholding + 
               leverage + 
               assetstangibility + 
               liquidityrisk,data = variable_df)
summary(model1, alpha = 0.1)


## 2. Model 2: With the usual individual variables and the interaction 
### 2.1. Add the Covid 19 dummy variable (0 = not covid year, 1 = covid year)
covid_dummy=list()
for (i in 1:52) {
  if (i <= 40) {
    covid_dummy <- append(covid_dummy, 0)
  } else if (i<=48) {
    covid_dummy <- append(covid_dummy, 1)
  } else {
    covid_dummy <- append(covid_dummy, 0)
  }
}
variable_df$covid <- covid_dummy
variable_df$covid <- as.numeric(variable_df$covid)

### 2.2. Running the model
model2 <- lm(debtmaturitystructure ~ 
               cashholding + 
               leverage + 
               assetstangibility + 
               liquidityrisk + 
               covid:cashholding +
               covid:leverage + 
               covid:assetstangibility +
               covid:liquidityrisk, data = variable_df)
summary(model2, alpha = 0.1)


## 3. Predict the debt maturity structure using Model 1
### 3.1. Predict the variable 
predictions <- predict(model1, data = variable_df)
print(predictions)
variable_df_with_predictions <- cbind(variable_df, predictions)
View(variable_df_with_predictions)

### 3.2 Plot the comparison graph
ggplot(variable_df_with_predictions, aes(x = 1:length(predictions))) +
  geom_line(aes(y = predictions, color = "Predicted")) +
  geom_line(aes(y = debtmaturitystructure, color = "Real data")) +
  labs(title = "Comparison of Predicted and Real data", x = "Observation", y = "Value") +
  scale_color_manual(values = c("Predicted" = "blue", "Real data" = "red")) +
  theme_minimal()


# VI. Train and use ARIMA model to predict
## 1. Create the train and test dataset
ts_data <- ts(variable_df[1:48,], frequency = 4)
train_data <- variable_df[1:48,]
test_data <- variable_df[49:52,]
View(train_data)
View(test_data)

## 2. Fit the ARIMA model using auto.arima
arima_model <- auto.arima(train_data$debtmaturitystructure)

## 3. Forecast variable for 4 quarters of 2022
forecast <- forecast(arima_model, h = 4)

## 4. Extract the predicted values
predicted_values <- forecast$mean

## 5. Compare the predicted variable with realistic data
comparison_data <- variable_df[49:52,]$debtmaturitystructure
comparison_df <- data.frame(Actual = comparison_data, Predicted = predicted_values)

# 6. Print the comparison data
print(comparison_df)

#----------end----------
# Thanks you for you time and dedication for considering my work until the end!
# I sincerely grateful your dedication, time, and effort in teaching 
# and guiding us through the completion of the Financial Application Package 2
# course and this final project. 
# This has truly been an amazing journey for me and definitely 
# one of my most favorite courses in the Fintech training program
# as I get to learn code and explore the new language R and its ability 
# to analyze data in a more efficient and organized manner compared to Python.
# From your student
# Warmest regard./.
