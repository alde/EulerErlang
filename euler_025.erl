-module(euler_025).
-export([result/0]).

         % The Fibonacci sequence is defined by the recurrence relation:
         %
         % Fn = Fn1 + Fn2, where F1 = 1 and F2 = 1.
         %
         % Hence the first 12 terms will be:
         % F1 = 1
         % F2 = 1
         % F3 = 2
         % F4 = 3
         % F5 = 5
         % F6 = 8
         % F7 = 13
         % F8 = 21
         % F9 = 34
         % F10 = 55
         % F11 = 89
         % F12 = 144
         % The 12th term, F12, is the first term to contain three digits.
         %
         % What is the first term in the Fibonacci sequence to contain 1000 digits?

result() ->
    T1 = now(),
    L = 1000,
    Res = solve(L),
    T2 = now(),
    io:format("First fibonacci number with ~w digits is ~w (~w ms) ~n", [L, Res, timer:now_diff(T2,T1)/1000]).

solve(Limit) ->
    Root5 = math:sqrt(5),
    Phi = (1+Root5)/2,
    Pos = ceiling((Limit-1+math:log10(5)/2)/math:log10(Phi)),
    Pos.

ceiling(X) ->
    T = erlang:trunc(X),
    case (X - T) of
        Neg when Neg < 0 -> T;
        Pos when Pos > 0 -> T + 1;
        _ -> T
    end.
