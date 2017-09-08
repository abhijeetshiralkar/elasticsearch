@echo off

REM remove all log files older than 10 days
forfiles -p logs -m "log-*.txt" -d -10 -c "cmd /c del @path" 2>nul

REM Country to be processed
echo ---Start Setting Configurations---
set COUNTRY=ca

REM Database related parameters
set DATABASE=IMOnlineImpulse
set DATABASE_HOST=10.22.146.74
set DATABASE_PORT=7006
set DATABASE_USERNAME=imonlineendeca
set DATABASE_PASSWORD=welcome12345
set DATABASE_DRIVER_PATH=D:\ElasticSearch\sqldriver

REM Elasticsearch related parameters
set ELASTICSEARCH_HOST=https://f6e4407d7c584f3ae715de903270e6b6.us-east-1.aws.found.io:443
set ELASTICSEARCH_USER=elastic
set ELASTICSEARCH_PASSWORD=Q5A0qM4o5sJTxIDeGnzqvqyk
set ELASTICSEARCH_USER_PASSWORD=elastic:Q5A0qM4o5sJTxIDeGnzqvqyk

REM required paths i.e. logstash, curator etc
set LOGSTASH_PATH=D:\ElasticSearch\logstash-5.4.0\bin
set LOGSTASH_CONFIG_PATH=D:\ElasticSearch\data\configs
set LOGSTASH_SQL_FILEPATH=D:\ElasticSearch\data\CA\STG\SQL
set CURATOR_PATH=D:\ElasticSearch\curator-5.1.2-amd64
set CURATOR_ACTION_FILE_PATH=D:\ElasticSearch\data\configs\action.yml
set CURATOR_ACTION_DELETE_INDICES_FILE_PATH=D:\ElasticSearch\data\configs\action_delete_index.yml
set CURATOR_CONFIG_FILE_PATH=D:\ElasticSearch\data\configs\config.yml
set CURATOR_ACTION_REFRESH_INTERVAL_FILE_PATH=D:\ElasticSearch\data\configs\action_refresh_interval.yml
set CURATOR_ACTION_FORCE_MERGE_FILE_PATH=D:\ElasticSearch\data\configs\action_force_merge.yml

REM INDEX names
set CURRENT_TIME=%time:~0,2%.%time:~3,2%
for /f "tokens=* delims= " %%a in ("%CURRENT_TIME%") do set CURRENT_TIME=%%a
set CURRENT_DATETIME=%date:~10,4%.%date:~4,2%.%date:~7,2%.%CURRENT_TIME%
set INDEX_NAME_PREFIX=imweb.%COUNTRY%
set IMPRODUCT_INDEX_NAME=%INDEX_NAME_PREFIX%-products-%CURRENT_DATETIME%
set IMPRODUCT_DETAIL_INDEX_NAME=%INDEX_NAME_PREFIX%-pdetails-%CURRENT_DATETIME%

REM Alias name
set ALIAS_NAME=imweb.%COUNTRY%

echo ---End Setting Configurations---
REM create folder logs
if not exist logs mkdir logs

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo ---Start Main Index Creation---

echo Creating index %IMPRODUCT_INDEX_NAME% >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMProducts.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMProducts.conf >> logs\log-%CURRENT_DATETIME%.txt 
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMProducts.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMProducts.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMProducts.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMprice.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMprice.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMprice.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMprice.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMprice.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMTechSpec.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMTechSpec.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMTechSpec.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMTechSpec.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMTechSpec.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMKits.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMKits.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMKits.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMKits.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMKits.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMcampaign.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMcampaign.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMcampaign.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMcampaign.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMcampaign.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMSimilarProd.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMSimilarProd.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMSimilarProd.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMSimilarProd.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMSimilarProd.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMAggregatedProducts.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMAggregatedProducts.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMAggregatedProducts.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMAggregatedProducts.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMAggregatedProducts.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo ---End Main Index Creation---

echo ---Start Product Details Index Creation---

echo Started processing IMProdSpec.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMProdSpec.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMProdSpec.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMProdSpec.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMProdSpec.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt

echo Started processing IMCrossSell.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%
echo Started processing IMCrossSell.conf >> logs\log-%CURRENT_DATETIME%.txt
call %LOGSTASH_PATH%\logstash.bat -f %LOGSTASH_CONFIG_PATH%\IMCrossSell.conf >> logs\log-%CURRENT_DATETIME%.txt
rem In case of ERROR in the log file we have to handle the error situation
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER
echo Completed processing IMCrossSell.conf >> logs\log-%CURRENT_DATETIME%.txt
echo Completed processing IMCrossSell.conf at %date:~10,4%.%date:~4,2%.%date:~7,2%.%time:~0,2%.%time:~3,2%

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo ---End Product Details Index Creation---

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo Updating alias
REM Once the product and product details indexes are completed remove the existing indices mapped to the alias and add these new indices
echo Updating alias %ALIAS_NAME% >> logs\log-%CURRENT_DATETIME%.txt
%CURATOR_PATH%\curator --config %CURATOR_CONFIG_FILE_PATH% %CURATOR_ACTION_FILE_PATH% >> logs\log-%CURRENT_DATETIME%.txt
find "ERROR" logs\log-%CURRENT_DATETIME%.txt >nul
if %errorlevel% equ 0 GOTO ERROR_HANDLER

echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo ---End Updating alias---

REM We dont check errors for below two tasks i.e. refresh interval setup and force merge because even if they fail we don't want the error handler to be invoked
echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo Changing the index refresh interval
echo Setting index refresh interval >> logs\log-%CURRENT_DATETIME%.txt
set INDEX_REFRESH_INTERVAL=60s 
%CURATOR_PATH%\curator --config %CURATOR_CONFIG_FILE_PATH% %CURATOR_ACTION_REFRESH_INTERVAL_FILE_PATH% >> logs\log-%CURRENT_DATETIME%.txt
echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo ---End Refresh Interval update---

REM Force merge to single segment so that search performance is improved so that search happens in a single segment instead of searching in multiple segments
echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo Peforming force merge
echo Peforming force merge >> logs\log-%CURRENT_DATETIME%.txt
%CURATOR_PATH%\curator --config %CURATOR_CONFIG_FILE_PATH% %CURATOR_ACTION_FORCE_MERGE_FILE_PATH% >> logs\log-%CURRENT_DATETIME%.txt
echo -------------------------------------------------------------------------------------------------------- >> logs\log-%CURRENT_DATETIME%.txt
echo ---End Force Merge---
EXIT /B

rem In case of error delete both product and product_details indices if created
:ERROR_HANDLER
echo Deleting the indices if already created in case of error
%CURATOR_PATH%\curator --config %CURATOR_CONFIG_FILE_PATH% %CURATOR_ACTION_DELETE_INDICES_FILE_PATH% >> logs\log-%CURRENT_DATETIME%.txt
echo Error occured while processing batch. Check file one.txt for more details!!!
EXIT /B