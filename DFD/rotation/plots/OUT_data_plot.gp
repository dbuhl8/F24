load "paddim_v3_nonrotating.dat"
array Fr[num_data]
do for [i=1:num_data] {
    Fr[i] = B[i]**(-0.5)
}
# Makes the W_rms v Froude^-1 plot
set terminal postscript enh col "Times-Roman,20"
set output "weighted_wrms.eps"
set xlabel "1/Fr" 
set log xy
set xrange [0.8:30]
set yrange [0.02:3]

plot sample \
 [i=1:num_data-2] '+' using (1./Fr[i]):(wlam[i]):(wlerr[i]) w yerrorbars pt 7 ps 2 lw 1 lc rgb "red" notitle,\
[2:25] 12./8.*x**(-0.5) dt 2 lw 3 lc rgb "medium-blue" title "Fr^{1/2}",\
[2:25]  3./2.*x**(-1) dt 2 lw 3 lc rgb "red" title "Fr",\
 "wrms_weighted.dat" i 1 u ($3**(0.5)):6:7 w yerrorbars pt 5 ps 2 lw 1 lc rgb "navy" notitle,\
 "" i 1 u ($3**(0.5)):8:9 w yerrorbars pt 5 ps 2 lw 1 lc rgb "dark-red" notitle,\
 [i=num_data-1:num_data] '+' using (1./Fr[i]):(wturb[i]):(wterr[i]) w yerrorbars pt 9 ps 2 lw 1 lc rgb "royalblue" notitle,\
[i=num_data-1:num_data]  '+' using (1./Fr[i]):(wlam[i]):(wlerr[i]) w yerrorbars pt 9 ps 2 lw 1 lc rgb "coral" notitle,\
[i=1:num_data-2] '+' using (1./Fr[i]):(1.3*wturb[i]):(wterr[i]) w yerrorbars pt 7 ps 2 lw 1 lc rgb "medium-blue" notitle


#reset
#load "paddim_v3_nonrotating.dat"
#set terminal postscript enh col "Times-Roman,20"
#set output "mixing_efficiency.eps"
#set xrange [.8:1010]
#set yrange [0.1:1]
#set title "Mixing Efficiency"
#set xlabel "B"
#set log xy
#plot sample [i=1:num_data] '+' using (B[i]):(mix[i]):(mixerr[i]) w yerrorbars pt 5 ps 1 lc rgb "red" title "Stochastic Re=600 Pe=60", "Final_data.dat" i 5 u 2:42:43 w yerrorbars pt 7 ps 1 lc rgb "medium-blue" title "Steady Re=600 Pe=60", "Final_data.dat" i 9 u 2:42:43 w yerrorbars pt 7 ps 1 lc rgb "dark-spring-green" title "Steady Re=1000 Pe=100"
