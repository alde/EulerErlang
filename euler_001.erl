-module(euler_001).
-export([start/1]).
% If we list all the natural numbers below 10 that are
% multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of
% these multiples is 23.

%Find the sum of all the multiples of 3 or 5 below 1000.

start(Args) when (length(Args) == 1) -> result(1000);
start(Args) ->
        Limit = list_to_integer(lists:nth(2, Args)),
        result(Limit).

result(N) -> io:format("Sum of numbers below ~p divisible by 3 or 5: ~p~n", [N, solve(N)]).

solve(Sum, Cur, N) when Cur >= N -> Sum;
solve(Sum, Cur, N) when (0 == (Cur rem 3)) or (0 == (Cur rem 5)) -> solve(Sum+Cur, Cur+1, N);
solve(Sum, Cur, N) -> solve(Sum, Cur+1, N).

solve(N) -> solve(0, 1, N).
