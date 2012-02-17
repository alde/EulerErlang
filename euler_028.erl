-module (euler_028).
-export ([result/0]).

%
% 1001 x 1001 sprial, sum diagonals.
%
% Analying gives us the following facts:
%
% 1) The Top right corner of the N:th spiral is N^2.
% 2) The Top left corner of the N:th spiral is (N^2-(N-1))
% 3) The Bottom Left corner of the N:th spiral is (N^2-2(N-1))
% 4) The Bottom Right corner of the N:th spiral is (N^2-3(N-1))
% 5) The innermost (1st) spiral adds 1 to the sum.
%
% The formula for each spiral is thus:
%%
%%  F(N) = N^2 + N^2 - N + 1 + N^2 - 2N + 2 + N^2 - 3N + 3
%%  F(N) = 4N^2 - 6N + 6
%%
% So we get the total sum by recursing over spirals from the 1001th going each
% odd number (since each spiral is larger by one on each side) and at the end
% adding one.

result() ->
    F = spiral ( 1001, 0 ),
    io:format("~w ~n", [F]).

spiral(N, Sum) when N == 1 ->
    Sum + 1;
spiral(N, Sum) ->
    spiral(N - 2, (Sum + (4 * N * N ) - ( 6 * N ) + 6 )).
