-- Task 5: Roles and Permissions
-- Create analyst and manager login roles, then grant table access.
-- Run as an account authorized to create roles and grant these privileges.
-- Create these roles only if they do not already exist on the server.
-- Password strings below are demonstration values; use local credentials.

-- Create the role that will receive read-only table access.
create role ClaimsAnalyst 
with login password 'ClaimsAnalyst@1234';

-- Make the manager a member of the analyst role to inherit read access.
create role ClaimsManager 
with login password 'ClaimsManager@1234' 
in role ClaimsAnalyst;

-- Allow the analyst to read claims and policies.
grant select on claims, policies to ClaimsAnalyst;

-- Give the manager all table privileges on claims.
grant all privileges on claims to ClaimsManager;

-- Allow the manager to update existing policy information.
grant update on policies to ClaimsManager;