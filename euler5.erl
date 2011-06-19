-module(euler5).
-export([result/0]).

result() -> io:format("Result: ~w~n", [solve(20)]).

solve(N) -> multiply(1, filter(lists:seq(2, N))).

multiply(M, []) -> M;
multiply(M, [H|T]) -> multiply(M*H, T).

filter([]) -> [];
filter([L|T]) -> [L | filter([divide(X, L) || X <- T])].


divide(A, B) when (A rem B =:= 0) -> A div B;
divide(A, _) -> A.
