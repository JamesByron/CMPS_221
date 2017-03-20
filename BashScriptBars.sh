#!/bin/bash
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "CPU Time" font ",25"
set output "Charts/CPU-Time-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:30]
set xrange [.5:6.5]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
set ylabel "Time (ms)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
plot 'Data/base-CPU-time.tsv' using 1 t 'Baseline', 'Data/docker-CPU-time.tsv' using 1 t 'Docker', 'Data/vm-CPU-time.tsv' using 1 t 'KVM'
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "4Kb Writes Without Caching" font ",25"
set output "Charts/RW-Direct-4k-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:]
set xrange [.5:6.5]
set ylabel "Transfer Rate (Mb/sec)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
plot 'Data/base-RW-direct-4k.tsv' using 4 t 'Baseline', 'Data/docker-RW-direct-4k.tsv' using 4 t 'Docker', 'Data/vm-RW-direct-4k.tsv' using 4 t 'KVM'
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "1Mb Writes Without Caching" font ",25"
set output "Charts/RW-Direct-1m-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:]
set xrange [.5:6.5]
set ylabel "Transfer Rate (Mb/sec)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
plot 'Data/base-RW-direct-1m.tsv' using 4 t 'Baseline', 'Data/docker-RW-direct-1m.tsv' using 4 t 'Docker', 'Data/vm-RW-direct-1m.tsv' using 4 t 'KVM'
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "4Kb Reads Without Caching" font ",25"
set output "Charts/RR-Direct-4k-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:450]
set xrange [.5:6.5]
set ylabel "Transfer Rate (Mb/sec)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
plot 'Data/base-RR-direct-4k.tsv' using 4 t 'Baseline', 'Data/docker-RR-direct-4k.tsv' using 4 t 'Docker', 'Data/vm-RR-direct-4k.tsv' using 4 t 'KVM'
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "1Mb Reads Without Caching" font ",25"
set output "Charts/RR-Direct-1m-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:]
set xrange [.5:6.5]
set ylabel "Transfer Rate (Mb/sec)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
plot 'Data/base-RR-direct-1m.tsv' using 4 t 'Baseline', 'Data/docker-RR-direct-1m.tsv' using 4 t 'Docker', 'Data/vm-RR-direct-1m.tsv' using 4 t 'KVM'
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "1Mb Writes Without Caching" font ",25"
set output "Charts/RW-Direct-1m-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:150]
set xrange [.5:6.5]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
set ylabel "Transfer Rate (Mb/sec)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
plot "Data/base-RW-direct-1m.tsv" using 4 title "Baseline", "Data/docker-RW-direct-1m.tsv" using 4 title "Docker", "Data/vm-RW-direct-1m.tsv" using 4 title "KVM"
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "SQL Queries" font ",25"
set output "Charts/SQL-queries-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:]
set xrange [.5:6.5]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
set ylabel "Queries per Second" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
plot "Data/base-SQL-total.tsv" using (\$1/60) title "Baseline", "Data/docker-SQL-total.tsv" using (\$1/60) title "Docker", "Data/vm-SQL-total.tsv" using (\$1/60) title "KVM"
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "SQL Latency, 95th Percentile" font ",25"
set output "Charts/SQL-latency-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:]
set xrange [.5:6.5]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
set ylabel "Time (ms)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
plot "Data/base-SQL-95.tsv" using 2 title "Baseline", "Data/docker-SQL-95.tsv" using 2 title "Docker", "Data/vm-SQL-95.tsv" using 2 title "KVM"
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "SQL Queries in Separate Environments" font ",25" offset 0,1
set output "Charts/IPC-queries-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:]
set xrange [.5:6.5]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
set ylabel "Queries per Second" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
plot "Data/base-SQL-total.tsv" using (\$1/60) title "Baseline", "Data/docker-IPC-SQL-total.tsv" using (\$1/60) title "Docker", "Data/vm-IPC-SQL-total.tsv" using (\$1/60) title "KVM"
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "SQL Latency, 95th Percentile, Separate Environments" font ",25" offset 0,1
set output "Charts/IPC-latency-bars.eps"
set xtics ("1" 1, "2" 2, "3" 3, "4" 4, "8" 5, "16" 6) font ",25"
set ytics  font ",25"
set yrange [0:]
set xrange [.5:6.5]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
set ylabel "Time (ms)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
plot "Data/base-SQL-95.tsv" using 2 title "Baseline", "Data/docker-IPC-SQL-95.tsv" using 2 title "Docker", "Data/vm-IPC-SQL-95.tsv" using 2 title "KVM"
EOF
sleep 1
gnuplot <<EOF
set terminal postscript eps color
set key outside right above font ",25" spacing 3.5 width 3 vertical
set title "Concurrent Writes" font ",25" offset 0,1
set output "Charts/RW-compete-bars.eps"
set ytics  font ",25"
set yrange [0:]
set style data histogram
set style histogram cluster gap 1
set style fill solid
set boxwidth 1.0
set ylabel "Transfer Rate (Mb/sec)" font ",25" offset -1,0
set xlabel "Number of Threads" font ",25" offset 0,-1
plot "Data/docker-RW-compete-1.tsv" using 4 title "D1", "Data/docker-RW-compete-2.tsv" using 4 title "d2", "Data/vm-RW-compete-1.tsv" using 4 title "KVM1", "Data/vm-RW-compete-2.tsv" using 4 title "KVM2"
EOF
