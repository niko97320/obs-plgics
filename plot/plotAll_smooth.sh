#!/bin/bash


if [ -f dist-IVM-R287_smooth.out ] ; then 
  gnuplot << EOF
    set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
    set output 'dist-IVM-R287_smooth.png'
    #set title 'dist-IVM-R287'
    set xlabel 'Frame' 
    set ylabel '<Distance IVM R287>' 
    plot "dist-IVM-R287_smooth.out" u 1:2 w l title "A" lc 3, "dist-IVM-R287_smooth.out" u 1:3 w l title "B" lc 1,"dist-IVM-R287_smooth.out" u 1:4 w l title "C" lc 7, "dist-IVM-R287_smooth.out" u 1:5 w l title "D" lc 8, "dist-IVM-R287_smooth.out" u 1:6 w l title "E" lc 6
EOF
fi

if [ -f IVM_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-IVM_smooth.png'
#set title 'RMSD-IVM'
set xlabel 'Frame' 
set ylabel '<Ivermectin RMSD>' 
plot "IVM_smooth.out" u 1:2 w l t "A" lc 3, "IVM_smooth.out" u 1:3 w l t "B" lc 1,"IVM_smooth.out" u 1:4 w l t "C" lc 7, "IVM_smooth.out" u 1:5 w l t "D" lc 8, "IVM_smooth.out" u 1:6 w l t "E" lc 6
EOF
fi


if [ -f GLY_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-GLY_smooth.png'
#set title 'RMSD-GLY'
set xlabel 'Frame' 
set ylabel '<Glycine RMSD>' 
plot "GLY_smooth.out" u 1:2 w l t "A" lc 3, "GLY_smooth.out" u 1:3 w l t "B" lc 1, "GLY_smooth.out" u 1:4 w l t "C" lc 7, "GLY_smooth.out" u 1:5 w l t "D" lc 8, "GLY_smooth.out" u 1:6 w l t "E" lc 6
EOF
fi

if [ -f GLU_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-GLU_smooth.png'
#set title 'RMSD-GLU'
set xlabel 'Frame' 
set ylabel '<Glutamate RMSD>' 
plot "GLU_smooth.out" u 1:2 w l t "A" lc 3, "GLU_smooth.out" u 1:3 w l t "B" lc 1, "GLU_smooth.out" u 1:4 w l t "C" lc 7, "GLU_smooth.out" u 1:5 w l t "D" lc 8, "GLU_smooth.out" u 1:6 w l t "E" lc 6
EOF
fi

if [ -f DTP_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'dist-T70-P291_smooth.png'
#set title 'dist-T70-P291'
set xlabel 'Frame' 
set ylabel '<Distance threonin proline>' 
plot "DTP_smooth.out" u 1:2 w l t "A" lc 3, "DTP_smooth.out" u 1:3 w l t "B" lc 1,"DTP_smooth.out" u 1:4 w l t "C" lc 7, "DTP_smooth.out" u 1:5 w l t "D" lc 8, "DTP_smooth.out" u 1:6 w l t "E" lc 6
EOF
fi

if [ -f PPS-surf-13prime_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-13-prime_smooth.png'
#set title 'sigma-13-prime'
set xlabel 'Frame' 
set ylabel 'Pore surface 13\'' 
plot "PPS-surf-13prime_smooth.out" w l
EOF
fi

if [ -f PPS-surf-9prime_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-9-prime_smooth.png'
#set title 'sigma-9-prime'
set xlabel 'Frame' 
set ylabel '<Pore surface 9\'>' 
plot "PPS-surf-9prime_smooth.out" w l
EOF
fi

if [ -f PPS-surf-2prime_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-minus2-prime_smooth.png'
#set title 'sigma-minus2-prime'
set xlabel 'Frame' 
set ylabel '<Pore surface 2\'>' 
plot "PPS-surf-2prime_smooth.out" w l
EOF
fi

if [ -f tiltM2-lower_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2-lower_avg_smooth.png'
#set title 'tiltM2\_avg'
set xlabel 'Frame' 
set ylabel '<titlM2-lower\_avg>' 
plot "tiltM2-lower_avg_smooth.out" u 2 w l t "Pol","tiltM2-lower_avg_smooth.out"  u 3 w l t "Az"
EOF
fi

if [ -f tiltM2-upper_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2-upper_avg_smooth.png'
#set title 'tiltM2\_avg'
set xlabel 'Frame' 
set ylabel '<titlM2-upper\_avg>' 
plot "tiltM2-upper_avg_smooth.out" u 2 w l t "Pol","tiltM2-upper_avg_smooth.out"  u 3 w l t "Az"
EOF
fi


if [ -f tiltM2-full_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2-full_avg_smooth.png'
#set title 'tiltM2\_avg'
set xlabel 'Frame' 
set ylabel '<titlM2-full\_avg>' 
plot "tiltM2-full_avg_smooth.out" u 2 w l t "Pol","tiltM2-full_avg_smooth.out"  u 3 w l t "Az"
EOF
fi

if [ -f tiltB_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltB_avg_smooth.png'
#set title 'tiltB\_avg'
set xlabel 'Frame' 
set ylabel '<titlB\_avg>' 
plot "tiltB_avg_smooth.out" u 2 w l t "Pol","tiltB_avg_smooth.out"  u 3 w l t "Az"
EOF
fi

if [ -f twist_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'twist_avg_smooth.png'
#set title '<twist\_avg>'
set xlabel 'Frame' 
set ylabel '<twist\_avg>' 
plot "twist_avg_smooth.out" w l
EOF
fi

if [ -f DVP_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'dvp_avg_smooth.png'
set xlabel 'Frame' 
set ylabel '<DVP\_avg>' 
plot "DVP_avg_smooth.out w l
EOF
fi

if [ -f tiltB_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltB_pol_smooth.png'
#set title 'tiltM2 Pol'
set xlabel 'Frame' 
set ylabel '<titlB pol>' 
plot "tiltB_smooth.out" u 1:2 w l t "A pol" lc 3,"tiltB_smooth.out" u 1:4 w l t "B pol" lc 1, "tiltB_smooth.out" u 1:6 w l t "C pol" lc 7, "tiltB_smooth.out" u 1:8 w l t "D pol" lc 8, "tiltB_smooth.out" u 1:10 w l t "E pol" lc 6
EOF
fi

