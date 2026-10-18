-- Task 4: Optimization
-- Add indexes on foreign keys used in joins and on the claim date.
-- Primary keys already have indexes; foreign keys are not automatically indexed.
-- These indexes are candidates for supporting larger workloads.
-- Performance gains have not been measured; this small dataset may use scans.
-- Indexes also require storage and maintenance when data changes.

-- Support joins from policies to policy types using PolicyTypeID.
create index idx_policies_policytypeid 
on policies(policytypeid);

-- Support joins from claims to policies using PolicyID.
create index idx_claims_policyid
on claims(policyid);

-- Support date filters; this does not guarantee faster DATE_TRUNC grouping.
create index idx_claims_claimdate 
on claims(claimdate);
