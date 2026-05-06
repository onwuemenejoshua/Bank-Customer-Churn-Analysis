 # CREATE DATABASE
 
 CREATE DATABASE bank_churn;
 
 USE bank_churn;
 
 CREATE TABLE customers(
	CustomerID INT PRIMARY KEY,
    Surname VARCHAR(100),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(15),
    AGE TINYINT UNSIGNED,
    TENURE TINYINT UNSIGNED,
    Balance DECIMAL(15,2),
    NumOfProducts TINYINT UNSIGNED,
    HasCard TINYINT(1),
    IsActiveMember TINYINT(1),
    EstimatedSalary DECIMAL(15, 2),
    Exited TINYINT(1)
 );
 
 
 SELECT * FROM customers;
 
 /*
	DATA CLEANING/DATA VALIDATION
 */
 
 # 1. check the total rows in the column to see if it match the data set in the CSV file
 
 SELECT COUNT(*) AS total_rows FROM customers;
 
 # 2. checking each column in our excel to know if there is any NULL values
 
 SELECT 
	SUM(CustomerID IS NULL) AS null_id,
    SUM(CreditScore IS NULL) AS null_credit,
    SUM(Geography IS NULL) AS null_score,
    SUM(Gender IS NULL) AS null_gender,
    SUM(Age IS NULL) AS null_age,
    SUM(Tenure IS NULL) AS null_tenure,
    SUM(Balance IS NULL) AS null_balance,
    SUM(NUmOfProducts IS NULL) AS null_product,
    SUM(IsActiveMember IS NULL) AS null_member,
    SUM(EstimatedSalary IS NULL) AS null_salary,
    SUM(Exited IS NULL) AS null_excited
FROM customers;

# Note: From our findings, there is no NULL in our dataset

# 3. checking for duplicate customerID

SELECT CustomerID, COUNT(*) AS score FROM customers
GROUP BY CustomerID
Having score > 1;

# Note: from our findings, there is no duplicate CustomerID
 
 # 4. Checking for valid range

SELECT 
    MIN(Age),
    MAX(Age),
    MIN(Tenure),
    MAX(Tenure),
    MIN(CreditScore),
    MAX(CreditScore),
    MIN(Balance),
    MAX(Balance),
    MIN(EstimatedSalary),
    MAX(EstimatedSalary)
FROM
    customers;

# checking out the countries where our customers reside and  how many customers we have there.

SELECT Geography, COUNT(*) as customers_reside FROM customers
GROUP BY Geography;

# percentage of customers who has left the bank

SELECT 
    COUNT(*) total_customers,
    SUM(Exited) AS churned,
    ROUND(AVG(Exited) * 100, 2) AS churn_rate_pct
FROM
    customers;

/*
	ANALYSIS QUERIES
*/
 
/*
	Q1. Who are our most at-risk customers for churn?
	Breakdown churn rates by age, tenure, credit score, geography, and active membership.
*/

 # BY AGE
 
 SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 45 THEN '30–45'
        WHEN Age BETWEEN 46 AND 60 THEN '46–60'
        ELSE 'Over 60'
    END AS age_group,
    COUNT(*) AS customers,
    ROUND(AVG(Exited)*100,2) AS churn_pct
FROM customers
GROUP BY age_group 
ORDER BY churn_pct DESC;

/* 
	our most risk customers are between the age of 46 to 60 years and this is the age bracket where a customer is
	likely financially stable. This mean that the bank is not meeting their financial or evolving needs.
*/
# BY TENURE

SELECT 
	CASE
		When Tenure <= 2 THEN "New customers"
        When Tenure BETWEEN 3 and 5 THEN "Early stage"
        When Tenure BETWEEN 6 AND 8 THEN "Established"
        ELSE "Long term"
    END Tenure_group,
	COUNT(*) AS customers,
    ROUND(AVG(Exited)*100,2) AS churn_pct
FROM customers
GROUP BY Tenure_group
ORDER BY churn_pct DESC;

