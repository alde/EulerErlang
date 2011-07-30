-module(euler_006).
-export([result/0]).

result() -> io:format("Result: ~w~n", [solve(100)]).

solve(N)->
    A = squaresum(1, 0, N),
    B = sumsquare(1, 0, N),
    B-A.

squaresum(Curr, Sum, N) when Curr < N ->
    squaresum(Curr+1, Sum+(Curr*Curr), N);
squaresum(Curr, Sum, N) when Curr == N ->
    Sum+(Curr*Curr).

sumsquare(Curr, Sum, N) when Curr < N ->
    sumsquare(Curr+1, Sum+Curr, N);
sumsquare(Curr, Sum, N) when Curr == N ->
    (Sum+Curr)*(Sum+Curr).
