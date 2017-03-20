#!/bin/bash
echo "sysbench testing"
echo "This test will perform 4 * 6 = 24 iterations of the loop."
echo "1. Create 4gb test file."
echo "2. Start looping."
echo "3. Create mysql database."
echo "4. Run mysql test."
echo "5. Drop mysql database."
touch SQL
sleep 10
for thread in 1 2 3 4 8 16 ;do
for run in 1 2 3 4 ;do
echo "Performing test IPC-SQL-${thread}T-${run}"
echo "Performing test IPC-SQL-${thread}T-${run}" >> SQL
sysbench --test=oltp --db-driver=mysql --mysql-host=172.17.0.3 --oltp-table-size=40000000 --mysql-db=sysbench --mysql-user=sysbench --mysql-password=password prepare
sysbench --test=oltp --db-driver=mysql --mysql-host=172.17.0.3 --oltp-table-size=40000000 --mysql-db=sysbench --mysql-user=sysbench --mysql-password=password --max-time=60 --max-requests=0 --num-threads=${thread} run >> SQL
sysbench --test=oltp --db-driver=mysql --mysql-host=172.17.0.3 --oltp-table-size=40000000 --mysql-db=sysbench --mysql-user=sysbench --mysql-password=password cleanup
echo "Done. Sleeping for 10 seconds..."
sleep 10
done
done
touch FinalData
echo "IPC-SQL" >> FinalData
cat SQL >> FinalData
echo "-----" >> FinalData
echo "" >> FinalData
