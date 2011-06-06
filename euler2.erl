-module(euler2).
-export([result/0]).

result() -> io:format("Result: ~w~n", [solve(4000000)]).

solve(Limit) ->
    solve(0, 1, Limit).

solve(Sum, Count, Limit) ->
    C = fibo(Count),
    if (C >= Limit) -> Sum;
       (0 == (C rem 2)) -> solve(Sum+C, Count+1, Limit);
       true -> solve(Sum, Count+1, Limit)
    end.

%%%%%%%%%% Fast Fibonacci Algoritm
fibo(N) ->
    {Fib, _} = fibo(N, {1, 1}, {0, 1}),
    Fib.
fibo(0, _, Pair) ->
    Pair;
fibo(N, {Fib1, Fib2}, Pair) when N rem 2 == 0 ->
    SquareFib1 = Fib1*Fib1,
    fibo(N div 2, {2*Fib1*Fib2 - SquareFib1, SquareFib1 + Fib2*Fib2}, Pair);
fibo(N, {FibA1, FibA2}=Pair, {FibB1, FibB2}) ->
    fibo(N-1, Pair, {FibA1*FibB2 + FibB1*(FibA2-FibA1),FibA1*FibB1 + FibA2*FibB2}).