/*
	Our most risk customers are our long term customers and this is a big problem because you will expect that this set of 
    people should not leave, yet they are leaving.
*/
# BY CREDIT SCORE

SELECT 
	CASE
		WHEN CreditScore BETWEEN 300 AND 579 THEN "Poor"
        WHEN CreditScore BETWEEN 580 AND 669 THEN "Fair"
        WHEN CreditScore BETWEEN 670 AND 739 THEN "Good"
        WHEN CreditScore BETWEEN 740 AND 799 THEN "Very Good"
        ELSE "Excellent"
    END Credit_score_group,
	COUNT(*) AS customers,
    ROUND(AVG(Exited) *100,2) AS churn_pct
FROM customers
GROUP BY Credit_score_group
ORDER BY churn_pct DESC;

/*
 Our at most risk customers are those with a poor credit score. Precisely a credit score between 300 and  579. which may 
 indicate the bank isn't offering them products tailored to their financial situation.
*/

# BY GEOGRAPHY
SELECT 
	Geography,
    COUNT(*) AS customers,
    ROUND(AVG(Exited) *100,2) AS churn_pct
FROM customers
GROUP BY Geography
ORDER BY  churn_pct DESC;

/* 
	Our at most risk customers are those from Germany. This could be due to stronger local competition, cultural misalignment 
    in the bank's product offerings, poor customer service in that region, or pricing dissatisfaction.
*/

# BY ACTIVE MEMBERSHIP

SELECT 
    IsActiveMember,
    COUNT(*) AS customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_pct
FROM
    customers
GROUP BY IsActiveMember
ORDER BY churn_pct DESC;

#  Our at most risk customers are our inactive members.

/*
 
 CONCLUSION
 
 Active membership is actually one of the strongest and most reliable protectors against churn so the bank should focus on how to
 make inactive members become active and also churning is also associated with long_term customers and those within the age bracket
 45 to 60 indicating deep dissatisfaction among long_term users. The bank needs to shift focus from customer acquisition to retention.
 
*/

/*
	Q2. What customer characteristics are most associated with churn?
    Compare churners vs. non-churners on balance, products used, credit score, active membership, and salary.
*/

SELECT
    Exited,
    ROUND(AVG(Balance),2) AS avg_balance,
    ROUND(AVG(CreditScore),2) AS avg_credit_score,
    ROUND(AVG(NumOfProducts),2) AS avg_products,
    ROUND(AVG(EstimatedSalary),2) AS avg_salary,
    ROUND(AVG(IsActiveMember),2) AS active_rate
FROM customers
GROUP BY Exited;

/*
	CONCLUSION
    
     The typical churner is someone who holds a high balance, uses few products, and is not actively engaged with the bank. 
     This is someone the bank has no real relationship with. The bank's retention strategy should prioritise converting high-balance, 
     low-engagement customers into multi-product, active members.
*/


/*
	Q3 Are there differences in churn across geographies (France, Spain, Germany)?
	Compare churn rates, product usage, and balances across countries.

*/

SELECT 
    Geography,
    ROUND(AVG(NumOfProducts), 2) AS avg_products,
    ROUND(AVG(balance), 2) AS avg_balance,
    COUNT(*) AS total_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_pct
FROM
    customers
GROUP BY Geography
ORDER BY churn_pct DESC;

/*

CONCLUSION

The same bank, the same products, the same policies, yet Germany churns at nearly double the rate of France. This strongly 
suggests that local factors; competition, customer expectations, service quality, or cultural fit are driving Germany's churn, 
not product issues alone. The bank cannot apply a one-size-fits-all retention strategy. Each geography need it's own special fit
designed for its people bases on their cultural needs.

From the analysis, France has a good, effective and stable model and that can be replicated. Just like the way the cultural
market for France was studied that enables them to have a good model, we should also do the same thing for Germany.
*/


/*
	Q4. How does product usage (NumOfProducts, HasCrCard) affect retention?
	Do customers who purchase multiple products tend to stay longer?
	Does having a credit card reduce the likelihood of churn?

*/

