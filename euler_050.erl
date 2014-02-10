-module(euler_050).
-export([solve/0]).

% The prime 41, can be written as the sum of six consecutive primes:
%       41 = 2 + 3 + 5 + 7 + 11 + 13
%
% This is the longest sum of consecutive primes that adds to a prime below one-hundred.
%
% The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.
%
% Which prime, below one-million, can be written as the sum of the most consecutive primes?

-define(max, 1000000).

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    {Sum, NumTerms} = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "Result: ~p has the longest chain with ~p consecutive terms. (~p ms) ~n",
        [Sum, NumTerms, Time]
    ).

start() ->
        Primes = primes:generate(round(?max / 2)),
        X = sum_seq(Primes),
        Filtered = lists:filter(fun({_, _, T}) -> T == true end, X),
        {Max, Terms, _} = list_max(Filtered),
        {Max, Terms}.

sum_seq(P) ->
    sum_seq(P, 0, 0, [], P).
sum_seq([], _, _, Acc, _) ->
    Acc;
sum_seq([H|_], Sum, _, Acc, [_|T]) when Sum + H > ?max ->
    sum_seq(T, 0, 0, Acc, T);
sum_seq([H|T], Sum, Count, Acc, P) ->
    Coll = [ create_entry(Sum, Count, H) | Acc ],
    sum_seq(T, Sum + H, Count + 1, Coll, P).

create_entry(Sum, Count, T) ->
    { Sum + T, Count + 1, primes:is_prime(Sum + T) }.

list_max([]) -> {0, 0, true};
list_max(L) -> list_max(L, {0, 0, true}).
list_max([], C) -> C;
list_max([{HV, HT, HP}|L], {_, MT, _}) when HT > MT -> list_max(L, { HV, HT, HP});
list_max([_|L], C) -> list_max(L, C).