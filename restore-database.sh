#!/bin/bash
# Esperar a que el servicio de SQL Server inicie (esto puede tardar unos segundos)
sleep 30s

# Ejecutar el comando para restaurar la base de datos
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P yourStrong#Password -Q "
RESTORE DATABASE AdventureWorks2019
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2019.bak'
WITH MOVE 'AdventureWorks2019' TO '/var/opt/mssql/data/AdventureWorks2019.mdf',
     MOVE 'AdventureWorks2019_log' TO '/var/opt/mssql/data/AdventureWorks2019_log.ldf';
"
