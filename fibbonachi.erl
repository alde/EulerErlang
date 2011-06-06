-module(fibbonachi).
-export([printfibo/1]).

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

printfibo(N) ->
    printfibos(N, 0).

printfibos( 0, N) ->
    Res = fibo(N),
    io:fwrite("Fibonnaci number ~w is:  ~w~n", [N, Res]) ;

printfibos( Iter, N) when Iter > 0 ->
    printfibos( Iter -1, N +1).
