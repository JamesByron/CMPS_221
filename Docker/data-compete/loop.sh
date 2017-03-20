#!/bin/bash
echo "sysbench testing"
echo "This test will perform 4 * 6 = 24 iterations of the loop."
touch RW-4k
touch RR-4k
sleep 2
for run in 1 2 3 4 ;do
echo "Performing test RW-4k-8T-${run}"
echo "Performing test RW-4k-8T-${run}" >> RW-4k
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndwr --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=8 run >> RW-4k
echo "Done. Sleeping for 10 seconds..."
sleep 10
echo "Performing test RR-4k-8T-${run}"
echo "Performing test RR-4k-8T-${run}" >> RR-4k
sysbench --test=fileio --file-total-size=4G --file-test-mode=rndrd --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=8 run >> RR-4k
echo "Done. Sleeping for 10 seconds..."
sleep 10
#echo "Performing test CPU-$8T-${run}"
#echo "Performing test CPU-$8T-${run}" >> CPU
#sysbench --test=cpu --cpu-max-prime=20000 --num-threads=8 run >> CPU
done
sysbench --test=fileio --file-total-size=4G --file-num=64 cleanup
