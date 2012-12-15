-module(euler_048).
-export([solve/0]).
-import(primes).
-define (MODULO, 10000000000).

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    Result = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "Result: ~p. (~p ms) ~n",
        [Result, Time]
    ).

start() ->
	last_10(pow_sum(1000)).

%%
% Get the sum of the powers.
pow_sum(Limit) ->
	lists:sum([ pow(N) ||
		N <- lists:seq(1, Limit)
	]).

%%
% Get the last 10 digits.
last_10(N) -> N rem ?MODULO.

%%
% 
pow(N) -> pow(N, N).
pow(N, 1) -> N;
pow(N, Rem) -> N * pow(N, Rem-1).