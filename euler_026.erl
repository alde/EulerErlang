-module(euler_026).
-export([result/0]).
% A unit fraction contains 1 in the numerator.
% The decimal representation of the unit fractions
% with denominators 2 to 10 are given:
%
% 1/2     =       0.5
% 1/3     =       0.(3)
% 1/4     =       0.25
% 1/5     =       0.2
% 1/6     =       0.1(6)
% 1/7     =       0.(142857)
% 1/8     =       0.125
% 1/9     =       0.(1)
% 1/10    =       0.1
%
% Where 0.1(6) means 0.166666..., and has a 1-digit
% recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.
%.
% Find the value of d  1000 for which 1/d contains the longest recurring
% cycle in its decimal fraction part.

result() ->
    T1 = now(),
    L = 997,
    Res = solve(L),
    D = element(1, Res),
    Cycle = element(2, Res),
    T2 = now(),
    io:format("~w has the longest recurring cycle of decimals with ~w decimals. (~w ms)~n", [D, Cycle, timer:now_diff(T2,T1)/1000]).

solve(Start) ->
        Primes = lists:reverse([2|sieve(lists:seq(3, Start, 2), math:sqrt(Start))]),
        decimals(Start, Primes, {0,0}).

sieve([H|T], M) when H=< M -> [H|sieve([X || X<- T, X rem H /= 0], M)];
sieve(L, _) -> L.

decimals(Curr, Rem, Max) ->
        D = recurring(Curr),
        B = length(Rem),
        if
                (element(1,Max) == element(2,Max)+1) ->
                        Max;
                (B == 0) ->
                        Max;
                (D > element(2, Max)) ->
                        [H|T] = Rem,
                        decimals(H, T, {Curr, D});
                true ->
                        [H|T] = Rem,
                        decimals(H, T, Max)
                end.

recurring(N) when ((N rem 2) == 0) or ((N rem 5) == 0) ->
        0;
recurring(N) ->
        recurse(1, N).

recurse(I, N) when I >= N ->
        I;
recurse(I, N) ->
        B = ((pow(10, I) -1)),
        if (B rem N) == 0 ->
                I;
        true ->
                recurse(I+1, N)
        end.

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).

