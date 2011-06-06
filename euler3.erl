-module(euler3).
-export([result/0]).
result() ->
    io:format("Result: ~w~n", [lists:nth(1, solve(600851475143))]).

solve(N) ->
    factor(N, 2, []).

factor(N, D, Factors) ->
    if
	N < D*D ->
	    [N | Factors ];
	0 =:= N rem D ->
	    factor(N div D, D, [D | Factors]); 
	true ->
	    factor(N, D+1, Factors)
    end.
