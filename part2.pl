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

% swipl -q -f part2.pl -t main "find a set of 3 odd integers that sum to 8"
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
        format('~d\n', Total),

        % Handle different cases and call proper functions
        % Type is odd
        (   Type =@= odd ->
            format('type is odd\n'),
            (   Op =@= sum ->
                format('sum odd\n'),
                sumOdd(X, D1, Total)
            ;   Op =@= multiply ->
                format('multiply odd\n'),
                productOdd(X, D1, Total)
            ;   format('invalid operation\n')
            )

            % Type is even
        ;   Type =@= even ->
            format('type is even\n'),
            (   Op =@= sum ->
                format('sum even\n'),
                sumEven(X, D1, Total)
            ;   Op =@= multiply ->
                format('multiply even\n'),
                productEven(X, D1, Total)
            ;   format('invalid operation\n')
            )

            % Type is both
        ;   format('type is both\n'),
            (   Op =@= sum ->
                format('sum both\n'),
                sumBoth(X, D1, Type)
            ;   Op =@= multiply ->
                format('multiply both\n'),
                productBoth(X, D1, Type)
            ;   format('invalid operation\n')
            )
        )

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

range([], Total).
range([X|Xs], Total) :-
    between(0,Total,X),
    between(0,128,X),
    range(Xs, Total).

sum([], Sum, Total) :-
    Sum =:= Total.
sum([X|Xs], Sum, Total) :-
    Sum =< Total,
    sum(Xs, X + Sum, Total).

product([], Product, Total) :-
    Product =:= Total.
product([X|Xs], Product, Total) :-
    Product =< Total,
    product(Xs, X * Product, Total).

%%% Operation functions

% One set

% Sum even
sumEven(X, D1, Total) :-
    length(X, D1),
    range(X, Total),
    even(X),
    all_different(X),
    sum(X, 0, Total),
    write(X), nl.

% Sum odd
sumOdd(X, D1, Total) :-
    length(X, D1),
    range(X, Total),
    odd(X),
    all_different(X),
    sum(X, 0, Total),
    write(X), nl.

% Sum both
sumBoth(X, D1, Total) :-
    length(X, D1),
    range(X, Total),
    all_different(X),
    sum(X, 0, Total),
    write(X), nl.

% Product even
productEven(X, D1, Total) :-
    length(X, D1),
    range(X, Total),
    even(X),
    all_different(X),
    product(X, 1, Total),
    write(X), nl.

% Product odd
productOdd(X, D1, Total) :-
    length(X, D1),
    range(X, Total),
    odd(X),
    all_different(X),
    product(X, 1, Total),
    write(X), nl.

% Product both
productBoth(X, D1, Total) :-
    length(X, D1),
    range(X, Total),
    all_different(X),
    product(X, 1, Total),
    write(X), nl.

%% Two sets

% Sum even odd
sumEvenOdd(X, Deven, Dodd, Total) :-
    length(X1, Deven),
    length(X2, Dodd),
    even(X1),
    odd(X2),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    sum(X, 0, Total),
    write(X), nl.

% Sum even even
sumEvenEven(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    even(X),
    all_different(X),
    sum(X, 0, Total),
    write(X), nl.

% Sum odd odd
sumOddOdd(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    odd(X),
    all_different(X),
    sum(X, 0, Total),
    write(X), nl.

% Sum even odd
productEvenOdd(X, Deven, Dodd, Total) :-
    length(X1, Deven),
    length(X2, Dodd),
    even(X1),
    odd(X2),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    product(X, 1, Total),
    write(X), nl.

% Sum even even
productEvenEven(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    even(X),
    all_different(X),
    product(X, 1, Total),
    write(X), nl.

% Sum odd odd
productOddOdd(X, D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    odd(X),
    all_different(X),
    product(X, 1, Total),
    write(X), nl.
