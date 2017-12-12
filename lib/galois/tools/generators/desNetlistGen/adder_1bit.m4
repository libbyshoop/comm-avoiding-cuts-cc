define(`adder_1bit',`
inv($3n,$3)#4
inv($4n,$4)#4
inv($5n,$5)#4

and2($3n$4n,$3n,$4n)#2
and2($3n$4,$3n,$4)#2
and2($3$4n,$3,$4n)#2
and2($3$4,$3,$4)#3

and2($3$4$5,$3$4,$5)#2
and2($3n$4n$5,$3n$4n,$5)#2
and2($3n$4$5n,$3n$4,$5n)#2
and2($3$4n$5n,$3$4n,$5n)#2

and2($4$5,$4,$5)#2
and2($3$5,$5,$3)#2

or2($1w42,$3$4n$5n,$3n$4$5n)#3
or2($1w71,$3$4$5, $3n$4n$5)#3
or2($1,$1w42,$1w71)#3

or2($1w35, $4$5, $3$5)#3
or2($2,$1w35,$3$4)#5
')
