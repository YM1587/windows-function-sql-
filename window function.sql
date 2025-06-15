
-- Overview
-- In this notebook, we will explore how to use window functions in SQL to solve complex problems. Window functions are a type of function in SQL that performs a calculation across a set of table rows that are related to the current row.

-- We will use the united_nations.Access_to_Basic_Services table, which contains information about different countries, their GDP, and access to basic services.

-- Let's begin by calculating each country's land cover as a percentage per subregion for the year 2020.
-- Task 1: Select the data required for the analysis
-- The columns you select should include:

-- Sub_region
-- Country_name
-- Land_area
-- Filter out the results using the following criteria:

-- For the Time_period of 2020.
-- For Land_area values that are not missing.
SELECT 
    Sub_region, Country_name, Land_area
FROM
    united_nations.access_to_basic_services
WHERE
    Time_period = 2020
        AND Land_area IS NOT NULL;
    
    
-- Task 2: Calculate the land area covered as a percentage of the country's subregion
-- Calculate each land area as a percentage within its sub_region:
SELECT
    Sub_region,
    Country_name,
    Land_area,
    ROUND(Land_area/SUM(Land_area) OVER (PARTITION BY sub_region)*100,4) AS pct_sub_region_land_area
FROM united_nations.access_to_basic_services
    WHERE time_period = 2020
    AND Land_area IS NOT NULL;

-- Divide the Land_area by the SUM() BY the areas OVER each Sub_region's PARTITION. Name this column pct_sub_region_land_area.
-- Round the calculation off to 4 decimal places.
-- This query returns data on access to basic services, filtering out any rows where GDP is missing, and adds a running average of the population by sub-region over time.


    
    
SELECT
    Sub_region,
    Country_name,
    Time_period,
    Pct_managed_drinking_water_services,
    Pct_managed_sanitation_services,
    Est_gdp_in_billions,
    Est_population_in_millions,
    ROUND(AVG(Est_population_in_millions) OVER (PARTITION BY Sub_region ORDER BY Time_period),4) AS Running_average_population
FROM united_nations.access_to_basic_services
    WHERE Est_gdp_in_billions IS NOT NULL;