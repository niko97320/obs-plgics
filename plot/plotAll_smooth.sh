#!/bin/bash


if [ -f dist-IVM-R287_smooth.out ] ; then 
  gnuplot << EOF
    set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
    set output 'dist-IVM-R287_smooth.png'
    set title 'dist-IVM-R287'
    plot "dist-IVM-R287_smooth.out" u 1:2 w l title "A" lc 3, "dist-IVM-R287_smooth.out" u 1:3 w l title "B" lc 1,"dist-IVM-R287_smooth.out" u 1:4 w l title "C" lc 7, "dist-IVM-R287_smooth.out" u 1:5 w l title "D" lc 8, "dist-IVM-R287_smooth.out" u 1:6 w l title "E" lc 6
EOF
fi

if [ -f IVM_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-IVM_smooth.png'
set title 'RMSD-IVM'
plot "IVM_smooth.out" u 1:2 w l t "A" lc 3, "IVM_smooth.out" u 1:3 w l t "B" lc 1,"IVM_smooth.out" u 1:4 w l t "C" lc 7, "IVM_smooth.out" u 1:5 w l t "D" lc 8, "IVM_smooth.out" u 1:6 w l t "E" lc 6
EOF
fi


if [ -f GLY_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-GLY_smooth.png'
set title 'RMSD-GLY'
plot "GLY_smooth.out" u 1:2 w l t "A" lc 3, "GLY_smooth.out" u 1:3 w l t "B" lc 1, "GLY_smooth.out" u 1:4 w l t "C" lc 7, "GLY_smooth.out" u 1:5 w l t "D" lc 8, "GLY_smooth.out" u 1:6 w l t "E" lc 6
EOF
fi

if [ -f DTP_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'dist-T70-P291_smooth.png'
set title 'dist-T70-P291'
plot "DTP_smooth.out" u 1:2 w l t "A" lc 3, "DTP_smooth.out" u 1:3 w l t "B" lc 1,"DTP_smooth.out" u 1:4 w l t "C" lc 7, "DTP_smooth.out" u 1:5 w l t "D" lc 8, "DTP_smooth.out" u 1:6 w l t "E" lc 6
EOF
fi

if [ -f PPS-surf-13prime_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-13-prime_smooth.png'
set title 'sigma-13-prime'
plot "PPS-surf-13prime_smooth.out" w l
EOF
fi

if [ -f PPS-surf-9prime_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-9-prime_smooth.png'
set title 'sigma-9-prime'
plot "PPS-surf-9prime_smooth.out" w l
EOF
fi

if [ -f PPS-surf-2prime_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-minus2-prime_smooth.png'
set title 'sigma-minus2-prime'
plot "PPS-surf-2prime_smooth.out" w l
EOF
fi

if [ -f tiltM2_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_pol_smooth.png'
set title 'tiltM2 Pol'
plot "tiltM2_smooth.out" u 1:2 w l t "A pol" lc 3,"tiltM2_smooth.out" u 1:4 w l t "B pol" lc 1, "tiltM2_smooth.out" u 1:6 w l t "C pol" lc 7, "tiltM2_smooth.out" u 1:8 w l t "D pol" lc 8, "tiltM2_smooth.out" u 1:10 w l t "E pol" lc 6
EOF
fi

if [ -f tiltM2_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_az_smooth.png'
set title 'tiltM2 Az'
plot "tiltM2_smooth.out" u 1:3 w l t "A az" lc 3, "tiltM2_smooth.out" u 1:5 w l t "B az" lc 1 , "tiltM2_smooth.out" u 1:7 w l t "C az" lc 7,"tiltM2_smooth.out" u 1:9 w l t "D az" lc 8, "tiltM2_smooth.out" u 1:11 w l t "E az" lc 6
EOF
fi

if [ -f tiltM2_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_avg_smooth.png'
set title 'tiltM2 avg'
plot "tiltM2_avg_smooth.out" u 1 w l t "Pol","tiltM2_avg_smooth.out"  u 2 w l t "Az"
EOF
fi

if [ -f twist_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'twist_avg_smooth.png'
set title 'twist_avg'
plot "twist_avg_smooth.out" w l
EOF
fi

