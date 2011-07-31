-module(euler_024).
-export([result/0]).

% A permutation is an ordered arrangement of objects.
% For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4.
% If all of the permutations are listed numerically or alphabetically, we
% call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
%
% 012   021   102   120   201   210
%
% What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

result() ->
    io:format("The 1000000th permutation is: ~s~n ", [solve()]).

permutations([]) -> [[]];
permutations(L) -> [[H|T] || H <- L, T <- permutations(L--[H])].

solve() -> lists:nth(1000000, permutations("0123456789")).
