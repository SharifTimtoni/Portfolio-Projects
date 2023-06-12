
----Average (Age, Income and Spending) of customers by country
--	select country, avg(age) as AverageAge, avg(income) AverageIncome, avg(spending) as AverageSpending
--	from customer_data$
--	group by country


---- Ranking Average Income of customers by Country
--	select Country,  avg(income) AverageIncome
--	from customer_data$
--	group by country
--	order by 2 desc

---- Ranking Average Income of customers by Education
--	select Education,  avg(income) AverageIncome
--	from customer_data$
--	group by education
--	order by 2 desc

---- Ranking Average Income of customers by Gender
--	select Gender,  avg(income) AverageIncome
--	from customer_data$
--	group by gender
	

--Number of Customers with the highest income
--	select count(*) as NumberofCustomers
--	from [SQL_PROJECTS]..customer_data$
--	where income= (select max(income) from customer_data$)


--Number of customers with the highest purchase frequency 
--	SELECT COUNT(*) AS NumberOfCustomers
--	FROM [SQL_PROJECTS]..customer_data$
--	WHERE purchase_frequency = (SELECT MAX(purchase_frequency) FROM customer_data$)


--Number of customers with the highest purchase frequency by gender
--	SELECT gender, COUNT(*) AS NumberOfCustomers
--	FROM [SQL_PROJECTS]..customer_data$
--	where purchase_frequency = (SELECT MAX(purchase_frequency) FROM customer_data$)
--	group by gender

-- Number of customers with the highest purchase frequncy by country
--	select country, count(*) as NumberofCustomers
--	from[SQL_PROJECTS]..customer_data$
--	where purchase_frequency= (select max(purchase_frequency) from customer_data$)
--	group by country
--	order by country desc

--Number of customers with the highest purchase frequncy by Education
--	select Education, count(*) as NumberofCustomers
--	from [SQL_PROJECTS]..customer_data$
--	where purchase_frequency= (select max(purchase_frequency) from customer_data$)
--	group by education


--Number of customers with the lowest purchase frequency 
--	select count(*) as NumberofCustomers
--	from [SQL_PROJECTS]..customer_data$
--	where purchase_frequency= (select min(purchase_frequency) from customer_data$)

-- Number of customers with the lowest purchase frequency by gender
--	select gender, count(*) as NumberofCustomers
--	from [SQL_PROJECTS]..customer_data$
--	where purchase_frequency= (select min(purchase_frequency) from customer_data$)
--	group by gender

--Number of customers with the lowest purchase frequency by Country
--	select Country, count(*) as NumberofCustomers
--	from [SQL_PROJECTS]..customer_data$
--	where purchase_frequency= (select min(purchase_frequency) from customer_data$)
--	group by country

--Number of customers with the lowest purchase frequency by Education
--	select Education, count(*) as NumberofCustomers
--	from [SQL_PROJECTS]..customer_data$
--	where purchase_frequency= (select min(purchase_frequency) from customer_data$)
--	group by education

-- percent of spending to income of customers
--	select name, age,gender, education, income, country, purchase_frequency,spending, ( spending/income) as PercenatageofIncome 
--	from [SQL_PROJECTS]..customer_data$
--	where spending< income
--	order by PercenatageofIncome desc

--Ranking customers by their countries based on the average percentage of income spent 
--	with PercentofIncome as 
--		(
--		select name, age,gender, education, income, country, purchase_frequency,spending, ( spending/income) as PercentageofIncome 
--	from [SQL_PROJECTS]..customer_data$
--	where spending< income
--	)

--	select country, avg(PercentageofIncome) as AveragePercentage
--	from PercentofIncome
--	group by country
--	order by AveragePercentage desc;

--Ranking customers by their Gender based on the average percentage of income spent
--	With PercentofIncome as 
--		(	select name, age,gender, education, income, country, purchase_frequency,spending, ( spending/income) as PercentageofIncome 
--	from [SQL_PROJECTS]..customer_data$
--	where spending< income
--	)
--			select Gender, avg(percentageofincome) AverageIncomeSpent
--			from PercentofIncome
--			group by gender;

--Ranking customers by their Education based on the average percentage of income spent
--	with PercentofIncome as
--	(select name, age,gender, education, income, country, purchase_frequency,spending, ( spending/income) as PercentageofIncome 
--	from [SQL_PROJECTS]..customer_data$
--	where spending< income
--	)
--			select Education, avg(percentageofIncome) as AveragePercent
--			from PercentofIncome
--			group by education
--			order by AveragePercent desc;
		
--		create view PercentofIncome as
--		With PercentofIncome as
--		(
--		select name, age,gender, education, income, country, purchase_frequency,spending, ( spending/income) as PercentageofIncome 
--	from [SQL_PROJECTS]..customer_data$
--	where spending< income
--	)

--	select country, avg(PercentageofIncome) as AveragePercentage
--	from PercentofIncome
--	group by country;


--	create view PerIncomeGender as
--	With PercentofIncome as 
--		(	select name, age,gender, education, income, country, purchase_frequency,spending, ( spending/income) as PercentageofIncome 
--	from [SQL_PROJECTS]..customer_data$
--	where spending< income
--	)
--			select Gender, avg(percentageofincome) AverageIncomeSpent
--			from PercentofIncome
--			group by gender;

--	create view PerIncomeEdu as
--	with PercentofIncome as
--	(select name, age,gender, education, income, country, purchase_frequency,spending, ( spending/income) as PercentageofIncome 
--	from [SQL_PROJECTS]..customer_data$
--	where spending< income
--	)
--			select Education, avg(percentageofIncome) as AveragePercent
--			from PercentofIncome
--			group by education;
