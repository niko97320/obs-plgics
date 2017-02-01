#!/bin/bash


if [ -f dist-IVM-R287.out ] ; then 
  gnuplot << EOF
    set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
    set output 'dist-IVM-R287.png'
    set title 'dist-IVM-R287'
    plot "dist-IVM-R287.out" u 1:2 w l title "A" lc 3, "dist-IVM-R287.out" u 1:3 w l title "B" lc 1,"dist-IVM-R287.out" u 1:4 w l title "C" lc 7, "dist-IVM-R287.out" u 1:5 w l title "D" lc 8, "dist-IVM-R287.out" u 1:6 w l title "E" lc 6
EOF
fi

if [ -f IVM.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-IVM.png'
set title 'RMSD-IVM'
plot "IVM.out" u 1:2 w l t "A" lc 3, "IVM.out" u 1:3 w l t "B" lc 1,"IVM.out" u 1:4 w l t "C" lc 7, "IVM.out" u 1:5 w l t "D" lc 8, "IVM.out" u 1:6 w l t "E" lc 6
EOF
fi


if [ -f GLY.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-GLY.png'
set title 'RMSD-GLY'
plot "GLY.out" u 1:2 w l t "A" lc 3, "GLY.out" u 1:3 w l t "B" lc 1, "GLY.out" u 1:4 w l t "C" lc 7, "GLY.out" u 1:5 w l t "D" lc 8, "GLY.out" u 1:6 w l t "E" lc 6
EOF
fi

if [ -f DTP.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'dist-T70-P291.png'
set title 'dist-T70-P291'
plot "DTP.out" u 1:2 w l t "A" lc 3, "DTP.out" u 1:3 w l t "B" lc 1,"DTP.out" u 1:4 w l t "C" lc 7, "DTP.out" u 1:5 w l t "D" lc 8, "DTP.out" u 1:6 w l t "E" lc 6
EOF
fi

if [ -f PPS-surf-13prime.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-13-prime.png'
set title 'sigma-13-prime'
plot "PPS-surf-13prime.out" w l
EOF
fi

if [ -f PPS-surf-9prime.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-9-prime.png'
set title 'sigma-9-prime'
plot "PPS-surf-9prime.out" w l
EOF
fi

if [ -f PPS-surf-2prime.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-minus2-prime.png'
set title 'sigma-minus2-prime'
plot "PPS-surf-2prime.out" w l
EOF
fi

if [ -f tiltM2.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_pol.png'
set title 'tiltM2 Pol'
plot "tiltM2.out" u 1:2 w l t "A pol" lc 3,"tiltM2.out" u 1:4 w l t "B pol" lc 1, "tiltM2.out" u 1:6 w l t "C pol" lc 7, "tiltM2.out" u 1:8 w l t "D pol" lc 8, "tiltM2.out" u 1:10 w l t "E pol" lc 6
EOF
fi

if [ -f tiltM2.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_az.png'
set title 'tiltM2 Az'
plot "tiltM2.out" u 1:3 w l t "A az" lc 3, "tiltM2.out" u 1:5 w l t "B az" lc 1 , "tiltM2.out" u 1:7 w l t "C az" lc 7,"tiltM2.out" u 1:9 w l t "D az" lc 8, "tiltM2.out" u 1:11 w l t "E az" lc 6
EOF
fi

if [ -f tiltM2_avg.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_avg.png'
set title 'tiltM2 avg'
plot "tiltM2_avg.out" u 1 w l t "Pol","tiltM2_avg.out"  u 2 w l t "Az"
EOF
fi

if [ -f twist_avg.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'twist_avg.png'
set title 'twist_avg'
plot "twist_avg.out" w l
EOF
fi

