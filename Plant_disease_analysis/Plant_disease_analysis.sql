-- Create Table
CREATE TABLE plant_disease_data (
    id SERIAL PRIMARY KEY,
    temperature FLOAT,
    humidity FLOAT,
    rainfall FLOAT,
    soil_pH FLOAT,
    disease_present INT
);

-- Check Table
select * from plant_disease_data

-- Replicating Data from CSV
COPY plant_disease_data(temperature, humidity, rainfall, soil_pH, disease_present)
FROM 'C:\Users\naman\OneDrive\Desktop\Plant_disease_analysis\plant_disease_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Total plant whiich have disease vs. Plants which are Healthy
SELECT 
  disease_present,
  COUNT(*) AS total_count
FROM plant_disease_data
GROUP BY disease_present;

-- Average Feature Values by Disease Presence
SELECT 
  disease_present,
  AVG(temperature) AS avg_temp,
  AVG(humidity) AS avg_humidity,
  AVG(rainfall) AS avg_rainfall,
  AVG(soil_pH) AS avg_soil_pH
FROM plant_disease_data
GROUP BY disease_present;

--  Disease Count by Rainfall Buckets
SELECT 
  width_bucket(rainfall, 0, 100, 5) AS rainfall_bucket,
  COUNT(*) FILTER (WHERE disease_present = 1) AS diseased_count,
  COUNT(*) AS total_count
FROM plant_disease_data
GROUP BY rainfall_bucket
ORDER BY rainfall_bucket;

-- Top Conditions When Disease is Present
SELECT *
FROM plant_disease_data
WHERE disease_present = 1
ORDER BY temperature DESC, humidity DESC
LIMIT 10;

-- Correlation Approximation
SELECT 
  CORR(temperature, disease_present) AS temp_corr,
  CORR(humidity, disease_present) AS humidity_corr,
  CORR(rainfall, disease_present) AS rainfall_corr,
  CORR(soil_pH, disease_present) AS ph_corr
FROM plant_disease_data;
