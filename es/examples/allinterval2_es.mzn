include "alldifferent.mzn";

int: n;

% Posición de cada número.
array[1..n] of var 1..n: y;

% Posición de la diferencia i.
array[1..n-1] of var 1..n-1: v;

constraint alldifferent(y);

constraint alldifferent(v);

constraint forall(i,j in 1..n where i < j)(
	   	 (y[i] - y[j] = 1 -> v[j-i] = y[j]) /\
                 (y[j] - y[i] = 1 -> v[j-i] = y[i])
	   );

constraint abs(y[1] - y[n]) = 1 /\ v[n-1] = min(y[1], y[n]);

solve :: int_search(y, first_fail, indomain_min, complete)
      satisfy;

output [ "x = [",] ++
       [ show(i) ++ if j == n then "]\n;" else ", " endif
         | j in 1..n, i in 1..n where j == fix(y[i]) ];
