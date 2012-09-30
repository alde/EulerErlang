-module(euler_046).
-export([solve/0]).
-import(primes).

%%
% Problem statement
%
% It was proposed by Christian Goldbach that every odd composite number
% can be written as the sum of a prime and twice a square.
%
%    9 = 7 + 2*1^2
%   15 = 7 + 2*2^2
%   21 = 3 + 2*3^2
%   25 = 7 + 2*3^2
%   27 = 19 + 2*2^2
%   33 = 31 + 2*1^2
%
% It turns out that the conjecture was false.
%
% What is the smallest odd composite that cannot be written as the sum of
% a prime and twice a square?

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    Result = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "The smallest number not writeable as the sum of a prime and twice a square is ~p. (~p ms) ~n",
        [Result, Time]
    ).

%%
% Solve the problem.
%
% return integer
start() ->
    Primes = primes:generate(10000),
    Composites = generate_composites(Primes),
    DoubleSquares = generate_double_squares(100),
    Sums = generate_sums(Primes, DoubleSquares),
    find_lowest(Composites, Sums).

%%
% Generate a list of double squares.
%
% [integer] Limit : upper limit for the double squares
%
% return list
generate_double_squares(Limit) ->
    [ (2*(D*D)) ||
        D <- lists:seq(1, Limit)
    ].

%%
% Generate a list of odd composites that are not primes.
%
% [list] Primes : list of prime numbers
%
% return list
generate_composites(Primes) ->
    [ C ||
        C <- lists:seq(3, 10000, 2),
        (not lists:member(C, Primes)) and (C rem 2 =/= 0)
    ].

%%
% Generate a list containing the sums of primes and double squares
%
% [list] Primes        : list of prime numbers
% [list] DoubleSquares : list of double squares
%
% return list
generate_sums(Primes, DoubleSquares) ->
    [ S ||
        S <- [ X+Y || X <- Primes, Y <- DoubleSquares ]
    ].

%%
% Find the lowest odd composite not in the list of sums
%
% [list] Composites : list of odd non-primes
% [list] Sums       : list of sums of primes and double squares
%
% return integer
find_lowest(Composites, Sums) ->
    [Res | _Tail] = lists:sort([ R ||
        R <- Composites,
        (not lists:member(R, Sums))
    ]),
    Res.