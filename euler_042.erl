-module(euler_042).
-export([solve/0]).
-import(csv).

%%
% Problem statement
%
% The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1);
% so the first ten triangle numbers are:
%
% 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
%
% By converting each letter in a word to a number corresponding to its
% alphabetical position and adding these values we form a word value.
% For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word
% value is a triangle number then we shall call the word a triangle word.
%
% Using words.txt, a 16K text file containing nearly two-thousand
% common English words, how many are triangle words?

%%
% Entry point to the Euler problem.
solve() ->
    T1 = now(),
    Largest = start(),
    T2 = now(),
    Time = timer:now_diff(T2,T1)/1000,
    io:format(
        "There are ~p triangle words in the file. (~p ms) ~n",
        [Largest, Time]
    ).

%%
% Start the solving of the problem and get the number of triangle words
%
% return integer
start() ->
    [Words | _] = read_lines("words.txt"),
    length(get_triangles(Words)).

%%
% Read the contents of a CSV file
%
% [string] Filename : name of the file to read
%
% return list
read_lines(Filename) ->
    {ok, Device} = file:open(Filename, [raw, read]),
    try csv:parse(csv:lazy(Device))
    after file:close(Device)
    end.

%%
% Filter out triangle words
%
% [list] Words : list of words
%
% return list of words matching the criteria
get_triangles(Words) ->
    [ W ||
        W <- Words,
        is_triangle(W)
    ].

%%
% Check if a word is a triangle word
%
% [string] Word : word to verify
%
% return boolean
is_triangle(Word) ->
    Wordsum = (math:sqrt(1+8*sum(Word)) - 1) / 2,
    is_int(Wordsum).

%%
% Simple checker to see if a value can be considered to be an integer.
%
% [numeric] Value : numeric value to check
%
% return boolean
is_int(Value) ->
    case (Value - trunc(Value)) of
        X when (X < 0) -> false;
        X when (X > 0) -> false;
        _ -> true
    end.

%%
% Get the sum of the integer values of a word.
%
% [string] Word : Word to get value on
%
% return integer
sum(Word) ->
    lists:foldr(
        fun(X, Acc) ->
            Acc + value([X])
        end,
        0,
        Word).

%%
% Value of a character based on position in alphabet.
%
% [string] : character to get value for
%
% return integer
value("A") ->
    1;
value("B") ->
    2;
value("C") ->
    3;
value("D") ->
    4;
value("E") ->
    5;
value("F") ->
    6;
value("G") ->
    7;
value("H") ->
    8;
value("I") ->
    9;
value("J") ->
    10;
value("K") ->
    11;
value("L") ->
    12;
value("M") ->
    13;
value("N") ->
    14;
value("O") ->
    15;
value("P") ->
    16;
value("Q") ->
    17;
value("R") ->
    18;
value("S") ->
    19;
value("T") ->
    20;
value("U") ->
    21;
value("V") ->
    22;
value("W") ->
    23;
value("X") ->
    24;
value("Y") ->
    25;
value("Z") ->
    26;
value(_) ->
    0.