-module(euler_003).
-export([result/0]).
result() ->
    T1 = now(),
    Res = lists:nth(1, solve(600851475143)),
    T2 = now(),
    io:format("Result: ~w (time: ~w ms)~n", [Res, timer:now_diff(T2, T1)/1000]).

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
