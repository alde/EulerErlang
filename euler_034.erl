-module(euler_034).
-export([result/0]).

% The possible matches for this problem are few. Factors blow up fast
% so we can set a limit of 99999 for now.

result() ->
    T1 = now(),
    Res = solve(99999),
    T2 = now(),
    io:format("~w (~w ms) ~n", [Res, timer:now_diff(T2,T1)/1000]).

solve(Limit) ->
    T = [ factor(B) ||
        B <- lists:seq(3, Limit),
        isSum(B)
    ],
    B = lists:foldl(
        fun(X, Sum) ->
            Sum + X
        end, 0, T
    ),
    B.

factor (Num) ->
    S = integer_to_list(Num),
    T = lists:foldl(
            fun(X, Sum) ->
                B = element(1, string:to_integer([X])),
                do_factor(B)+Sum
        end, 0, S
    ),
    T.

do_factor (0) ->
    1;
do_factor (X) ->
    X * do_factor((X-1)).

isSum(Num) ->
    Num == factor(Num).