# Product usage

SELECT 
    NumOfProducts,
    COUNT(*) AS total_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_pct
FROM
    customers
GROUP BY NumOfProducts
ORDER BY NumOfProducts DESC;

 
/*
CUSTOMERS WITH 2 PRODUCTS HAVE THE LOWERST CHURN RATE making them the bank's most stable segment. Customers with only 1 product 
churn at a noticeably higher rate, they have a little relationship with the bank and little reason to stay. customers with 3 or 4 
products churn at an extremely high rate, nearly 100%(those with 4 products). This means that customers who are over-sold products 
that they don't need become frustrated and  dissatisfied, ultimately leaving. More products is not always better, the right products 
matter more than the number of products.

So, companies should make their product valuable.

*/

 
# Credit card 

SELECT 
    HasCard,
    COUNT(*) AS total_customers,
    ROUND(AVG(Exited) * 100, 2) AS churn_pct
FROM
    customers
GROUP BY HasCard
ORDER BY HasCard DESC;

/*
Churn rates between customers who have a credit card and those who don't are almost the same. This means having a credit 
card creates no meaningful loyalty with the bank. Customers don't associate their credit card strongly enough 
with the bank to make it a reason to stay. This suggests the bank's credit card product is not differentiated enough it lacks 
features, rewards, or benefits that would make customers think twice before leaving. i.e The creditCard has no product Value.
*/


/*
Q5. Which customer segments contribute the most to revenue risk if they churn?
Estimate lost balance or salary base from churners by customer segment.
*/

# BY GEOGRAPHY

SELECT
    Geography,
    COUNT(*) AS churners,
    SUM(Balance) AS total_lost_balance,
    ROUND(AVG(Balance), 2) AS avg_lost_balance
FROM customers
WHERE Exited = 1
GROUP BY Geography
ORDER BY total_lost_balance DESC;

/*
Germany has the highest total balance and also the avg_lost_balance lost by far margin and also highest number of churners  and this 
requires a serious intervention  by the bank.
*/

# BY NUM OF PRODUCTS

SELECT
    NumOfProducts,
    COUNT(*) AS churners,
    SUM(Balance) AS total_lost_balance
FROM customers
WHERE Exited = 1
GROUP BY NumOfProducts
ORDER BY total_lost_balance DESC;

/*
customers using only 1 product has the highest total balance lost. The question should be how do we make our customers use at least
2 products (since in question 4, customers using 2 product have the lowerst churn rate) while also making the product valuable
*/


# BY CREDIT CARD

SELECT
    HasCard,
    COUNT(*) AS churners,
    SUM(Balance) AS total_lost_balance
FROM customers
WHERE Exited = 1
GROUP BY HasCard
ORDER BY total_lost_balance DESC;

/*
customers with a credit card have the highest total balance lost, this reinforce question 4 that shows that the credit card is not
having value that enable customers to stay, so customers see no need having one.
*/

# BY AGE GROUP

 SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 45 THEN '30–45'
        WHEN Age BETWEEN 46 AND 60 THEN '46–60'
        ELSE 'Over 60'
    END AS age_group,
    COUNT(*) AS churners,
    SUM(Balance) AS total_lost_balance
FROM customers
WHERE Exited = 1
GROUP BY age_group
ORDER BY total_lost_balance DESC;

/*
age group 30-45 have the highest total balance lost and this is isn't good for a company because this is the age where most customers
plan build wealth and plan for the future. The bank should direct the bulk of its age-targeted retention efforts at the 30–45 
bracket first, followed closely by 46–60. These two groups alone represent over 87% of all balance lost to churn.
*/


# putting everything in question 5 in one and this is more precise, because it tells us where exactly to focus on.

SELECT
    Geography,
    NumOfProducts,
    HasCard,
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 45 THEN '30–45'
        WHEN Age BETWEEN 46 AND 60 THEN '46–60'
        ELSE 'Over 60'
    END AS age_group,
    COUNT(*) AS churners,
    SUM(Balance) AS total_balance_lost,
    SUM(EstimatedSalary) AS total_average_salary_lost
