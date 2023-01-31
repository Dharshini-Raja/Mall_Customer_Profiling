# Mall_Customer_Profiling
Malls have the difficulty of knowing their customers and their spending patterns.
But this is crucial to know as they can target their customers based on their spending patterns
and group them based on this criteria. My project does exactly this. This project studies
the customers' profile and tries to solve the above problem using clustering technique.

Dataset:
	The dataset used is downloaded from Kaggle. This data set has 200 instances and 5 
features namely: CustomerId, Gender, Age, AnnualIncome, SpendingScore. This dataset is loaded 
and read using read.csv().

EDA:
	The structure of the dataset is displayed along with its dimensions and summary. In
summary, it gives out the quartiles, means, minimum and maximum values of each feature for 
further analysis. The dataset is checked for any null values and the Gender column is converted into
factor for easy manipulation. Using boxplot, the outliers are detected. With respect to the Annual
Income, the Inter Quartile Range(IQR) is calculated and the data outside the range is eliminated.
Before clustering, the dataset is normalized that is, the data is scaled using predict.preProcess().

Hierarchical Clustering:
	Hierarchical clustering is implemented to the normalized dataset. This dataset has its 
euclidean distance calculated and the ward minimum variance method is used. After that, the dendogram is plotted 
and the tree is cut using cutree() function and this is tabled to find the correct number of clusters.
Then, we get the mean value of features for each clusters using tapply(). After this, the 
clusters and the mean values of each feature with respect to cluster is appended to 2 separate
csv files.

Using the files, it can be concluded that the people with age 32-41 have the highest income
but 41 age group don't spend much however customers in age group 24-32 spend more money irrespective
of how much they earn. This information can be used to target the customers.
