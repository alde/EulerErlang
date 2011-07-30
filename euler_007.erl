-module(euler_007).
-export([result/0]).
-import(math).

result() -> io:format("Result: ~w~n", [solve(10001)]).

solve(N) ->
    nthprime(N, 2).

nthprime(N, Seed) ->
    if N >= 2 ->
	    Nthprime = primes(Seed + 1),
	    nthprime(N-1, Nthprime);
       true -> Seed
    end.

primes(Start)->
    Max = math:sqrt(Start),
    Prime = isprime(Start, 2, Max),
    if Prime == true ->
	    Start;
    true ->
	    primes(Start+1)
		end.

isprime(N, PFactor, Max)->
    if PFactor =< Max ->
	    if N rem PFactor == 0 ->
		    false;
	       true ->
		    isprime(N, PFactor+1, Max)
	    end;
       true ->
	    true
    end.
