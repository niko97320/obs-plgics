#!/bin/bash
#.. November 6th 2014
#.. Nicolas Martin
#.. Updated the May 19th 2016 by Adrien Cerdan

# All analyses are done with wordom

# /!\ Most of the observable require that you specifiy a list of 
# /!\ trajectory files to analyse name dcd.txt

# specifiy the path (if not in $PATH) and name of the executable
wordom="wordom"
# specifiy path for wdm analysis files
#wdmPath="obs-plgics/wdm-glucl"
# Specify the size of the bins for the running average
inp="inp-analyse.txt" 

# HELP

#if [ "$1" == "--help" ] || [ "$1" == "" ] ; then
#
#  echo " " 
#  echo "Info: Argument missing : You may use this script with analyse.sh arg1 -misc arg2"
#  echo "Info: Possible observables to analyze are :"
#  echo "Info: tiltM2, tiltB, twist, DVP, PPS, GLU, hole, all"
#  echo "Info: Check the code for further informations."
#  echo "Info: Use the option -smooth to compute running averages of your data"
#  # add end  and skip
#  echo "Info: To obtains statistics on your data use: -stat beg (starting frame to analyze) end (last frame to analyze)"
#  echo "Info: type analyse.sh --help to read this again." 
#  echo " "
#
#fi

##############################################
## Parse list of anaylsis requiered by user ##
##############################################

IVM=0
im2m3=0
flux=0
tiltM2upper=0
tiltM2lower=0
tiltM2full=0
tiltB=0
twist=0
DVP=0
GLU=0
IVMHB=0
PPS13=0
PPS9=0
PPS2=0
chi1=0
hole=0
propos=0
smooth=0
avg=500

while read -r line
do
  #echo $line
  #echo $line | awk '{print $1}'
  if [[ $(echo $line | awk '{print $1}') == "#"* ]] || [[ $(echo $line | awk '{print $1}') == " #"* ]]  || [[ $line == "" ]]; then
    #echo "#### COMMENT" 
    continue
  else 
    if [[ $(echo $line | awk '{print $1}') == "SYS" ]] ; then
      system=$(echo $line | awk '{print $2}')
      if [ $system == "glucl" ] ; then 
        wdmPath="obs-plgics/wdm-glucl"
      elif [ $sytem == "glyR" ] ; then
        wdmPath="obs-plgics/wdm-glyR"
      elif [ $sytem == "nach" ] ; then
        wdmPath="obs-plgics/wdm-nach"
      fi
    elif [[ $(echo $line | awk '{print $1}') == "FREQ" ]] ; then
     avg=$(echo $line | awk '{print $2}')
     echo "average is :"$avg
    elif [[ $(echo $line | awk '{print $1}') == "SMOOTH" ]] ; then
      if [ $(echo $line | awk '{print $2}') == "ON" ] ; then 
        smooth=1
        echo "SMOOTH is :" $smooth
      fi 
    elif [[ $(echo $line | awk '{print $1}') == "tiltM2full" ]] ; then
      tiltM2full=1
    elif [[ $(echo $line | awk '{print $1}') == "IVM" ]] ; then
      IVM=1
    elif [[ $(echo $line | awk '{print $1}') == "propos" ]] ; then
      propos=1
    elif [[ $(echo $line | awk '{print $1}') == "m2m3" ]] ; then
      im2m3=1
    elif [[ $(echo $line | awk '{print $1}') == "flux" ]] ; then
      flux=1
    elif [[ $(echo $line | awk '{print $1}') == "tiltM2upper" ]] ; then
      tiltM2upper=1
    elif [[ $(echo $line | awk '{print $1}') == "tiltM2lower" ]] ; then
      tiltM2lower=1
    elif [[ $(echo $line | awk '{print $1}') == "tiltB" ]] ; then
      tiltB=1
    elif [[ $(echo $line | awk '{print $1}') == "twist" ]] ; then
      twist=1
      echo "Twist" 
    elif [[ $(echo $line | awk '{print $1}') == "DVP" ]] ; then
      DVP=1
      echo "DVP" 
    elif [[ $(echo $line | awk '{print $1}') == "GLU" ]] ; then
      GLU=1
    elif [[ $(echo $line | awk '{print $1}') == "IVMHB" ]] ; then
      IVMHB=1
    elif [[ $(echo $line | awk '{print $1}') == "PPS13" ]] ; then
      PPS13=1
    elif [[ $(echo $line | awk '{print $1}') == "PPS9" ]] ; then
      PPS9=1
    elif [[ $(echo $line | awk '{print $1}') == "PPS2" ]] ; then
      PPS2=1
    elif [[ $(echo $line | awk '{print $1}') == "chi1" ]] ; then
      chi1=1
    elif [[ $(echo $line | awk '{print $1}') == "hole" ]] ; then
      hole=1
    else 
      echo "$line: not understood!"
      #exit 1
    fi
  fi
