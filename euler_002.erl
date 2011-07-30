-module(euler_002).
-export([result/0]).

result() -> io:format("Result: ~w~n", [solve(4000000)]).

solve(Limit) ->
    solve(0, 1, Limit).

solve(Sum, N, Limit) ->
    % Get the n:th fibonacci number.
    C = fibo(N),
        % If the fibonnaci number is greater
        % than or equal to our limit, return the Sum.
        if (C >= Limit) -> Sum;
           % if the fibbonachi number is evenly
           % divisible by 2, add it to the sum,
           % increase N and recurse again.
           (0 == (C rem 2)) -> solve(Sum+C, N+1, Limit);
           % if none of the above if cases apply, this
           % one always will. Increase N and recurse again.
           true -> solve(Sum, N+1, Limit)
        end.

% Fast Fibonacci Algoritm to get the Nth fibonacci number.
fibo(N) ->
    % Start the recursion
    {Fib, _} = fibo(N, {1, 1}, {0, 1}),
    Fib. % return the Fibonacci number.
% if N equals 0, return the Pair tuple to fibo/1
fibo(0, _, Pair) ->
    Pair; % return the Pair tuple
% If N is evenly divisible by 2
fibo(N, {Fib1, Fib2}, Pair) when N rem 2 == 0 ->
    % Square the first Fibonacci number in the Tuple
    SquareFib1 = Fib1*Fib1,
    % Recurse again with N halved, the first tuple
    % modified as below, the second tuple unchanged
    fibo(N div 2, {2*Fib1*Fib2 - SquareFib1, SquareFib1 + Fib2*Fib2}, Pair);
% else, make sure both Pair and {FibA1, FibA2} have the value of
% the second argument.
fibo(N, {FibA1, FibA2}=Pair, {FibB1, FibB2}) ->
    % Decrease N by 1, do some magic Mathematics on the second
    % tuple, then recurse again.
    fibo(N-1, Pair, {FibA1*FibB2 + FibB1*(FibA2-FibA1),FibA1*FibB1 + FibA2*FibB2}).
