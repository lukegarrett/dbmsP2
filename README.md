# US Accidents Database Project
##### Michael Dobson and Luke Garrett
##### CS 3265: Database Management Systems

Source for data: https://www.kaggle.com/datasets/sobhanmoosavi/us-accidents

Instructions to recreate our project:
1. Clone this repository (https://github.com/lukegarrett/dbmsP2) to your local machine and ensure you have wamp64 server installed.
2. Go to the link above and download the source data found on Kaggle's website.
3. Open the 'project_2_load_data.sql' (https://github.com/lukegarrett/dbmsP2/blob/main/application/db/project_2_load_data.sql) file within the DB directory and change the location of the downloaded dataset to the correct location.
4. Run it in its entirety in MySQL Workbench (v8.x).
5. Once this has completed (may take upwards of 10 minutes to run entire file), open 'ddl_sql.sql' (https://github.com/lukegarrett/dbmsP2/blob/main/application/db/ddl_sql.sql) and 'severity_triggers.sql' (https://github.com/lukegarrett/dbmsP2/blob/main/application/db/severity_triggers.sql) and run these files as well. 
5. If you wish to run them all at once, please locate the 'db.sql' (https://github.com/lukegarrett/dbmsP2/blob/main/application/db/db.sql) file within the db directory and run this file. This sql script is a combination of the three indiviual scripts and will take longer to run. 
6. Finally, open the index.html file at http://localhost/dbmsP2/application/index.html on your machine to search, delete, update, and insert accidents into the US Accidents database.