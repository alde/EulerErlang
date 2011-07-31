-module(euler_023).
-export([result/0]).

result() ->
         T1 = now(),
         Sum = solve(),
         T2 = now(),
         io:format("The largest number that can't be written as abundant is: ~w. (~w ms)~n", [Sum, timer:now_diff(T2,T1)/1000]).

solve() ->
    lists:sum(allNonPairsUpTo(20161)).

isAbundant(N) ->
    addDivisors(N) > N.

addDivisors(N) ->
    addDivisors(N, 1, N div 2, 0).

addDivisors(N, Try, Limit, Sum) ->
    if
        Try > Limit ->
            Sum;
        N rem Try == 0 ->
            addDivisors(N, Try + 1, Limit, Sum + Try);
        true ->
            addDivisors(N, Try + 1, Limit, Sum)
    end.

% Make a list containing a sequence of numbers from 1 to Max,
% where each number passes isAbundant.
allAbundantNumbersUpTo(Max) ->
    [ N || N <- lists:seq(1, Max), isAbundant(N) ].

% A list of added abundant numbers, where N1+N2 is less or equal to Max.
allPairsOfAbundantNumbersUpTo(Max) ->
    AbundantNumbers = allAbundantNumbersUpTo(Max),
    [ N1 + N2 || N1 <- AbundantNumbers, N2 <- AbundantNumbers, N1 + N2 =< Max ].

% A list of non-pairs
allNonPairsUpTo(Max) ->
    Pairs = allPairsOfAbundantNumbersUpTo(Max),
    SortedPairs = lists:sort(Pairs),
    holesInList([ 0 | SortedPairs]).

% "fill" in the holes.
holesInList([H1, H2 | Tail]) when H2 > H1 + 1 ->
    lists:seq(H1 + 1, H2 - 1) ++ holesInList([H2 | Tail]);
holesInList([_H1, H2 | Tail]) ->
    holesInList([H2 | Tail]);
holesInList(_List) ->
    [].
