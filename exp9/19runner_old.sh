a=1
start=0 
call=1
while IFS='' read -r line || [[ -n "$line" ]]; do
	if [[ ($a -gt $2) && ($a -lt $3) ]] 
	then
          if [[ -f states/formula1 ]]
            then
              rm states/formula1
            fi
            if [[ -f states/internal_state1 ]]
            then
              rm states/internal_state1
            fi
        ((call=1))
        echo -n 0 > states/call_count1
        while [ $call -lt 3 ] 
        do
            echo $line-c$call
            if (( $call == 1 ));
            then
     	        ./cadical -script 1 -t 300 -q -n '../../benches/sr19/old/'$line >> '19_formula/'c1_1_cadical21_lambda_formula.txt
		echo $line $(stat --printf="%s" states/internal_state1) $(stat --printf="%s" states/formula1)>> states/sizes/1_db_size
            fi
            if  (( $call == 2 ));
            then
     	        ./cadical -script 1 -t 2000 -q -n '../../benches/sr19/old/'$line >> '19_formula/'c2_1_cadical21_lambda_formula.txt
	        fi
            ((call+=1))
        done
        rm states/formula1
        rm states/internal_state1
        echo -n 0 > states/call_count1
    fi
    ((a+=1))
    ((call=1))
    echo 0 > states/call_count1
done < $1
