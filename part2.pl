% "Learn Prolog Now!"  Exercise 2.3
:- use_module(library(clpfd)).

sentence(D1, Type, Op, Total)  --> find, a, set, of, digit(D1), type(Type), integers, that, oper(Op), to, digit(Total).
sentence(D1, Type1, D2, Type2, Op, Total)  --> find, a, set, of, digit(D1), type(Type1), and, digit(D2), type(Type2), integers, that, oper(Op), to, digit(Total).

digit(D) --> 
    [A], { number_string(D, A) }.

type(even) --> ["even"].
type(odd) --> ["odd"].
type(both) --> ["both"].
oper(sum) --> ["sum"].
oper(multiply) --> ["multiply"].

find --> ["find"].
a --> ["a"].
set --> ["set"].
of --> ["of"].
integers --> ["integers"].
and --> ["and"].
that --> ["that"].
to --> ["to"].


% Get vars. current, total, list
add_vars(C, N, L) :-
    ( C =@= 0 ->
        format('l is empty list\n'),
        L = [],
        format('assigned L\n'),
        write(L), nl,
        add_vars(C + 1, N, L)
    ; C >= N -> 
        format('end of recursion\n')
    ;   
        format('normal step\n'),
        append(L, A, L),
        write(L),
        add_vars(C + 1, N, L)

    ).

% Handle case 1
compute(D1, Type, Oper, Total) :-

    (   Type =@= odd ->
        format('type is odd\n')
    ;   Type =@= even ->
        format('type is even\n')
    ;   format('type is both\n')
    ),

    S = [],
    get_sum(Total, Evens, S, D1),
    format('finish function\n').


compute(D1, Type1, D2, Type2, Oper, Total) :-
    format('word\n'),
    fail.

main(W) :-
    
    % get first value from list
    nth0(0, W, A),
    split_string(A, " ", "", L1),

    format('before sentence\n'),
    write(L1), nl,
    % Parse values from the sentence
    ( 
        sentence(D1, Type, Op, Total, L1, []) ->
        format('sentence type 1\n'),
        format('~d\n', D1),
        format('~s\n', Type),
        format('~s\n', Op),
        format('~d\n', Total)
    ;   
        sentence(D1, Type1, D2, Type2, Op, Total, L1, []) ->
        format('sentence type 2\n'),
        format('~d\n', D1),
        format('~s\n', Type1),
        format('~d\n', D2),
        format('~s\n', Type2),
        format('~s\n', Op),
        format('~d\n', Total)
    ;   format('invalid sentence\n')
    ).

%% Common constraints
even([]).
even([X|Xs]) :-
    X mod 2 #= 0,
    even(Xs).

odd([]).
odd([X|Xs]) :-
    X mod 2 #= 1,
    odd(Xs).

range([]).
range([X|Xs]) :-
    between(0,128,X),
    range(Xs).

%% product([], [], Product, Total) :-
%%     Product =:= Total.
%% product([], [Y|Ys], Product, Total) :-
%%     product([], Ys, Y * Product, Total).
%% product([X|Xs], Y, Product, Total) :-
%%     product(Xs, Y, X * Product, Total).


product([], Product, Total) :-
    Product =:= Total.
product([X|Xs], Product, Total) :-
    product(Xs, X * Product, Total).

%%% Operation functions

% One set

% Sum even
sumEven(X, D1, Total) :-
    length(X, D1),
    range(X),
    even(X),
    all_different(X),
    sum(X, #=, Total).

% Sum odd
sumOdd(X, D1, Total) :-
    length(X, D1),
    range(X),
    odd(X),
    all_different(X),
    sum(X, #=, Total).

% Sum both
sumBoth(X, D1, Total) :-
    length(X, D1),
    range(X),
    all_different(X),
    sum(X, #=, Total).

% Product even
productEven(X, D1, Total) :-
    length(X, D1),
    range(X),
    even(X),
    all_different(X),
    product(X, 1, Total).

% Product odd
productOdd(X, D1, Total) :-
    length(X, D1),
    range(X),
    odd(X),
    all_different(X),
    product(X, 1, Total).

% Product both
productBoth(X, D1, Total) :-
    length(X, D1),
    range(X),
    all_different(X),
    product(X, 1, Total).

%% Two sets

% Sum even odd
sumEvenOdd(X, Deven, Dodd, Total) :-
    length(X1, Deven),
    length(X2, Dodd),
    even(X1),
    odd(X2),
    append(X1, X2, X),
    range(X),
    all_different(X),
    sum(X, #=, Total).

% Sum even even
sumEvenEven(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X),
    even(X),
    all_different(X),
    sum(X, #=, Total).

% Sum odd odd
sumOddOdd(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X),
    odd(X),
    all_different(X),
    sum(X, #=, Total).

% Sum even odd
productEvenOdd(X, Deven, Dodd, Total) :-
    length(X1, Deven),
    length(X2, Dodd),
    even(X1),
    odd(X2),
    append(X1, X2, X),
    range(X),
    all_different(X),
    product(X, 1, Total).

% Sum even even
productEvenEven(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X),
    even(X),
    all_different(X),
    product(X, 1, Total).

% Sum odd odd
productOddOdd(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X),
    odd(X),
    all_different(X),
    product(X, 1, Total).