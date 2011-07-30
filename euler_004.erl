-module(euler_004).
-export([result/0]).

result() -> io:format("Result: ~w~n", [solve()]).

solve() ->
    lists:last(lists:sort(solve(100, 999))).

solve(Start, End) ->
      [ A*B ||
        A <- lists:seq(Start, End),
        B <- lists:seq(Start, A),
        is_palindrome(A*B)
    ].

is_palindrome(N) ->
    L=integer_to_list(N),
    L==lists:reverse(L).
