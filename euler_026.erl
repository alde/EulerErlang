-module(euler_026).
-export([result/0]).

result() ->
    T1 = now(),
    L = 997,
    Res = solve(L),
    T2 = now(),
%    io:format("~w has the longest recurring cycle is. (~w ms)~n", [Res, timer:now_diff(T2,T1)/1000]).
    io:format("~w is ~s a prime. (~w ms) ~n", [L, Res, timer:now_diff(T2,T1)/1000]).

solve(Start) ->
    % No point to start from 1, and 998 and 999 and 1000 aren't primes.
    start(Start, 7, 0).

start(Curr, End, Nums) ->
    IsPrime = isprime(Curr),
    if IsPrime ->
        "indeed";
       true ->
        "not"
    end.  



isprime(N) when N == 1 ->
    false;
isprime(N) when N == 2 ->
    true;
isprime(N) when (0==(N rem 2)) ->
    false;
isprime(N) ->
    isprime(N, 1).

isprime(N, T) when ((T rem N) == 0) and (T < N) and (T > 1) ->
    false;
isprime(N, T) when ((T rem N) == 0) and (T == N) ->
    true;
isprime(N, T) when ((T rem N) /= 0) ->
    isprime(N, T+1). 

