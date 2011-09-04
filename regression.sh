#!/bin/bash
RM="rm -rf"
LOG="./log"
PINGUINO="./pinguinobeta*.py"
DONE="compilation done"

RED='\e[31;1m*'
GREEN='\e[32;1m*'
YELLOW='\e[33;1m***'
TERM='\e[m'

if [ -d $LOG ]; 
then
${RM} ${LOG}/*
else
exec mkdir ${LOG}
fi

TARGET="*/*/*.pde"

for PDE in $TARGET;
do
${RM} tmp/*
${RM} source/user.c
${RM} source/*.o
#echo "Compiling ${PDE} ..."
FILE=$(basename "${PDE}" .pde)
$(${PINGUINO} -nogui "${PDE}" > "${LOG}/${FILE}.log" 2>&- 2>/dev/null)


END=$(tail -n1 "${LOG}/${FILE}.log")
#FILE=$(basename "${PDE}")

if [ "$END" = "$DONE" ]; then
echo -e $GREEN ${PDE} COMPILED! $TERM
#remove good logs
$($RM "${LOG}/${FILE}.log")
else
echo -e $RED ${PDE} CANT COMPILE! $TERM
echo -e '\t' $YELLOW "See ${LOG}/${FILE}.log" $TERM
fi

done  
