#!/bin/bash
#.. November 6th 2014
#.. Nicolas Martin
#.. Updated the May 19th 2016 by Adrien Cerdan

# All analyses are done with wordom

# /!\ Most of the observable require that you specifiy a list of 
# /!\ trajectory files to analyse name dcd.txt

# specifiy the path (if not in $PATH) and name of the executable
wordom="wordom"
# Specify the size of the bins for the running average
avg=500

# HELP

if [ "$1" == "--help" ] || [ "$1" == "" ] ; then

  echo " " 
  echo "Info: Argument missing : You may use this script with analyse.sh arg1 -misc arg2"
  echo "Info: Possible observables to analyze are :"
  echo "Info: tiltM2, tiltB, twist, DVP, PPS, GLU, hole, all"
  echo "Info: Check the code for further informations."
  echo "Info: Use the option -smooth to compute running averages of your data"
  # add end  and skip
  echo "Info: To obtains statistics on your data use: all -stat beg (starting frame to analyze)"
  echo "Info: type analyse.sh --help to read this again." 
  echo " "

fi

if [ "$1" == "all" ] && [ "$2" == "-stat" ] ; then
  if [ $# -lt 3 ]
  then
    echo "You must specify the starting frame"
    echo "expl: ./analyses all -stat 1500"
    exit 1
  fi
  echo "==============================="
  echo "Tilt M2 pol:"
  ./avg_analyses.py tiltM2_avg.out 0 $3
  echo "==============================="
  echo "Tilt M2 az:"
  ./avg_analyses.py tiltM2_avg.out 1 $3
  echo "==============================="
  echo "Tilt B pol:"
  ./avg_analyses.py tiltB_avg.out 0 $3
  echo "==============================="
  echo "Tilt B az:"
  ./avg_analyses.py tiltB_avg.out 1 $3
  echo "==============================="
   echo "Twist:"
  ./avg_analyses.py twist_avg.out 0 $3
  echo "==============================="
  echo "PPS 9':"
  ./avg_analyses.py PPS-surf-9prime.out 0 $3
  echo "==============================="
  echo "PPS -2':"
  ./avg_analyses.py PPS-surf-2prime.out 0 $3
  echo "==============================="
  exit 0
fi

##################
## TILTM2 UPPER ##
##################

if [ "$1" == "tiltM2upper" ] || [ "$1" == "all" ] ; then
  echo "## Computing TILTM2 upper##"
 # clean previous run
  if [ -f tiltM2upper.out ] ; then
  rm tiltM2upper.out
  fi

  ${wordom} -iA tiltM2upper.wdm -imol all.pdb -itrj dcd.txt >> tiltM2upper.out

  # compute average over the 5 subunits
  rm tiltM2upper_avg.out
  grep -v "#" tiltM2upper.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltM2upper_avg.out

  # compute the Smoothen curve 
  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2upper_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltM2upper_avg_smooth.out
  fi
fi


##################
## TILTM2 DOWMER ##
##################

if [ "$1" == "tiltM2lower" ] || [ "$1" == "all" ] ; then
  echo "## Computing TILTM2 lower##"
 # clean previous run
  if [ -f tiltM2lowner.out ] ; then
  rm tiltM2lower.out
  fi

  ${wordom} -iA tiltM2lower.wdm -imol all.pdb -itrj dcd.txt >> tiltM2lownr.out

  # compute average over the 5 subunits
  rm tiltM2lower_avg.out
  grep -v "#" tiltM2lower.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltM2lower_avg.out

  # compute the Smoothen curve 
  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2lower_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltM2lower_avg_smooth.out
  fi
fi

############
## TILTM2 ##
############

if [ "$1" == "tiltM2" ] || [ "$1" == "all" ] ; then
  echo "## Computing TILTM2 ##"
 # clean previous run
  if [ -f tiltM2.out ] ; then
  rm tiltM2.out
  fi

  ${wordom} -iA tiltM2.wdm -imol all.pdb -itrj dcd.txt >> tiltM2.out


   if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","AT","AP","BT","BP","CT", "CP", "DT", "DP", "ET", "ED"}{sum1+=$2;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6;sum6+=$7;sum7+=$8;sum8+=$9;sum9+=$10; sum10+=$11} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg, sum6/avg, sum7/avg, sum8/avg, sum9/avg, sum10/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; sum6=0 ;  sum7=0; sum8=0; sum9=0; sum10=0; line=line+avg;}' > tiltM2_smooth.out
  fi


  # compute average over the 5 subunits
  rm tiltM2_avg.out
  grep -v "#" tiltM2.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltM2_avg.out
  # compute the Smoothen curve for AVG
  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltM2_avg_smooth.out
  fi
fi




####################
## TILT BSANDWICH ##
####################

if [ "$1" == "tiltB" ] || [ "$1" == "all" ] ; then
  echo "## Computing TILTB ##"

# clean previous run
  if [ -f tiltB.out ] ; then
  rm tiltB.out
  fi

  ${wordom} -iA tiltB.wdm -itrj dcd.txt -imol all.pdb >> tiltB.out

  # compute average over the 5 subunits
  rm tiltB_avg.out
  grep -v "#" tiltB.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltB_avg.out

  # compute the Smoothen curve 
  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltB_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltB_avg_smooth.out
  fi
fi

###########
## TWIST ##
###########

if  [ "$1" == "twist" ] || [ "$1" == "all" ] ; then
  echo "## Computing TWIST ##"
    # clean previous run
    if [ -f twist.out ] ; then 
    rm twist.out 
    fi

    ${wordom} -iA twist.wdm -itrj dcd.txt -imol all.pdb >> twist.out

  # compute average over the 5 subunits
  rm twist_avg.out
  grep -v "#" twist.out  | awk '{sum=0 ; sum += $2+$3+$4+$5+$6; print sum/5}' > twist_avg.out

  if [ $2 == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" twist_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","Twist"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > twist_avg_smooth.out
  fi
fi

#######################
## DISTANCE V45-P268 ##
#######################

if  [ "$1" == "DVP" ] || [ "$1" == "all" ] ; then
  echo "## Computing DVP  ##"
  # clean previous run
  if [ -f DVP.out ] ; then
  rm DVP.out
  fi

  ${wordom} -iA dist-V45-P268.wdm -imol all.pdb -itrj dcd.txt >> DVP.out

  # compute average over the 5 subunits
  rm DVP_avg.out
  grep -v "#" DVP.out | awk '{sum=0 ; sum += $2+$3+$4+$5+$6; print sum/5}' > DVP_avg.out

  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" DVP.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg , sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > DVP_smooth.out
  fi
fi

if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" DVP_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","DVP"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > DVP_avg_smooth.out
  fi

##############
## Glu RMSD ##
##############

if  [ "$1" == "GLU" ] || [ "$1" == "all" ] ; then
  echo "## Computing GLU RMDS  ##"
  # clean previous run
  if [ -f GLU.out ] ; then
  rm GLU.out
  fi

  ${wordom} -iA glu-RMSD.wdm -imol all.pdb -itrj dcd.txt >> GLU.out

  if [ $2 == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" GLU.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > GLU_smooth.out
  fi
fi

##############
## IVM RMSD ##
##############

if  [ "$1" == "IVM" ] || [ "$1" == "all" ] ; then
  echo "## Computing IVM RMDS  ##"
  # clean previous run
  if [ -f IVM.out ] ; then
  rm IVM.out
  fi

  ${wordom} -iA IVM-RMSD.wdm -imol all.pdb -itrj dcd.txt >> IVM.out

  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" IVM.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > IVM_smooth.out
  fi
fi

###########################
## DISTANCE IVM - Arg287 ##
###########################

if  [ "$1" == "IVMHB" ] || [ "$1" == "all" ] ; then
  echo "## Computing distance IVMD and Arg 287 (HBOND)  ##"
  # clean previous run
  if [ -f dist-IVM-R287.out ] ; then
  rm dist-IVM-R287.out
  fi

  ${wordom} -iA dist-IVM-R287.wdm -imol all.pdb -itrj dcd.txt >> dist-IVM-R287.out

  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" dist-IVM-R287.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg , sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > dist-IVM-R287_smooth.out
  fi
fi


############################
## Pentagone pore surface ##
############################
if  [ "$1" == "PPS13" ] || [ "$1" == "all" ] ; then
  echo "## Computing PPS  ##"
  # clean previous run
  if [ -f PPS-dist-13prime.out ] ; then
  rm PPS-dist-13prime.out
  fi

  ${wordom} -iA PPS-13prime.wdm -imol all.pdb -itrj dcd.txt >> PPS-dist-13prime.out
  # calculation of the pentagone area
  echo "Computing Pentagone Pore area ..." 
  grep -v "#" PPS-dist-13prime.out | awk '{side=($6+$2+$3+$4+$5)/5; print side*side*1.7204}' > PPS-surf-13prime.out

  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" PPS-surf-13prime.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","PPS"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > PPS-surf_smooth-13prime.out
  fi
fi



if  [ "$1" == "PPS9" ] || [ "$1" == "all" ] ; then
  echo "## Computing PPS  ##"
  # clean previous run
  if [ -f PPS-dist-9prime.out ] ; then
  rm PPS-dist-9prime.out
  fi

  ${wordom} -iA PPS-9prime.wdm -imol all.pdb -itrj dcd.txt >> PPS-dist-9prime.out
  # calculation of the pentagone area
  echo "Computing Pentagone Pore area ..." 
  grep -v "#" PPS-dist-9prime.out | awk '{side=($6+$2+$3+$4+$5)/5; print side*side*1.7204}' > PPS-surf-9prime.out


  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" PPS-surf-9prime.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","PPS"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > PPS-surf_smooth-9prime.out
  fi
fi


if  [ "$1" == "PPS2" ] || [ "$1" == "all" ] ; then

  echo "## Computing PPS  ##"
  # clean previous run
  if [ -f PPS-dist-2prime.out ] ; then
  rm PPS-dist-2prime.out
  fi

  ${wordom} -iA PPS-2prime.wdm -imol all.pdb -itrj dcd.txt >> PPS-dist-2prime.out
  # calculation of the pentagone area
  echo "Computing Pentagone Pore area ..." 
  grep -v "#" PPS-dist-2prime.out | awk '{side=($6+$2+$3+$4+$5)/5; print side*side*1.7204}' > PPS-surf-2prime.out


  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" PPS-surf-2prime.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","PPS"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > PPS-surf_smooth-2prime.out
  fi
fi

############
## CHI1 13` ##
############

if [ "$1" == "chi1" ] || [ "$1" == "all" ] ; then
  echo "## Computing CHI1-13' ##"
 # clean previous run
  if [ -f chi1-13.out ] ; then
  rm chi1-13.out
  fi

  ${wordom} -iA chi1-13.wdm -imol all.pdb -itrj dcd.txt >> chi1-13.out


   if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" chi1-13.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > chi1-13_smooth.out
  fi


  # compute average over the 5 subunits
  rm chi1-13_avg.out
  grep -v "#" chi1-13.out | awk '{sum=0; sum += $2+$3+$4+$5+$6 ; print sum/5}' > chi1-13_avg.out

  # compute the Smoothen curve for AVG
  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" chi1-13_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","chi1"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\n", line, sum/avg ; sum=0 ; line=line+avg;}' > chi1-13_avg_smooth.out
  fi
fi




############
## CHI1 9` ##
############

if [ "$1" == "chi1" ] || [ "$1" == "all" ] ; then
  echo "## Computing CHI1-9' ##"
 # clean previous run
  if [ -f chi1-9.out ] ; then
  rm chi1-9.out
  fi

  ${wordom} -iA chi1-9.wdm -imol all.pdb -itrj dcd.txt >> chi1-9.out


   if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" chi1-9.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > chi1-9_smooth.out
  fi


  # compute average over the 5 subunits
  rm chi1-9_avg.out
  grep -v "#" chi1-9.out | awk '{sum=0; sum += $2+$3+$4+$5+$6 ; print sum/5}' > chi1-9_avg.out

  # compute the Smoothen curve for AVG
  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" chi1-9_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","chi1"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\n", line, sum/avg ; sum=0 ; line=line+avg;}' > chi1-9_avg_smooth.out
  fi
fi



#######################
## HOLE ##
#######################

if  [ "$1" == "hole" ] ; then
  echo "## Computing hole  ##"

  ${wordom} -iA hole.wdm -imol all.pdb -itrj dcd_aligned.txt

fi

#####################
## PLOT            ##
#####################
if  [ "$1" == "all" ] && [ "$2" == "-smooth" ] ; then
gnuplot plotAll_smooth.plt
fi

if [ "$1" == "all" ] && [ $# == 1 ] ; then
gnuplot plotAll.plt
fi