done < "$inp"

########################
## TESTS ON DCD files ##
########################

dcd_prot="dcd_all.txt"
dcd="dcd.txt"

pdb="all.pdb"

if [ -f dcd_prot.txt ] && [ -f protein.pdb ] ; then
  dcd_prot="dcd_prot.txt"
  pdb="protein.pdb"
  echo "Info: $pdb found"
  echo "Info: List of trajectories for the PROTEIN ONLY, aligned and wrapped found"
  echo "Info: Will be used for the following analysis :"
  echo "Info: Twist, tiltM2, Proline position, tiltB, HOLE, DVP, PPS,Chi ..."
else 
  echo "Warning: List of trajectories for the protein only, aligned or protein.pdb NOT found"
  echo "Warning: Make sure your analysis is alright"
fi
  
if [ -f dcd.txt ] ; then
  echo "Info: List of trajectories for the FULL SYSTEM wrapped and aligned found"
  echo "Info: Will be used for the following analysis :"
  echo "Info: Flux"
else 
  echo "Warning: List of trajectories for the protein only, aligned NOT found"
  echo "Warning: Make sure your analysis is alright"
fi

  
###########
## STATS ##
###########

if [ "$1" == "-stat" ] ; then
  if [ $# -lt 2 ]
  then
    echo "You must specify the starting frame"
    echo "expl: ./analyses-obs -stat 1500"
    exit 1
  fi
  if [ $# -gt 3 ]
  then
    echo "You must specify the starting frame and possibly the last frame"
    echo "expl: ./analyses-obs -stat 1500 2500"
    exit 1
  fi
  if [ $# == 2 ]
  then
    echo "Analysis will be done from the frame $2 to the end."
  else
    echo "Analysis will be done from the frame $2 to the frame $3."
  fi

  echo "==============================="
  echo "Tilt M2 pol:"
  ./avg_analyses.py tiltM2_avg.out 0 $2 $3
  echo "==============================="
  echo "Tilt M2 az:"
  ./avg_analyses.py tiltM2_avg.out 1 $2 $3
  echo "==============================="
  echo "Tilt B pol:"
  ./avg_analyses.py tiltB_avg.out 0 $2 $3
  echo "==============================="
  echo "Tilt B az:"
  ./avg_analyses.py tiltB_avg.out 1 $2 $3
  echo "==============================="
   echo "Twist:"
  ./avg_analyses.py twist_avg.out 0 $2 $3
  echo "==============================="
  echo "PPS 9':"
  ./avg_analyses.py PPS-surf-9prime.out 0 $2 $3
  echo "==============================="
  echo "PPS -2':"
  ./avg_analyses.py PPS-surf-2prime.out 0 $2 $3
  echo "==============================="
  exit 0
fi



######################
## Proline position ##
######################

if [ $propos == 1 ] ; then
  echo "## Computing P268's COM position ##"
  echo "## WARNING: you should use an aligned trajectory for this analysis"
 # clean previous run
  if [[ -f proxy*.out ]] ; then
    rm proxy*.out
  fi
  for i in A B C D E ; do
    ${wordom} -iA ${wdmPath}/proline-coord${i}.wdm -imol $pdb -itrj $dcd_prot -otxt proxy${i}.out
  done
fi


################
## M2-M3 dist ##
################
if [[ $m2m3 == 1 ]] ; then
  echo "## Computing M2-M3 distance##"
 # clean previous run
  if [ -f m2m3_dist.out ] ; then
  rm m2m3_dist.out
  fi
  ${wordom} -iA ${wdmPath}/m2m3_dist.wdm -imol $pdb -itrj $dcd_prot -otxt m2m3_dist.out

  # compute average over the 5 subunits
  rm -f m2m3_dist_avg.out 
  grep -v "#" m2m3_dist.out | awk '{sum=0; sum += $2+$3+$4+$5+$6 ; print $1"\t"sum/5}' > m2m3_dist_avg.out

fi
##########
## FLUX ##
##########

if [ $flux == 1 ] ; then
  echo "## Computing Water and Ions flux##"
  echo "## WARNING: you should use an aligned trajectory for this analysis"
 # clean previous run
  if [ -f transition-waters.out ] ; then
  rm -f transition-waters.out
  fi
 # clean previous run
  if [ -f transition-ions.out ] ; then
    rm -f transition-ions.out
  fi
 # clean previous run
  if [ -f err-waters.out ] ; then
    rm -f err-waters.out
  fi
 # clean previous run
  if [ -f err-ions.out ] ; then
    rm -f err-ions.out
  fi

# waters
${wordom} -iA ${wdmPath}/water_flux.wdm -imol all.pdb -itrj $dcd -otxt transition-waters.out 2> err-waters.out

# ions
${wordom} -iA ${wdmPath}/ions_flux.wdm -imol all.pdb -itrj $dcd -otxt transition-ions.out 2> err-ions.out
fi

##################
## TILTM2 UPPER ##
##################

if [ $tiltM2upper == 1 ] ; then
  echo "## Computing TILTM2 upper##"
 # clean previous run
  if [ -f tiltM2-upper.out ] ; then
    rm -f tiltM2-upper.out
  fi

  ${wordom} -iA ${wdmPath}/tiltM2-upper.wdm -imol $pdb -itrj $dcd_prot >> tiltM2-upper.out

  # compute average over the 5 subunits
  rm -f tiltM2-upper_avg.out
  grep -v "#" tiltM2-upper.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltM2-upper_avg.out

  # compute the Smoothen curve 
  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2-upper_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltM2-upper_avg_smooth.out
  fi
fi


##################
## TILTM2 LOWER ##
##################

if [ $tiltM2lower == 1 ] ; then
  echo "## Computing TILTM2 lower ##"
 # clean previous run
  if [ -f tiltM2-lower.out ] ; then
    rm -f tiltM2-lower.out
  fi

  ${wordom} -iA ${wdmPath}/tiltM2-lower.wdm -imol $pdb -itrj $dcd_prot >> tiltM2-lower.out

  # compute average over the 5 subunits
  rm -f tiltM2-lower_avg.out
  grep -v "#" tiltM2-lower.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltM2-lower_avg.out

  # compute the Smoothen curve 
  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2-lower_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltM2-lower_avg_smooth.out
  fi
fi

#################
## TILTM2 FULL ##
#################

if [ $tiltM2full == 1 ] ; then
  echo "## Computing TILTM2 full helix ##"
 # clean previous run
  if [ -f tiltM2-full.out ] ; then
    rm -f tiltM2-full.out
  fi

  ${wordom} -iA ${wdmPath}/tiltM2-full.wdm -imol $pdb -itrj $dcd_prot >> tiltM2-full.out


   if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2-full.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","AT","AP","BT","BP","CT", "CP", "DT", "DP", "ET", "ED"}{sum1+=$2;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6;sum6+=$7;sum7+=$8;sum8+=$9;sum9+=$10; sum10+=$11} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg, sum6/avg, sum7/avg, sum8/avg, sum9/avg, sum10/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; sum6=0 ;  sum7=0; sum8=0; sum9=0; sum10=0; line=line+avg;}' > tiltM2-full_smooth.out
  fi


  # compute average over the 5 subunits
  rm -f tiltM2-full_avg.out
  grep -v "#" tiltM2-full.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltM2-full_avg.out
  # compute the Smoothen curve for AVG
  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltM2-full_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltM2-full_avg_smooth.out
  fi
fi




####################
## TILT BSANDWICH ##
####################

if [ $tiltB == 1 ] ; then
  echo "## Computing TILTB ##"

# clean previous run
  if [ -f tiltB.out ] ; then
    rm -f tiltB.out
  fi

  ${wordom} -iA ${wdmPath}/tiltB.wdm -itrj $dcd_prot -imol $pdb >> tiltB.out

  # compute average over the 5 subunits
  rm -f tiltB_avg.out
  grep -v "#" tiltB.out | awk '{sumt=0;sump=0 ; sumt += $2+$4+$6+$8+$10 ; sump += $3+$5+$7+$9+$11; print sumt/5"\t"sump/5}' > tiltB_avg.out

  # compute the Smoothen curve 
  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" tiltB_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t%s\n", "#nFr","Theta","Phi"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\t%s\n", line, sum1/avg, sum2/avg ; sum1=0 ; sum2=0; line=line+avg;}' > tiltB_avg_smooth.out
  fi
fi

###########
## TWIST ##
###########

if  [ $twist == 1 ] ; then
  echo "## Computing TWIST ##"
    # clean previous run
    if [ -f twist.out ] ; then 
      rm -f twist.out 
    fi

    ${wordom} -iA ${wdmPath}/twist.wdm -itrj $dcd_prot -imol $pdb >> twist.out

  # compute average over the 5 subunits
  rm twist_avg.out
  grep -v "#" twist.out  | awk '{sum=0 ; sum += $2+$3+$4+$5+$6; print sum/5}' > twist_avg.out

  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" twist_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","Twist"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > twist_avg_smooth.out
  fi
fi

#######################
## DISTANCE V45-P268 ##
#######################

if  [ $DVP == 1 ] ; then
  echo "## Computing DVP  ##"
  # clean previous run
  if [ -f DVP.out ] ; then
    rm -f DVP.out
  fi

  ${wordom} -iA ${wdmPath}/dist-V45-P268.wdm -imol $pdb -itrj $dcd_prot >> DVP.out

  # compute average over the 5 subunits
  rm -f DVP_avg.out
  grep -v "#" DVP.out | awk '{sum=0 ; sum += $2+$3+$4+$5+$6; print sum/5}' > DVP_avg.out

  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" DVP.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg , sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > DVP_smooth.out
  fi

if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" DVP_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","DVP"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > DVP_avg_smooth.out
fi
fi

##############
## Glu RMSD ##
##############

if  [ $GLU == 1 ] ; then
  echo "## Computing GLU RMDS  ##"
  # clean previous run
  if [ -f GLU.out ] ; then
    rm -f GLU.out
  fi

  ${wordom} -iA ${wdmPath}/glu-RMSD.wdm -imol $pdb -itrj $dcd_prot >> GLU.out

  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" GLU.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > GLU_smooth.out
  fi
fi

##############
## IVM RMSD ##
##############

if  [ $IVM == 1 ] ; then
  echo "## Computing IVM RMDS  ##"
  # clean previous run
  if [ -f IVM.out ] ; then
  rm IVM.out
  fi

  ${wordom} -iA ${wdmPath}/IVM-RMSD.wdm -imol $pdb -itrj $dcd_prot >> IVM.out

  if [ "$2" == "-smooth" ] ; then
  echo "Computing average of the TS..."
  grep -v "#" IVM.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > IVM_smooth.out
  fi
fi

###########################
## DISTANCE IVM - Arg287 ##
###########################

if  [ $IVMHB == 1 ] ; then
  echo "## Computing distance IVMD and Arg 287 (HBOND)  ##"
  # clean previous run
  if [ -f dist-IVM-R287.out ] ; then
  rm dist-IVM-R287.out
  fi

  ${wordom} -iA ${wdmPath}/dist-IVM-R287.wdm -imol $pdb -itrj $dcd_prot >> dist-IVM-R287.out

  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" dist-IVM-R287.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg , sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > dist-IVM-R287_smooth.out
  fi
fi


############################
## Pentagone pore surface ##
############################
if  [ $PPS13 == 1 ] ; then
  echo "## Computing PPS  ##"
  # clean previous run
  if [ -f PPS-dist-13prime.out ] ; then
  rm PPS-dist-13prime.out
  fi

  ${wordom} -iA ${wdmPath}/PPS-13prime.wdm -imol $pdb -itrj $dcd_prot >> PPS-dist-13prime.out
  # calculation of the pentagone area
  echo "Computing Pentagone Pore area ..." 
  grep -v "#" PPS-dist-13prime.out | awk '{side=($6+$2+$3+$4+$5)/5; print side*side*1.7204}' > PPS-surf-13prime.out

  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" PPS-surf-13prime.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","PPS"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > PPS-surf-13prime_smooth.out
  fi
fi



if  [ $PPS9 == 1 ] ; then
  echo "## Computing PPS  ##"
  # clean previous run
  if [ -f PPS-dist-9prime.out ] ; then
  rm PPS-dist-9prime.out
  fi

  ${wordom} -iA ${wdmPath}/PPS-9prime.wdm -imol $pdb -itrj $dcd_prot >> PPS-dist-9prime.out
  # calculation of the pentagone area
  echo "Computing Pentagone Pore area ..." 
  grep -v "#" PPS-dist-9prime.out | awk '{side=($6+$2+$3+$4+$5)/5; print side*side*1.7204}' > PPS-surf-9prime.out


  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" PPS-surf-9prime.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","PPS"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > PPS-surf-9prime_smooth.out 
  fi
fi


if  [ $PPS2 == 1 ] ; then

  echo "## Computing PPS  ##"
  # clean previous run
  if [ -f PPS-dist-2prime.out ] ; then
  rm PPS-dist-2prime.out
  fi

  ${wordom} -iA ${wdmPath}/PPS-2prime.wdm -imol $pdb -itrj $dcd_prot >> PPS-dist-2prime.out
  # calculation of the pentagone area
  echo "Computing Pentagone Pore area ..." 
  grep -v "#" PPS-dist-2prime.out | awk '{side=($6+$2+$3+$4+$5)/5; print side*side*1.7204}' > PPS-surf-2prime.out


  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" PPS-surf-2prime.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","PPS"}{sum+=$1} (NR%avg)==0{printf " %i\t%f\t\n", line, sum/avg ; sum=0 ; line=line+avg;}' > PPS-surf-2prime_smooth.out 
  fi
fi

##############
## CHI1 13` ##
##############

if [ $chi1 == 1 ] ; then
  echo "## Computing CHI1-13' ##"
 # clean previous run
  if [ -f chi1-13.out ] ; then
  rm chi1-13.out
  fi

  ${wordom} -iA ${wdmPath}/chi1-13.wdm -imol $pdb -itrj $dcd_prot >> chi1-13.out


   if [ $smooth == 1 ] ; then
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

if [ $chi1 == 1 ] ; then
  echo "## Computing CHI1-9' ##"
 # clean previous run
  if [ -f chi1-9.out ] ; then
  rm chi1-9.out
  fi

  ${wordom} -iA ${wdmPath}/chi1-9.wdm -imol $pdb -itrj $dcd_prot >> chi1-9.out


   if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" chi1-9.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\t\t%s\t\t%s\t\t%s\t\t%s\n", "#nFr","A","B","C","D","E"}{sum1+=$2;;sum2+=$3;sum3+=$4;sum4+=$5;sum5+=$6} (NR%avg)==0{printf " %i\t%f\t%f\t%f\t%f\t%f\n", line, sum1/avg, sum2/avg, sum3/avg, sum4/avg, sum5/avg ; sum1=0 ;  sum2=0; sum3=0; sum4=0; sum5=0; line=line+avg;}' > chi1-9_smooth.out
  fi


  # compute average over the 5 subunits
  rm chi1-9_avg.out
  grep -v "#" chi1-9.out | awk '{sum=0; sum += $2+$3+$4+$5+$6 ; print sum/5}' > chi1-9_avg.out

  # compute the Smoothen curve for AVG
  if [ $smooth == 1 ] ; then
  echo "Computing average of the TS..."
  grep -v "#" chi1-9_avg.out | awk -v avg=$avg 'BEGIN{line=0 ; printf "%s\t%s\n", "#nFr","chi1"}{sum1+=$1;sum2+=$2} (NR%avg)==0{printf " %s\t%s\n", line, sum/avg ; sum=0 ; line=line+avg;}' > chi1-9_avg_smooth.out
  fi
fi



##########
## HOLE ##
##########

if  [ $hole == 1 ] ; then
  echo "## Computing hole  ##"
  echo "## WARNING: you should use an aligned trajectory for this analysis"

  ${wordom} -iA ${wdmPath}/hole.wdm -imol $pdb -itrj $dcd_prot

fi


#####################
## PLOT            ##
#####################
if  [ $smooth == 1 ] ; then
   bash plotAll_smooth.sh 
else
  bash plotAll.sh
fi

