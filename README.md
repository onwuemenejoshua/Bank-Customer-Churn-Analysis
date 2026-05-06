# Bank-Customer-Churn-Analysis

This project explores customer churn in a bank using MySQL. The goal was to understand who is leaving the bank, why they are leaving and who our loyal customers are. The analysis covers 10,000 customers across three countries - France, Spain, and Germany.

**Dataset**
The dataset contains 10,000 bank customer records with the following key columns:

| Column | Descriptions |
|----------|----------|
| CustomerID    | Unique identifier for each customer   |
| CreditScore  | Customer's credit score  |
| Geography  | Country of residence (France, Spain, Germany)  |
| Gender | Male or Female |
| Age   | Customer's age |
| Tenure | Number of years with the bank  |
| Balance  | Account balance  |
| NumOfProducts | Number of bank products used   |
| HasCard | Whether the customer has a credit card (1 = Yes, 0 = no) |
| IsActiveMember  | Whether the customer is an active member (1 = Yes, 0 =  no)   |
| EstimatedSalary  | Estimated annual salary |
| Exited | Whether the customer churned (1 = Yes, 0 = no) |

**Process**

1. Data Cleaning & Validation
  Before any analysis, the data were validated to ensure accuracy:

- Checked total row count against the source CSV
- Checked every column for NULL values — none were found
- Checked for duplicate CustomerIDs — none were found
- Validated value ranges for Age, Tenure, CreditScore, Balance, and EstimatedSalary

2. Exploratory Analysis
Calculated the overall churn rate across the dataset as a baseline before diving into segment-level breakdowns.

3. Analysis Questions
The analysis was structured around 7 core business questions:

Q1. Who are the most at-risk customers for churn?
Churn rates broken down by age group, tenure, credit score tier, geography, and active membership status.

Q2. What characteristics are most associated with churn?
A side-by-side comparison of churners vs. non-churners across balance, products used, credit score, salary, and engagement.

Q3. Are there differences in churn across geographies?
Comparing France, Spain, and Germany on churn rate, product usage, and average balance.

Q4. How does product usage affect retention?
Analysing churn by number of products held and whether having a credit card makes a difference.

Q5. Which customer segments represent the highest revenue risk?
Estimating total balance and salary lost from churners by geography, age group, product count, and credit card status.

Q6. How does tenure impact churn?
Analysing churn likelihood year by year to see if long-term customers are actually more loyal.

Q7. What does the bank's most loyal customer look like?
Profiling retained customers by geography, gender, age, and engagement level.

**5 MOST IMPORTANT FINDINGS**

1. Germany is our biggest problem. German churners hold an average balance of $120K, far higher than in other countries. This one market accounts 45.47% of the average total lost
2. Customers with 2 products churn at just 7.6%. excellent retention. But 3-product customers churn at 82.7%, and every single 4-product customer churned (100%). This strongly suggests forced bundling, mis-selling, or product complexity, frustrating customers rather than creating loyalty
3. The 46–60 age group signals an emergency. More than half (51.1%) of this segment left.
4. Engagement is our advantage. Inactive members churn at 26.9% vs 14.3% for active members.
5. Tenure gives no loyalty advantage. Churn is almost flat from year 0 to year 10. This means long-tenured customers are not meaningfully more loyal, and this is a problem.


**MY RECOMMENDATION**

1. Let the bank focus on value creation for its product
2. Germany needs its own dedicated strategy to reduce the churn rate
3. The bank should focus on the age group 30-60, as this group holds 87.59% of the total balance lost.



