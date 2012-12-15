-module(euler_049).
-export([solve/0]).
-import(primes).

% The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
% increases by 3330, is unusual in two ways: 
%
% (i) each of the three terms are prime, and, 
% (ii) each of the 4-digit numbers are permutations of one another.
%
% There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
% exhibiting this property, but there is one other 4-digit increasing sequence.
%
% What 12-digit number do you form by concatenating the three terms in this sequence?

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    [R1, R2, R3] = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "Result: ~p~p~p. (~p ms) ~n",
        [R1, R2, R3, Time]
    ).

start() ->
	Group = group(
		lists:filter(
			fun(X) ->
				length(integer_to_list(X)) == 4
			end,
		primes:generate(10000))
	),
	lists:flatten(
		lists:filter(
			fun(E) -> check(E) end,
		lists:filter(
			fun(E) -> length(E) == 3 end,
		Group))).

%%
% Group numbers that are permutations of eachother
group(Primes) -> group(Primes, []).
group([], List) -> List;
group([H|Primes], List) ->
	{Group, Peas} = get_permutations(H, Primes),
	group(Peas, [Group | List]).

%%
% Get all permutations from a list of primes
get_permutations(H, Primes) ->
	L = lists:filter(
		fun(E) ->
			is_permutation(H, E)
		end,
		Primes),
	lists:foreach(
		fun(E) ->
			lists:delete(E, Primes)
		end,
		L),
	{L, lists:sort(Primes)}.


%%
% Check if two items are permutations of eachother.
is_permutation(E, B) ->
	lists:sort(integer_to_list(B)) == lists:sort(integer_to_list(E)).

%%
% Check so the three elements of the list correspond to the problem statement.
check([A|[B|[C]]]) ->
	(C == (B + 3330)) and (B == (A + 3330)).