-module(euler_030).
-export([result/0]).

% Surprisingly there are only three numbers that can be written as
% the sum of fourth powers of their digits:
%
%% 1634 = 1^4 + 6^4 + 3^4 + 4^4
%% 8208 = 8^4 + 2^4 + 0^4 + 8^4
%% 9474 = 9^4 + 4^4 + 7^4 + 4^4
%
% As 1 = 1^4 is not a sum it is not included.
%
% The sum of these numbers is 1634 + 8208 + 9474 = 19316.
%
% Find the sum of all the numbers that can be written as the sum of fifth
% powers of their digits.
%
%%% Facts:
% * We Need an upper and a lower limit for this.
% * 1^5 is not a sum, so ignoring that.
% * The maximum value for one digit is 9^5 = 59049
% * Since 7*9^5 is much less thas 9999999, the upper limit is a 6 digit number.
% * 6*9^5 = 354294 < 999999, so 354294 is usable as an upper limit.
result() ->
    T1 = now(),
    Res = result(2, 354294),
    T2 = now(),
    io:format("~w (~w ms)~n", [Res, timer:now_diff(T2,T1)/1000]).

result(Lower, Upper) ->
    Candidates = lists:seq(Lower, Upper),
    Cands = [ powersum(A) ||
        A <- Candidates,
        isSameAsPowersum(A)
    ],
    Sum = lists:foldl(
        fun (X, Acc) ->
            Acc + X
        end, 0, Cands
    ),
    Sum.

powersum(A) ->
    T = trunc(
        lists:foldl(
            fun (X, Sum) ->
                B = element(1, string:to_integer([X])),
                math:pow(B, 5)+Sum
            end, 0, integer_to_list(A)
        )
    ),
    T.

isSameAsPowersum(X) ->
    X == powersum(X).