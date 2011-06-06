-module(euler1).
-export([result/0]).

result() -> io:format("Result: ~w~n", [solve(1000)]).

solve(Sum, Cur, N) when Cur >= N -> Sum;
solve(Sum, Cur, N) when (0 == (Cur rem 3)) or (0 == (Cur rem 5)) -> solve(Sum+Cur, Cur+1, N);
solve(Sum, Cur, N) -> solve(Sum, Cur+1, N).

solve(N) -> solve(0, 1, N).
