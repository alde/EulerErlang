-module(euler_045).
-export([solve/0]).

%%
% Problem statement
%
% Triangle, pentagonal, and hexagonal numbers are generated by the following
% formulae:
%
%   Triangle        T<n>=n(n+1)/2     1, 3, 6, 10, 15, ...
%   Pentagonal      P<n>=n(3n-1)/2     1, 5, 12, 22, 35, ...
%   Hexagonal       H<n>=n(2n-1)       1, 6, 15, 28, 45, ...
%
% It can be verified that T<285> = P<165> = H<143> = 40755.
%
% Find the next triangle number that is also pentagonal and hexagonal.

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    Next = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "The next triangle number that is also pentagonal and hexagonal is ~p (~p ms) ~n",
        [Next, Time]
    ).

%%
% Solve the problem.
%
% The triangle numbers may be ignored, because all hexagonal numbers are
% also triangle numbers.
%
% return integer
start() ->
    recurse(286).

%%
% Recurse and see if the values match.
%
% [integer] N : number in the sequence
%
% return integer
recurse(N) ->
    C = (N * N  + N) / 2,
    Y = (0.5 + math:sqrt(0.25 + 6 * C)) / 3,
    Z = (1 + math:sqrt(1 + 8 * C)) / 4,
    case (Y - trunc(Y) == 0) and (Z - trunc(Z) == 0) of
        true -> trunc(N * (N + 1) / 2);
        _ -> recurse(N + 1)
    end.