-module(euler_037).
-export([solve/0]).
-import(primes).

% The number 3797 has an interesting property. Being prime itself, it is
% possible to continuously remove digits from left to right, and remain
% prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
% right to left: 3797, 379, 37, and 3.
%
% Find the sum of the only eleven primes that are both truncatable from left
% to right and right to left.
%
% NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

solve() ->
    T1 = now(),
    Count = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "The sum of all 11 truncatable primes is ~p (~p ms) ~n",
        [Count, Time]
    ).

start() ->
    Primes = primes:generate(1000000),
    Trunc = [ T ||
        T <- Primes,
        is_truncatable(T)
    ],
    lists:foldl(
        fun(X, Acc) ->
            Acc + X
        end, 0, Trunc
    ).

is_truncatable(T) when T < 10 ->
    false;
is_truncatable(T) ->
    B = integer_to_list(T),
    trunc_l(B) and trunc_r(B).

trunc_l(T) when length(T) == 1 ->
    primes:is_prime(list_to_integer(T));
trunc_l(List) ->
    [_|T] = List,
    case primes:is_prime(list_to_integer(T)) of
        true -> trunc_l(T);
        false -> false
    end.

trunc_r(T) when length(T) == 1 ->
    primes:is_prime(list_to_integer(T));
trunc_r(List) ->
    {H, _} = lists:split(
        length(List)-1, List
    ),
    case primes:is_prime(list_to_integer(H)) of
        true -> trunc_r(H);
        false -> false
    end.