-module(euler_027).
-export([result/0]).

result() ->
    T1 = now(),
    Res = solution(1000),
    A = element(1, Res),
    B = element(2, Res),
    Product = element(3, Res),
    Count = element(4, Res),
    T2 = now(),
    io:format("n^2 + ~wn + ~w have the most consecutive primes (~w). The product is: ~w. (Runtime: ~w ms)~n",
                    [A, B, Count, Product, timer:now_diff(T2,T1)/1000]).

solution(Max) ->
    BLIST = b_list(Max),
    PLIST = p_list(Max),
    Self = self(),
    % Spawn a new process running the gatherer function and pass them to this function.
    Gatherer = spawn(fun() -> gatherer(Self, 0, 0, 0, 0, length(BLIST)) end),
    % Spawn several new processes to calculate best A for each B and pass them to the Gatherer process.
    lists:foreach(fun(B) -> spawn(fun() -> calculator(Gatherer, B, PLIST, Max) end) end, BLIST),
    % recieve A B and Count from the gatherer process
    receive
        {A, B, _Count} ->
            {A, B, A*B, _Count}
    end.

% Collect the result from all calculator processes and send the result back to the parent.
gatherer(ParentPid, A, B, Count, ToReceive, ToReceive) ->
    ParentPid ! {A, B, Count};
gatherer(ParentPid, A, B, Count, Received, ToReceive) ->
    receive
        {ResA, ResB, ResCount} when ResCount > Count ->
            gatherer(ParentPid, ResA, ResB, ResCount, Received + 1, ToReceive);
        _Res ->
            gatherer(ParentPid, A, B, Count, Received + 1, ToReceive)
    end.

% Calculate the best A for a given B and send the result to the gatherer.
calculator(GathererPid, B, PLIST, Max) ->
    GathererPid ! max_for_b(B, PLIST, Max, 0, 0).

% __________________________________________________________________________ %
%| Maths:                                                                   |%
%|                                                                          |%
%| if (n == 0) then                                                         |%
%|      n^2 + A*n + B = B                                                   |%
%| so B is a prime and 0 < b < Max  (Since primes are always positive.      |%
%| if (n == 1) then                                                         |%
%|      n^2 + A*n + B = 1 + A + B                                           |%
%|                  A = P - B - 1                                           |%
%| so P is a prime and -Max < P -(B+1) < Max                                |%
%|      so 0 < P < Max + B + 1      (Primes are Positive)                   |%
%|      so 0 < p < 2*Max + 1                                                |%
%|__________________________________________________________________________|%

% List of possible primes 'B':
b_list(Max) ->
    [X || X <- lists:seq(1, Max - 1), is_prime(X)].
% List of possible primes 'P':
p_list(Max) ->
    [X || X <- lists:seq(1, 2*Max), is_prime(X)].

% Get the best A for a given B
max_for_b(B, [], _, A, Count)-> {A, B, Count};
max_for_b(B, [P|T], Max, A, Count)->
    case P < Max + B + 1 of
        true ->
            TestA = P - B - 1,
            TestCount = count(TestA, B),
            case TestCount > Count of
                true ->
                    max_for_b(B, T, Max, TestA, TestCount);
                _ ->
                    max_for_b(B, T, Max, A, Count)
            end;
        _ ->
            max_for_b(B, T, Max, A, Count)
    end.

% Count the consecutive primes for n^2 + A*n + B
count(A, B) ->
    count(A, B, 0).

count(A, B, N) ->
    P = N*N + A*N + B,
    case is_prime(P) of
        true ->
            count(A, B, N+1);
        _ -> N
    end.

% Quick and Dirty prime checker. Not efficient, but we deal with small primes.
is_prime(N) when N < 0 ->
    false;
is_prime(2) -> true;
is_prime(N) ->
    N rem 2 =/= 0 andalso is_prime(N, 3, math:sqrt(N)).

is_prime(_, Div, Sqrt) when Div > Sqrt ->
    true;
is_prime(N, Div, Sqrt) ->
    case N rem Div =:= 0 of
        true -> false;
        _ -> is_prime(N, Div + 2, Sqrt)
    end.
