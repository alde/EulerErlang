-module(euler_043).
-export([solve/0]).

% The number, 1406357289, is a 0 to 9 pandigital number because it is made up 
% of each of the digits 0 to 9 in some order, but it also has a rather 
% interesting sub-string divisibility property.
%
% Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we 
% note the following:
%
% d2,d3,d4 =  406 is divisible by 2
% d3,d4,d5 =  063 is divisible by 3
% d4,d5,d6 =  635 is divisible by 5
% d5,d6,d7 =  357 is divisible by 7
% d6,d7,d8 =  572 is divisible by 11
% d7,d8,d9 =  728 is divisible by 13
% d8,d9,d10 = 289 is divisible by 17
%
% Find the sum of all 0 to 9 pandigital numbers with this property.

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    Result = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "Result: ~p. (~p ms) ~n",
        [Result, Time]
    ).

start() ->
	sum([ X || X <- perms("0123456789"), check(X) ]).


%%
% Check substring divisibility with primes, starting at sublist 8-10.
check(Num) ->
	check(Num, 8, [17, 13, 11, 7, 5, 3, 2]).
%%
% Check divisibility
check(_, _, []) ->
	true;
check(List, SubStart, Primes) ->
	[H|T] = Primes,
	case is_divisible(lists:sublist(List, SubStart, 3), H) of
		true -> check(List, SubStart - 1, T);
		_ -> false
	end.

%%
% Check divisibility
is_divisible(List, Div) ->
	list_to_integer(List) rem Div == 0.

%%
% Add up pandigitals
sum([]) -> 0;
sum(List) ->
	lists:foldr(
        fun(X, Acc) ->
            Acc + list_to_integer(X)
        end,
        0,
        List).

%% 
% Generate permutations of a list
perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].