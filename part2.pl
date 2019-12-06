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

    