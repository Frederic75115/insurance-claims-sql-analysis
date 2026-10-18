# Insurance Claims Analysis with SQL

A PostgreSQL project exploring insurance claim frequency and average claim amounts. The project includes relational database design, sample data, analytical queries, indexes, and role-based table permissions.

## Project Questions

- How many claims are associated with each policy type?
- How many claims occur each month?
- What is the average claim amount each month?

## Tools and SQL Skills

- PostgreSQL and pgAdmin 4
- Table creation, primary keys, and foreign keys
- Common table expressions (CTEs) and full outer joins
- Aggregation with COUNT, AVG, and GROUP BY
- Monthly grouping with DATE_TRUNC
- Rounding and chronological sorting
- Index creation and role-based permissions

## Database Structure

| Table | Purpose |
|---|---|
| Customers | Customer profiles and address information |
| PolicyTypes | Auto, Home, Life, and Health insurance categories |
| Policies | Customer coverage dates, policy types, and premiums |
| Claims | Claim dates, amounts, descriptions, and statuses |

Each policy references a customer and a policy type. Each claim references a policy.

The synthetic dataset contains **4 customers, 4 policy types, 5 policies, and 5 claims**. It is demonstration data, not actual customer or insurance records.

## Analysis Approach

The first query uses a CTE to connect policy types to policies, then joins the result to claims. It counts claim IDs by policy type. Full outer joins preserve unmatched records, allowing policy types without claims to appear with a count of zero.

The second query groups claims by month and year using DATE_TRUNC, counts the claims, and calculates their average amount rounded to two decimal places. Results are ordered chronologically. Months without claims are not generated.

## Results from the Supplied Data

### Claims by Policy Type

The query returns policy type IDs; names are included here for readability.

| policytypeid | numberofclaims |
|---|---:|
| 1 | 2 |
| 2 | 1 |
| 3 | 1 |
| 4 | 1 |

### Monthly Claim Summary

| claim_month | monthly_claim_frequency | monthly_avg_claim |
|---|---:|---:|
| 2021-06-01 00:00:00:05 | 1 | 500.00 |
| 2021-07-01 00:00:00:05 | 1 | 1000.00 |
| 2021-08-01 00:00:00:05 | 1 | 200000.00 |
| 2021-09-01 00:00:00:05 | 1 | 150.00 |
| 2021-10-01 00:00:00:05 | 1 | 300.00 |

[Add your findings here.]

These examples demonstrate the queries; the small dataset does not establish broader insurance trends.

## Indexing

The project creates three indexes:

| Indexed Column | Intended Use |
|---|---|
| policies.policytypeid | Support joins between policies and policy types |
| claims.policyid | Support joins between claims and policies |
| claims.claimdate | Support date filters in future queries |

Primary keys already have indexes in PostgreSQL, while foreign keys are not automatically indexed. The date index does not guarantee faster monthly DATE_TRUNC grouping. Performance improvements have not been benchmarked; with five claims, PostgreSQL may favor table scans. Indexes also require storage and maintenance during data changes.

## Roles and Permissions

| Role | Table Permissions |
|---|---|
| ClaimsAnalyst | Read claims and policies |
| ClaimsManager | Inherit analyst access, receive all table privileges on claims, and update policies |

The script demonstrates the assignment's table permissions. Sequence permissions are separate and are not included; inserting claims as the manager with automatically generated IDs requires additional sequence access. Password strings are demonstration values and should be replaced locally.

## How to Run

Use a fresh PostgreSQL database and open its Query Tool in pgAdmin 4. Run the scripts in this order:

| Order | File |
|---|---|
| 1 | 01_create_tables.sql |
| 2 | 02_insert_data.sql |
| 3 | 03_analysis.sql |
| 4 | 04_indexes.sql |
| 5 | 05_roles_permissions.sql |

Run setup and insert scripts once. Repeating them can produce existing-object errors or duplicate data. The supplied inserts assume newly initialized IDs. Role creation requires an authorized account, and role names must not already exist on the PostgreSQL server.

## Project Background

This project follows a self-created schema, sample dataset, and self-imposed task outline. I wrote my analytical queries using a CTE and full outer joins, selected indexes, and configured role permissions to address the project requirements.
