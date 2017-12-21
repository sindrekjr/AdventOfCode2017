IFS=, read -a inp < input

x=0,y=0,steps=0
for d in ${inp[@]}
do
  if [ $d == "ne" ];
    then ((x++, y++))
  elif [ $d == "se" ];
    then ((x++))
  elif [ $d == "s" ];
    then ((y--))
  elif [ $d == "sw" ];
    then ((x--, y--))
  elif [ $d == "nw" ];
    then ((x--))
  elif [ $d == "n" ];
    then ((y++))
  fi
done
((xz = (x >= 0) ? x : -x))
((yz = (y >= 0) ? y : -y))
((steps = ((x * y) > 0) ? ((xz > yz) ? xz : yz) : (xz + yz)))

echo $steps > result
