-module(euler_033).
-export([result/0]).

% The fraction 49/98 is a curious fraction, as an inexperienced mathematician
% in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which
% is correct, is obtained by cancelling the 9s.
%
% We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
%
% There are exactly four non-trivial examples of this type of fraction, less
% than one in value, and containing two digits in the numerator and denominator.
%
% If the product of these four fractions is given in its lowest common terms,
% find the value of the denominator.

result() ->
    T1 = now(),
    Res = solve(),
    T2 = now(),
    io:format("~w (~w ms) ~n", [Res, timer:now_diff(T2,T1)/1000]).

% fill a list with fractions that are non-trivial and multiply them.
% The fractions we're interested in are between 11/11 and 100/100
% So ij/ki, which we get by taking (10i+j) / (10k+i)
% At
solve() ->
    T = [ ((I * 10) + J) / ((K * 10) + I) ||
        I <- lists:seq(1, 10),
        J <- lists:seq(1, I),
        K <- lists:seq(1, J),
        isNonTrivial(I,J,K)
    ],
    lists:foldl(
        fun (X, Acc) ->
            X*Acc
        end, 1, T
    ).

% If k(ij) == j(ki) the number is trivial
% when ij = i*10+j and ki = k*10+i
isNonTrivial(I, J, K) ->
    KI = (K * 10) + I,
    IJ = (I * 10) + J,
    K*IJ == KI*J.
