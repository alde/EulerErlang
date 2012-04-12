-module(euler_038).
-export([solve/0]).

% Take the number 192 and multiply it by each of 1, 2, and 3:
%
% 192 x 1 = 192
% 192 x 2 = 384
% 192 x 3 = 576
% By concatenating each product we get the 1 to 9 pandigital, 192384576.
% We will call 192384576 the concatenated product of 192 and (1,2,3)
%
% The same can be achieved by starting with 9 and multiplying by
% 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the
% concatenated product of 9 and (1,2,3,4,5).
%
% What is the largest 1 to 9 pandigital 9-digit number that can be formed as
% the concatenated product of an integer with (1,2, ... , n) where n > 1?

solve() ->
    T1 = now(),
    Largest = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "The largest pandigital is ~p (~p ms) ~n",
        [Largest, Time]
    ).

start() ->
    Candidates = outer_loop(1, []),
    Pandigitals = lists:filter(
        fun(Y) ->
            is_pandigital(Y)
        end, Candidates
    ),
    Sorted = lists:reverse(lists:sort(Pandigitals)),
    lists:nth(1, Sorted).

% Arbitrarily large upper limit
outer_loop(Outer, Collection) when Outer > 99999 ->
    % we only care about 1..9 pandigitals
    lists:filter(
        fun(K) ->
            length(K) == 9
        end, Collection
    );

% Start the run of the inner loop, make a new head with an empty string.
outer_loop(Number, Collection) ->
    inner_loop(Number, 1, [""|Collection]).

% End of the inner loop.
inner_loop(Num, Int, Collection) when (Int == 9) ->
    NewCollection = new_collection(Collection, Num, Int),
    outer_loop(Num + 1, NewCollection);

% If we have more than a length of 9 in the head, theres no possibility of
% a pandigital 1..9 number, so no use continuing the inner loop.
inner_loop(Num, _, [H|T]) when (length(H) > 9) ->
    outer_loop(Num+1, [H|T]);

% Add the product to the collection
inner_loop(Num, Int, Collection) ->
    NewCollection = new_collection(Collection, Num, Int),
    inner_loop(Num, Int + 1, NewCollection).

% Is the number a 1..9 pandigital?
is_pandigital(Num) ->
    B = lists:sort(Num),
    B == "123456789".

% Concatinate the product af A and B to the head of the list.
new_collection(List, A, B) ->
    [ Head | _ ] = List,
    [lists:concat([Head, (A*B)]) | List].