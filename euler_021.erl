-module(euler_021).
-export([result/0]).
% Let d(n) be defined as the sum of proper divisors of n
% (numbers less than n which divide evenly into n).
%
% If d(a) = b and d(b) = a, where a != b, then a and b ar
% an amicable pair and each of a and b are called amicable numbers.

% For example, the proper divisors of 220 are
%       1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110;
% therefore d(220) = 284. The proper divisors of 284 are
% 1, 2, 4, 71 and 142; so d(284) = 220.

% Evaluate the sum of all the amicable numbers under 10000.

result() ->
         L = 10000,
         io:format("The sum of all amicable numbers under ~w : ~w~n", [L, solve(L)]).

add_divisors(N) ->
    add_divisors(N, 1, N div 2, 0).

add_divisors(N, Try, Limit, Sum) ->
    if
        Try > Limit ->
            Sum;
        N rem Try == 0 ->
            add_divisors(N, Try + 1, Limit, Sum + Try);
        true ->
            add_divisors(N, Try + 1, Limit, Sum)
    end.

% As stated, if sum of divisors are equal, but the numbers
% are different, the number is amicable
is_amicable(N) ->
    CandidateOther = add_divisors(N),
    ShouldBeN = add_divisors(CandidateOther),
    (N == ShouldBeN) and (N /= CandidateOther).

% start the check at 1, end at Limit
add_amicable_numbers(Limit) ->
    add_amicable_numbers(1, Limit, 0).

add_amicable_numbers(Try, Limit, Sum) ->
    %check if Try is an amicable number
    IsAmicable = is_amicable(Try),
    if
        Try >= Limit ->
            Sum;
        IsAmicable ->
            add_amicable_numbers(Try + 1, Limit, Sum + Try);
        true ->
            add_amicable_numbers(Try + 1, Limit, Sum)
    end.

solve(Limit) ->
    add_amicable_numbers(Limit).
