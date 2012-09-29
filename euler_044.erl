-module(euler_044).
-export([solve/0]).

%%
% Problem statement
%
% Pentagonal numbers are generated by the formula, Pn=n(3n - 1)/2. The first ten
% pentagonal numbers are:

%     1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

% It can be seen that P<4> + P<7> = 22 + 70 = 92 = P<8>. However, their difference,
% 70 - 22 = 48, is not pentagonal.

% Find the pair of pentagonal numbers, P<j> and P<k>, for which their sum and
% difference is pentagonal and D = |P<k>  P<j>| is minimised; what is the value of D?

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    Result = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "The difference D is ~p. (~p ms) ~n",
        [Result, Time]
    ).

%%
% Start the recursion
%
% return integer
start() ->
    recurse(1).

%%
% Outer loop. count up until we get what we want.
%
% [integer] I : outer loop value
%
% return integer
recurse(I) ->
    N = trunc(I * ( 3 * I - 1 ) / 2),
    recurse(N, I, I).

%%
% Inner loop counting down to 0 from the value of the outer loop.
%
% [integer] N : pentagonal value
% [integer] I : outer loop value
% [integer] J : inner loop value
%
% return integer
recurse(_N, I, 0) ->
    recurse(I + 1);
recurse(N, I, J) ->
    M = trunc(J * ( 3 * J - 1 ) / 2),
    case (is_pentagonal(N - M) and is_pentagonal(N + M)) of
        true -> N-M;
        _ -> recurse(N, I, J - 1)
    end.

%%
% Check if a value is pentagonal
%
% [numerical] Num : value to check
%
% return boolean
is_pentagonal(Num) ->
    PenTest = (math:sqrt(1 + 24 * Num) + 1) / 6,
    is_int(PenTest).

%%
% Simple check if a value could be considered an integer.
%
% [integer] Value : value to check
%
% return boolean
is_int(Value) ->
    case (Value - trunc(Value)) of
        X when (X < 0) -> false;
        X when (X > 0) -> false;
        _ -> true
    end.