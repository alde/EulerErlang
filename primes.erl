-module(primes).
-export([is_prime/1, generate/1, is_circular/1]).

%---- Is Prime -----------------------------------------------------------------
is_prime(N,V) ->
    E = round(math:sqrt(N))+1,
    case V > E of
        true -> true;
        _  ->
            case N rem V of
                0 -> false;
                _ -> is_prime(N,V+1)
            end
        end.

is_prime(N) when N < 10 ->
    lists:member(N, [2, 3, 5, 7]);
is_prime(N) ->
    is_prime(N,2).

%---- Sieve of Eratheosnes -----------------------------------------------------
primes(Prime, Max, Primes,Integers) when Prime > Max ->
    lists:reverse(Primes) ++ Integers;
primes(Prime, Max, Primes, Integers) ->
    [NewPrime|NewIntegers] = [ X || X <- Integers, X rem Prime =/= 0 ],
    primes(NewPrime, Max, [Prime|Primes], NewIntegers).
primes(N) ->
    primes(2, round(math:sqrt(N)), [], lists:seq(3,N,2)). % skip odds
generate(Limit) ->
    primes(Limit).

%---- Check Circularity --------------------------------------------------------
is_circular (Prime) ->
    is_circular(Prime, 0).

is_circular (Prime, Count) when (length(Prime) == 1) or (length(Prime) == Count) ->
    true;
is_circular (Prime, Count) ->
    case is_prime(list_to_integer(Prime)) of
        true -> is_circular(rotate_list(Prime), Count + 1);
        false -> false
    end.

%---- Rotate a list... doesn't really belong here ------------------------------
rotate_list([]) ->
  [];
rotate_list(List) ->
    {H, T} = lists:split(
        length(List)-1, List    % split list so only last element is tail.
    ),
    T ++ H.                     % swap head and tail