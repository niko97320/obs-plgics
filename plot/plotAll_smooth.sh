#! /bin/bash
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

if [ -f LIG_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'RMSD-LIG_smooth.png'
#set title 'RMSD-LIG'
set xlabel 'Frame' 
set ylabel '<LIG RMSD>' 
plot "LIG_smooth.out" u 1:2 w l t "A" lc 3, "LIG_smooth.out" u 1:3 w l t "B" lc 1, "LIG_smooth.out" u 1:4 w l t "C" lc 7, "LIG_smooth.out" u 1:5 w l t "D" lc 8, "LIG_smooth.out" u 1:6 w l t "E" lc 6
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
set ylabel 'Pore surface 9\'' 
plot "PPS-surf-9prime_smooth.out" w l
EOF
fi
if [ -f PPS-surf-2prime_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'sigma-minus2-prime_smooth.png'
#set title 'sigma-minus2-prime'
set xlabel 'Frame' 
set ylabel 'Pore surface 2\'' 
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
plot "tiltM2-lower_avg_smooth.out" u 1:2 w l t "Pol","tiltM2-lower_avg_smooth.out"  u 1:3 w l t "Az"
EOF
fi
if [ -f tiltM2-upper_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2-upper_avg_smooth.png'
#set title 'tiltM2\_avg'
set xlabel 'Frame' 
set ylabel '<titlM2-upper\_avg>' 
plot "tiltM2-upper_avg_smooth.out" u 1:2 w l t "Pol","tiltM2-upper_avg_smooth.out"  u 1:3 w l t "Az"
EOF
fi

if [ -f tiltM2-full_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2-full_avg_smooth.png'
#set title 'tiltM2\_avg'
set xlabel 'Frame' 
set ylabel '<titlM2-full\_avg>' 
plot "tiltM2-full_avg_smooth.out" u 1:2 w l t "Pol","tiltM2-full_avg_smooth.out"  u 1:3 w l t "Az"
EOF
fi
if [ -f tiltB_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltB_avg_smooth.png'
#set title 'tiltB\_avg'
set xlabel 'Frame' 
set ylabel '<titlB\_avg>' 
plot "tiltB_avg_smooth.out" u 1:2 w l t "Pol","tiltB_avg_smooth.out"  u 1:3 w l t "Az"
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
if [ -f m2m3_b1b2_avg_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'm2m3_b1b2_avg_smooth.png'
set xlabel 'Frame' 
set ylabel '<m2m3_b1b2\_avg>' 
plot "m2m3_b1b2_avg_smooth.out" w l
EOF
fi
if [ -f tiltB_smooth.out ] ; then 
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltB_pol_smooth.png'
set xlabel 'Frame' 
set ylabel '<tiltB pol>' 
plot "tiltB_smooth.out" u 1:2 w l t "A pol" lc 3,"tiltB_smooth.out" u 1:4 w l t "B pol" lc 1, "tiltB_smooth.out" u 1:6 w l t "C pol" lc 7, "tiltB_smooth.out" u 1:8 w l t "D pol" lc 8, "tiltB_smooth.out" u 1:10 w l t "E pol" lc 6
EOF
fi

if [ -f tiltM2-full_smooth.out ] ; then
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_pol_smooth.png'
#set title 'tiltM2 Pol'
set xlabel 'Frame' 
set ylabel 'tiltM2 pol'
plot "tiltM2-full_smooth.out" u 1:2 w l t "A pol" lc 3,"tiltM2-full_smooth.out" u 1:4 w l t "B pol" lc 1, "tiltM2-full_smooth.out" u 1:6 w l t "C pol" lc 7, "tiltM2-full_smooth.out" u 1:8 w l t "D pol" lc 8, "tiltM2-full_smooth.out" u 1:10 w l t "E pol" lc 6
EOF
fi

if [ -f tiltM2-full_smooth.out ] ; then
  gnuplot << EOF
set terminal pngcairo size 1000,700 enhanced font 'Verdana,10'
set output 'tiltM2_az_smooth.png'
#set title 'tiltM2 Az'
set xlabel 'Frame' 
set ylabel 'tiltM2 az'
plot "tiltM2-full_smooth.out" u 1:3 w l t "A az" lc 3, "tiltM2-full_smooth.out" u 1:5 w l t "B az" lc 1 , "tiltM2-full_smooth.out" u 1:7 w l t "C az" lc 7,"tiltM2-full_smooth.out" u 1:9 w l t "D az" lc 8, "tiltM2-full_smooth.out" u 1:11 w l t "E az" lc 6
EOF
fi

if [ -f chi1-9.out ] ; then
  python obs-plgics/plot/plot-chi1.py
fi

