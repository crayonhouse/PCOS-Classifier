# PCOS-Classifier
I created a multiple logistic regression model to predict if a woman has polycystic ovary syndrom (PCOS). This model has a 92.2% accuracy rate. 

Obtaining the Dataset:
I obtained a dataset from Kaggle. It was provided by Prasoon Kottarathil. The data was collected from the state of Kerala in India, from ten different hospitals. Because the data is collected in one state in India, this prediction model may not be generalized for women around the world. There are 44 attributes and 541 observations in this dataset.

Data Preparation:
I renamed all variables to be easily parsed. I changed the measurement unit from inches to centimeters for the variables hip, waist, and waist_hip_ratio. I also eliminated two rows that had an N/A in one of the columns. I chose deletion over imputation because we have a large sample size. I also fixed minor flaws in the dataset (extra period, a string in a column for quantitative data).

Model Creation:
Because the output I’m looking for is binary, I created a multiple logistic regression model with the pcos variable as the response variable, and the other 43 variables as the explanatory variables. The pcos variable is a binary categorical variable that states whether or not the woman has PCOS. I then used backwards elimination to obtain a smaller model. This model uses the variables pulse_rate, cycle, marital_status, lh, prg, weight_gain, hair_growth, skin_darkening, pimples, fast_food, exercise, follicle_l, and follicle_r.

Accuracy:
I created a confusion matrix to see how well the model predicts, using 0.5 as a cutoff. The model predicts 92.21% of the cases accurately, using 0.5 as a cutoff. There were 344 true negatives, 153 true positives, 19 false positives, 23 false negatives.

Diagnostics: 
Multicollinearity: I obtained the variance inflation factor for all variables; none of them were higher than 2. This indicates that there probably isn’t multicollinearity present in the model. 
Cook’s Distance: I created a Cook’s distance plot for the model. None of the values seem to be jumping out except for index 445 and 448. However, after looking into those entries, their values seem to be normal. 
Residuals: I created a residual plot using the standardized Pearson residuals. This plot looks normal; the loess curve seems to be approximately horizontal.
