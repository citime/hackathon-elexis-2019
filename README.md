# TuniCo Roots

This web application was created as a part of the [ACDH hackathon 2019 ELEXIS](https://github.com/acdh-oeaw/ACDHhackathonELEXIS).
It was implemented with BaseX and RESTXQ. The provided dataset is stored in the database. For the interaction, JavaScript, jQuery, and vis.js were used. Bootstrap 4 is the CSS framework.

The application provides insights to the dataset by choosing radical consonants and roots.

<img src="TuniCo-Roots-Project.png" width="1000">

## Prerequisites

### Download the data

1. Download the provided dataset as *dc_aeb_eng.xml* from [arche.acdh.oeaw.ac.at](https://arche.acdh.oeaw.ac.at/browser/oeaw_detail/id.acdh.oeaw.ac.at/uuid/175b8cdf-5d04-f4d3-a778-67910aa8fd37) (refer to [ACDH hackathon 2019 ELEXIS](https://github.com/acdh-oeaw/ACDHhackathonELEXIS) for more information on the dataset)
2. Download the file *tunico.xqm* from this repository
3. Download the directory `tunico/` from this repository

### Install BaseX

1. Download [BaseX](http://basex.org/download/): ZIP Package or Windows Installer
2. Install/Unpack BaseX (refer to the [documentation of BaseX](http://docs.basex.org/wiki/Startup#Full_Distributions) for more information)

### Set up the Database
1. Start the BaseX HTTP server by running the script *basexhttp.bat* or *basexhttp* from the `BaseX/bin/` directory (refer to the [documentation of BaseX](http://docs.basex.org/wiki/Startup#Web_Application) for more information)
2. Open <http://localhost:8984/dba/login> in the browser
3. Log in to the database administration interface (default login password and user is `admin`)
4. Click *Databases* > *Create...*
5. Enter the database name *hackathon19*
6. Click *Create*  
The database was created.
7. Click *Add...*
8. Click *Browse* and choose the file *dc_aeb_eng.xml*
9. Click *Add*  
The file was added to the *hackathon19* database.

### Set up the Web Application

Make the following modifications to the BaseX webapp directory:

1. Add the file *tunico.xqm* to `BaseX/webapp/`
(Note: Other *.xqm* files with identical paths could lead to conflicts.)

2. Add the directory `tunico/` to `BaseX/webapp/static/`


## Run the Web Application

After completing all of the steps in the Prerequisites section, carry out the following steps to run the web application.

1. (If not yet done:) Start the BaseX HTTP server by running the script *basexhttp.bat* or *basexhttp* from the 'BaseX/bin/` directory (refer to the [documentation of BaseX](http://docs.basex.org/wiki/Startup#Web_Application) for more information)
2. Open <http://localhost:8984/tunico> in the browser

An internet connection is needed to fetch libraries per content delivery network.

### Additional Information

For customizing the appearance, Sass was used. The *.scss* file is included in this repository.
