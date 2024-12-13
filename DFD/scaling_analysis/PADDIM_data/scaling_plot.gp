

set term postscript enh col "Times-Roman, 25"
set output "scaling.eps"

set xrange [50:2200]
set log xy
set title "Scaling Analysis"
set xlabel "Number of Processors"
set ylabel "Time/Timestep" rotate by 0

plot "scaling.dat" i 0 u 1:2 w lp lw 2 lc rgb "red" title "256x256x64",\
     "scaling.dat" i 1 u 1:2 w lp lw 2 lc rgb "blue" title "512x512x128"

