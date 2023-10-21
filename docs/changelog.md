# Change log for CnC-WebGUI and CnC-Agent

# 1.4.3 (SSH Access)



# 1.4.2 (CPU/Memory Performence Patch)

1. CPU Usage 

    * CPU usage has been lowered a lot on the agents 
        (Reduced from 8~10% to ~0.5% with a peak every 5 mins)
        (This might be incressed to 10-15 min, to limit uneeded overload)

    * CPU usage has also been fix on the server part aswell.
        (Same issue as above)

2. Memory Usage

    * The memory usage has been limited for all docker containers, to keep the usage of memory as low as possible.

# 1.4.1 (Theme Patch/Request Rate Patch)

1. Added New design for the index page 
    
    * Added help/wiki links 

    * Added embed link of this change log 

    * Added feature/function description 

    * Added "Made By RPH" Footer

    * Made CSS a lot more mobile and tablet friendly 

2. Patched Request Rate

    * Packages no longer gets checked every minute but every 5 minutes.

    * Cronjob no longer gets checked every minute but every 5 minutes.

    * Overview no longer gets checked every minute but every 5 minutes.


# 1.4 (Full Update for first release)

## Nginx (Packages, Cronjob and Overview)

1. Data Source:

    * In "Version 1.2," the code retrieves data from a PostgreSQL database.

    * In "Version 1.4," the code fetches data from an API using the file_get_contents function.

2. HTML Structure:

    * In "Version 1.2," the code uses a single table to display the data.

    * In "Version 1.4," the code separates the table into two parts:
        * One table (packagesTable) for headers.
        * Another table (dataTable) for data rows.

3. Styling and JavaScript:

    * "Version 1.4" includes a link to an external stylesheet (style.css) for styling purposes.

    * It also includes JavaScript code for a search functionality that allows users to filter the data based on input.

4. Table Structure:

    * In "Version 1.2," the table has multiple columns for specific package names (e.g., git, wget, sudo).

    * In "Version 1.4," the table has a simplified structure with columns for "Hostname," "Package Name," and "Status."

5. HTML Tags:

    * In "Version 1.2," there is a <body> tag with inline styling to set the background color.

    * In "Version 1.4," the <body> tag and other HTML tags have been modified to include additional elements and classes for styling.

6. Error Handling:

    * In "Version 1.2," error handling is done with die statements.

    * In "Version 1.4," error handling is also done with die statements, but in the context of fetching and parsing data from the API.

7. API Integration:

    * "Version 1.4" includes API integration code to fetch data, parse JSON, and display it in the HTML table.

>These are the key changes made from "Version 1.2" to "Version 1.4" of the code. The structure and functionality of the code have been significantly updated to integrate an external API, provide a better user interface, and include a search feature.

## Nodejs 

1. Function Refactoring:

    * Added handleDatabaseOperationAll function, which handles database operations returning multiple rows.

    * Added handleDatabaseOperationSingle function, which handles database operations returning a single row.

    * These functions were introduced to distinguish between queries returning multiple rows and queries returning a single row, improving code organization.

2. Status Code Change:

    * In the handleDatabaseOperationAll function, changed the response status from 201 to 200 for queries returning multiple rows. This ensures the HTTP status code accurately represents the success of retrieving data.

3. Error Logging:

    * Added a new function, logError, to log errors for debugging purposes. This enhances error handling and debugging capabilities.

4. New Endpoints:

    * Added a new GET endpoint to retrieve all data from a specified table: /read/:table. It uses the handleDatabaseOperationAll function to return all rows from the specified table.

5. Updates to Create and Update Endpoints:

    * In the create and update endpoints, changed the response status from 201 to 200 when using the handleDatabaseOperationSingle function. This change aligns the response status with the general practice for success in read operations.

6. New Read Endpoint for Specific Package:

    * Added a new GET endpoint to retrieve data for a specific package within a table: /read/:table/:hostname/:package. This allows querying for specific package details within the specified table.

7. Package Name Validation:

    * In the /update/packages/:hostname/:package endpoint, added validation to check if the specified package matches any column name. If it does, it allows updating; otherwise, it returns a 400 error.

>These changes enhance code modularity, improve error handling, and add new functionality for retrieving specific data within tables and better representation of HTTP status codes for different operations.

## Postgres 

1. New database

    * Version 1.0 and 1.2 have "on/off" used MySQL as a database, this was MySQL 5.7. It was using 5.7 to avoid issues with authentication between dockers.

    * The database was changed because the MySQL didn't want to play nice with the docker network, so it could send data to the WebGUI, but not the nodejs "API".

2. New method to send collected information to server

    * MySQL was also based on the fact that the Agents running CnC-Agent had to install MySQL to send data to the database, this is both insecure and a hassle to setup so I went with postgres instead.

3. API?

    * The Nodejs "API" has been added so that if needed I can add a Redis server as a cache server for the database if it becomes overtaxed or overworked.

## Installation 

1. Updated Installation Script CnC-WebGUI

2. Updated Installation Script CnC-Agent


# 1.2 (First Release)

* Added basic code for everything
* Made all the basic script to collect information
* Made basic web interface



