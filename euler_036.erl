-module(euler_036).
-export([solve/0]).

solve() ->
    Limit = 1000000,
    T1 = now(),
    Count = solve(Limit),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "The sum of all doubly palindrome numbers under ~p is ~p (~p ms) ~n",
        [Limit, Count, Time]
    ).

solve(N) ->
    List = [ A ||
        A <- lists:seq(1, N),
        C <- io_lib:format("~.2B", [A]),
        is_palindrome(C),
        is_palindrome(integer_to_list(A))
    ],

    lists:foldl(
        fun (X, Acc) ->
            Acc + X
        end, 0, List
    ).

is_palindrome(N) ->
    Bool = N==lists:reverse(N),
    Bool.

