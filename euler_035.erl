-module(euler_035).
-export([solve/0]).
-import(primes).

%---- Description --------------------------------------------------------------
% The number, 197, is called a circular prime because all rotations
% of the digits: 197, 971, and 719, are themselves prime.
%
% There are thirteen such primes below 100:
%   2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
%
% How many circular primes are there below one million?
%-------------------------------------------------------------------------------

solve() ->
    Limit = 1000000,
    T1 = now(),
    Count = solve(Limit),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "There are ~p circular primes below ~p (~p ms) ~n",
        [length(Count), Limit, Time]
    ).

solve(Limit) ->
    A = primes:generate(Limit),
    [ B ||
        B <- A,
        primes:is_circular(integer_to_list(B))
    ].