-module(euler_032).
-export([result/0]).
%   We shall say that an n-digit number is pandigital if it makes use of all the
%   digits 1 to n exactly once;
%
%   for example, the 5-digit number, 15234, is 1 through 5 pandigital.
%
%   The product 7254 is unusual, as the identity, 39*186 = 7254, containing
%   multiplicand, multiplier, and product is 1 through 9 pandigital.
%
%   Find the sum of all products whose multiplicand/multiplier/product
%   identity can be written as a 1 through 9 pandigital.
%
%   HINT: Some products can be obtained in more than one way so be sure to
%   only include it once in your sum.

result() ->
    T1 = now(),
    Res = solve(),
    T2 = now(),
    io:format("~w (~w ms) ~n", [Res, timer:now_diff(T2,T1)/1000]).

solve() ->
    % Fill list Acc with A*B where 1 <= A <= 99, 100 <= B <= 9999
    % and [A, B, A*B] is pandigital together.
    Acc = [ A*B ||
        A <- lists:seq(1, 99),
        B <- lists:seq(100, 9999),
        isPandigital(A, B, A*B)
    ],
    % Remove duplicate products
    Distinct = gb_sets:to_list(gb_sets:from_list(Acc)),
    % Add up the products
    Sum = lists:foldl(
        fun (Elem, Coll) ->
            Elem+Coll
        end, 0, Distinct
    ),
    Sum.

isPandigital(Fact1, Fact2, Product) ->
    AllNums = lists:concat([Fact1, Fact2, Product]),
    isPandigital(AllNums).

%% if theres not 9 numbers, discard it immediatley
isPandigital(Number) when length(Number) /= 9 ->
    false;
%% start the recursion
isPandigital(Number) ->
    Sequence = lists:seq(1, 9),
    isPandigital(Number, Sequence).

%% If both lists are empty, we've used 1-9 exactly once. Number is Pandigital
isPandigital([], []) ->
    true;
%% If we're out of 1-9s and still have numbers left, somethings wrong.
isPandigital(_, []) ->
    false;
%% If the number has a 0 in it, it's not pandigital. Having this check might seem
%% redundant, but it did give a slight speed increase.
isPandigital([Number|_], _) when Number == 0 ->
    false;
%% Do a check to see if the head of the list exists in the [1-9] list.
%% if it does, remove if from the [1-9] list and recurse to check the tail of
%% the number.
isPandigital([Number|Tail], Candidates) ->
    Int = element(1, string:to_integer([Number])),
    case lists:member(Int, Candidates) of
        true ->
            isPandigital(Tail, lists:delete(Int, Candidates));
        false ->
            false
    end.
