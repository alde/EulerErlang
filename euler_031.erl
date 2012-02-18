-module(euler_031).
-export([result/0]).

result() ->
    T1 = now(),
    Res = solve(200),
    T2 = now(),
    io:format("~w (~w ms) ~n", [Res, timer:now_diff(T2,T1)/1000]).

solve (Total) ->
    Denominations = [200, 100, 50, 20, 10, 5, 2, 1],
    ways(Total, Denominations).

% If we reach the end, increase by one (combination successful)
ways(0, _) ->
    1;
% If we run out of cons, exit
ways(_, []) ->
    0;
% If we overshoot the target, exit
ways(N, _) when (N < 0) ->
    0;
% Remove the current coin, and recurse into the tail, but first recurse into the
% current set of coins with the current coin removed.
ways(N, [Coin|Tail]) ->
    ways(N, Tail) + ways(N - Coin, [Coin|Tail]).
