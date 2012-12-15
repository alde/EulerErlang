-module(euler_047).
-export([solve/0]).
-import(primes).

% The first two consecutive numbers to have two distinct prime factors are:

% 14 = 2 x 7
% 15 = 3 x 5

% The first three consecutive numbers to have three distinct prime factors are:

% 644 = 2² x 7 x 23
% 645 = 3 x 5 x 43
% 646 = 2 x 17 x 19.

% Find the first four consecutive integers to have four distinct primes 
% factors. What is the first of these numbers?

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
	check(2*3*5*7, []).

%%
% Main iteration
check(_Num, Count) when length(Count) == 4 -> 
	[H|_] = lists:reverse(Count),
	H;
check(Num, Count) ->
	N = factor(Num),
	case length(N) == 4 of
		true -> check(Num+1, [Num|Count]);
		_ -> check(Num+1, [])
	end.

%%
% Dirty factoring to get prime factors.
factor(N) when is_integer(N), 1 < N ->
	factor(N, 2, []).
factor(N, D, Factors) when N < D * D -> 
	[N | Factors];
factor(N, D, Factors) when (N rem D =:= 0) ->
	case primes:is_prime(D) of
		true -> factor(N div D, D + 1, [D | Factors]);
		_ -> factor(N, D + 1, Factors)
	end;
factor(N, D, Factors) ->
	factor(N, D + 1, Factors).
