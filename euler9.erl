-module(euler9).
-export([result/0]).

result() -> io:format("Result: ~w~n", [solve(1000)]).


% A < B < C, A+B+C = 1000
% find A*B*C

solve(N) ->
    lists:last([X*Y*(N-X-Y) || X <- lists:seq(1, N-2),
			       Y <- lists:seq(1, N-2),
			       X*X+Y*Y =:= (N-X-Y)*(N-X-Y)]).
