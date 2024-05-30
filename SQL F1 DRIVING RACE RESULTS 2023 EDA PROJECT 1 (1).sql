SELECT * FROM projects.formula1_2023_season_race_results;

#Exploratory Data Analysis

#Top 3 Drivers in every race by track

SELECT track, Driver, Team, position 
FROM formula1_2023_season_race_results
WHERE Position <= 3
ORDER BY TRACK DESC;

#Avg position of all drivers in F1 2023

SELECT driver, team, Round(AVG(position),1) AS avg_position
FROM formula1_2023_season_race_results
GROUP BY driver, team
ORDER BY avg_position;

#Most podium races win by a team in 2023,TOP 5 teams.

SELECT Team, COUNT(*) AS podium_finishes
FROM formula1_2023_season_race_results
WHERE position <= 3
GROUP BY Team
ORDER BY podium_finishes DESC
LIMIT 5;

#How many times A driver won based on the grid that he started in F1 2023

SELECT `starting grid`,driver, COUNT(*) AS wins
FROM formula1_2023_season_race_results
WHERE position = 1
GROUP BY `starting grid`, driver
ORDER BY wins DESC;

# The correlation between the starting grid position and winning position

SELECT `starting grid`, position, driver,COUNT(*) AS count
FROM formula1_2023_season_race_results
GROUP BY `starting grid`, position, driver
ORDER BY `starting grid`, position, driver;

#Driver Cumulative Points and Positions by Track

WITH driver_cumulative_points AS (
    SELECT driver, track, Position,
    SUM(points) OVER (PARTITION BY driver ORDER BY track) AS cumulative_points
    FROM formula1_2023_season_race_results
)
SELECT driver,track,position,cumulative_points
FROM driver_cumulative_points
ORDER BY driver,track,cumulative_points;

# Season Overview of Driver with total podium wins and points

SELECT driver, team, SUM(points) AS total_points, COUNT(CASE WHEN position <= 3 THEN 1 END) AS race_wins
FROM formula1_2023_season_race_results
GROUP BY driver, team;

#Fastest Lap time BY a driver on every track

SELECT driver,`Fastest Lap Time`, track
FROM formula1_2023_season_race_results
WHERE `Set Fastest Lap` = 'Yes'
GROUP BY driver,`Fastest Lap Time`, track;

SELECT * FROM projects.formula1_2023_season_race_results;

