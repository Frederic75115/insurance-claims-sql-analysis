-- Task 3: Analytical Queries
-- Query 1: Calculate the total number of claims per policy type.
-- The CTE connects policy types to policies.
-- The outer query joins those results to claims and counts non-NULL ClaimIDs.
-- FULL OUTER JOIN retains unmatched rows; types without claims receive zero.
-- Group and order the results by PolicyTypeID.

with cte as (
	select t.policytypeid, policyid 
	from policytypes t full outer join policies p 
		on t.policytypeid = p.policytypeid 
)

select policytypeid, count(claimid) as numberofclaims 
from cte t full outer join claims c 
	on t.policyid = c.policyid 
group by policytypeid 
order by policytypeid;


-- Query 2: Calculate monthly claim frequency and average claim amount.
-- DATE_TRUNC groups claim dates by month and year.
-- COUNT(*) counts claims, and AVG calculates their average amount.
-- ROUND displays the average to two decimal places.
-- Order months chronologically; months without claims are not generated.
select 
	date_trunc('month', claimdate) as claim_month,
	count(*) as monthly_claim_frequency, 
	round(avg(claimamount), 2) as monthly_avg_claim 
from claims 
group by date_trunc('month', claimdate)
order by date_trunc('month', claimdate);