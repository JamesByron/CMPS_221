#!/bin/bash
echo "sysbench testing"
echo "This test will perform 4 * 6 = 24 iterations of the loop."
echo "1. Create 4gb test file."
echo "2. Start looping."
echo "3. Run Random wrote and random read tests with direct file io."
echo "4. Run Random wrote and random read tests without direct file io."
echo "5. Create mysql database."
echo "5. Run mysql test."
echo "6. Drop mysql database."
echo "7. run cpu test."
touch RW-direct-4k
touch RR-direct-4k
touch RW-4k
touch RR-4k
touch RW-direct-1m
touch RR-direct-1m
touch RW-1m
touch RR-1m
touch SQL
touch CPU
sysbench --test=fileio --file-total-size=4G --file-num=64 prepare
sleep 10
for thread in 1 2 3 4 8 16 ;do
for run in 1 2 3 4 ;do
echo "Performing test RW-direct-4k-${thread}T-${run}"
echo "Performing test RW-direct-4k-${thread}T-${run}" >> RW-direct-4k
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndwr --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=${thread} --file-extra-flags=direct run >> RW-direct-4k
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RR-direct-4k-${thread}T-${run}"
echo "Performing test RR-direct-4k-${thread}T-${run}" >> RR-direct-4k
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrd --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=${thread} --file-extra-flags=direct run >> RR-direct-4k
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RW-4k-${thread}T-${run}"
echo "Performing test RW-4k-${thread}T-${run}" >> RW-4k
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndwr --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=${thread} run >> RW-4k
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RR-4k-${thread}T-${run}"
echo "Performing test RR-4k-${thread}T-${run}" >> RR-4k
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrd --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=${thread} run >> RR-4k
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RW-direct-1m-${thread}T-${run}"
echo "Performing test RW-direct-1m-${thread}T-${run}" >> RW-direct-1m
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndwr --max-time=60 --max-requests=0 --file-block-size=1M --file-num=64 --num-threads=${thread} --file-extra-flags=direct run >> RW-direct-1m
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RR-direct-1m-${thread}T-${run}"
echo "Performing test RR-direct-1m-${thread}T-${run}" >> RR-direct-1m
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrd --max-time=60 --max-requests=0 --file-block-size=1M --file-num=64 --num-threads=${thread} --file-extra-flags=direct run >> RR-direct-1m
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RW-1m-${thread}T-${run}"
echo "Performing test RW-1m-${thread}T-${run}" >> RW-1m
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndwr --max-time=60 --max-requests=0 --file-block-size=1M --file-num=64 --num-threads=${thread} run >> RW-1m
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RR-1m-${thread}T-${run}"
echo "Performing test RR-1m-${thread}T-${run}" >> RR-1m
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrd --max-time=60 --max-requests=0 --file-block-size=1M --file-num=64 --num-threads=${thread} run >> RR-1m
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test SQL-${thread}T-${run}"
echo "Performing test SQL-${thread}T-${run}" >> SQL
mysql -u root -ppassword -e "CREATE DATABASE sysbench;"
sysbench --test=oltp --db-driver=mysql --oltp-table-size=40000000 --mysql-db=sysbench --mysql-user=sysbench --mysql-password=password prepare
sysbench --test=oltp --db-driver=mysql --oltp-table-size=40000000 --mysql-db=sysbench --mysql-user=sysbench --mysql-password=password --max-time=60 --max-requests=0 --num-threads=${thread} run >> SQL
sysbench --test=oltp --db-driver=mysql --oltp-table-size=40000000 --mysql-db=sysbench --mysql-user=sysbench --mysql-password=password cleanup
mysql -u root -ppassword -e "DROP DATABASE sysbench;"
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test CPU-${thread}T-${run}"
echo "Performing test CPU-${thread}T-${run}" >> CPU
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=${thread} run >> CPU
done
done
touch FinalData
sysbench --test=fileio --file-total-size=4G --file-num=64 cleanup
echo "RW-direct-4k" >> FinalData
cat RW-direct-4k >> FinalData
echo "-----" >> FinalData
echo "RW-direct-1m" >> FinalData
cat RW-direct-1m >> FinalData
echo "-----" >> FinalData
echo "RR-direct-4k" >> FinalData
cat RR-direct-4k >> FinalData
echo "-----" >> FinalData
echo "RR-direct-1m" >> FinalData
cat RR-direct-1m >> FinalData
echo "-----" >> FinalData
echo "RW-4k" >> FinalData
cat RW-4k >> FinalData
echo "-----" >> FinalData
echo "RW-1m" >> FinalData
cat RW-1m >> FinalData
echo "-----" >> FinalData
echo "RR-4k" >> FinalData
cat RR-4k >> FinalData
echo "-----" >> FinalData
echo "RR-1m" >> FinalData
cat RR-1m >> FinalData
echo "-----" >> FinalData
echo "SQL" >> FinalData
cat SQL >> FinalData
echo "-----" >> FinalData
echo "CPU" >> FinalData
cat CPU >> FinalData
echo "-----" >> FinalData
echo "" >> FinalData
cat sysbench-loop.sh >> FinalData
sudo /etc/cron.weekly/fstrim