FROM customers
WHERE Exited = 1
GROUP BY Geography, age_group, NumOfProducts, HasCard
ORDER BY total_balance_lost DESC;


/*
 German customers aged 30–45, with 1 product and a credit card, represent the highest total balance lost
*/


/*
Q6. How does customer tenure impact churn likelihood?
	Analyze churn by years with the bank.
*/

SELECT TENURE,
	COUNT(*) AS total_customers,
    ROUND(AVG(Exited)*100, 2) AS churn_pct
FROM customers
GROUP BY TENURE
ORDER by churn_pct DESC;

/*
Early customers have the highest churn rate and this indicate onboarding issues and lack of unmet expectations and also
our long term customers especially those with us for 10 years which suppose to be our loyal customers still have an higher churn, 
rate, and this indicate deep dissatisfaction which has been building over time.

THE BIGGER PICTURE

The bank has a value sustenance problem and needs to be address because no Tenure is even safe as they all fall within a 
range of 17 to 23%
*/


/*
Q7 What is the profile of the bank’s most loyal customers?
Identify patterns among customers with low churn risk (e.g., active members, multiple products, certain geographies).
*/

# Who are our loyal customers, and what do they look like?


SELECT
    Geography,
    Gender,
    IsActiveMember,
    CASE
       WHEN Age < 30 THEN 'Under 30'
       WHEN Age BETWEEN 30 AND 45 THEN '30–45'
       WHEN Age BETWEEN 46 AND 60 THEN '46–60'
       ELSE 'Over 60'
    END AS age_group,
    ROUND(AVG(NumOfProducts), 2) AS avg_product,
	ROUND(AVG(CreditScore), 2) AS avg_creditscore,
    COUNT(*) AS loyal_customers,
    ROUND(AVG(Balance), 2) AS avg_total_balance
FROM customers
WHERE Exited = 0
GROUP BY Geography, age_group, Gender, IsActiveMember
ORDER BY loyal_customers DESC;

/*
France consistently appears at the top of the loyal customer list by volume, which aligns with its low churn rate from  questions 5
France is the bank's most reliable market and its largest base of retained customers. The bank should study what it is  doing right 
in France and export those practices to Germany(which has the highest churning customers by total_balance_lost and churning rate and 
also the most loyal customers by avg_total_balance) and Spain.
*/



# On average, what are the characteristics of customers who stay?

SELECT
    ROUND(AVG(CreditScore), 2) AS avg_credit,
    ROUND(AVG(NumOfProducts), 2) AS avg_products,
    ROUND(AVG(IsActiveMember), 2) AS active_rate,
    ROUND(AVG(Tenure), 2) AS avg_tenure,
    ROUND(AVG(Balance), 2) AS avg_balance,
    ROUND(AVG(AGE), 2) AS avg_age
FROM customers
WHERE Exited = 0;


/*
5 MOST IMPORTANT FINDING

1. Germany is our biggest problem. German churners hold an average balance of $120K, far higher than other countries. This one market accounts 45.47% of the average total lost
2. Customers with 2 products churn at just 7.6%. excellent retention. But 3-product customers churn at 82.7%, and every single 4-product customer churned (100%). This strongly suggests forced bundling, mis-selling, or product complexity frustrating customers rather than creating loyalty
3. The 46–60 age group signals an emergency. More than half (51.1%) of this segment left.
4. Engagement is our advantage. Inactive members churn at 26.9% vs 14.3% for active members.
5. Tenure gives no loyalty advantage. Churn is almost flat from year 0 to year 10. This means long-tenured customers are not meaningfully more loyal and this is a problem.


My Recommendation

1. Let the bank focus on value creation for its product
2. Germany needs its own dedicated strategy to reduce the churn rate
3. The bank should focus on age group 46-60 and 30-45 as these group holds 87.59% of the total balance lost.


*/

