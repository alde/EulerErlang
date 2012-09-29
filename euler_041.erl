-module(euler_041).
-export([solve/0]).
-import(primes).

%%
% Problem statement
%
% We shall say that an n-digit number is pandigital if it makes use of all
% the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
% and is also prime.
%
% What is the largest n-digit pandigital prime that exists?

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    Largest = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "The largest pandigital prime is ~p (~p ms) ~n",
        [Largest, Time]
    ).

%%
% Upper limit is not 987654321 as one would imagine, but 7654321.
% This is because the digit sum of all 8 and 9 pandigital numbers are always
% divisible by 3, and as such all 8 and 9 pandigital numbers are divisible by 3.
%
% return integer
start() ->
    recurse(7654321).

%%
% Simple recurive function that starts at the upper limit, checks for both
% pandigitalism and prime-ness and returns the first value it encounters.
%
% [integer] N : Value to assess.
%
% return integer
recurse(N) ->
    case is_pandigital(N) and primes:is_prime(N) of
        true -> N;
        _ -> recurse(N-1)
    end.

%%
% A pandigital checker.
%
% [integer] Num : Number value to check.
%
% return boolean
is_pandigital(Num) ->
    NumList = integer_to_list(Num),
    Sorted = lists:foldr(
        fun(X, Acc) ->
            integer_to_list(X) ++ Acc
        end,
        [],
        lists:flatten(lists:seq(1, length(NumList)))),
    B = lists:sort(NumList),
    B == Sorted.