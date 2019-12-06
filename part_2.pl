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

find --> ["find"] | ["Find"].
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

    % Parse values from the sentence
    ( 
        sentence(D1, Type, Op, Total, L1, []) ->

        % Handle different cases and call proper functions
        % Type is odd
        (   Type =@= odd ->
            (   Op =@= sum ->
                (   sumOdd(D1, Total) ;
                    format('No Solution\n')
                )
            ;   Op =@= multiply ->
                (   productOdd(D1, Total) ;
                    format('No Solution\n')
                )
            ;   format('invalid operation\n')
            )

            % Type is even
        ;   Type =@= even ->
            (   Op =@= sum ->
                (   sumEven(D1, Total) ;
                    format('No Solution\n')
                )
            ;   Op =@= multiply ->
                (   productEven(D1, Total) ;
                    format('No Solution\n')
                )
            ;   format('invalid operation\n')
            )

            % Type is both
        ;   format('type is both\n'),
            (   Op =@= sum ->
                (   sumBoth(D1, Type) ;
                    format('No Solution\n')
                )
            ;   Op =@= multiply ->
                (   productBoth(D1, Type) ;
                    format('No Solution\n')
                )
            ;   format('invalid operation\n')
            )
        )

    ;   % Sentence type two
        sentence(D1, Type1, D2, Type2, Op, Total, L1, []) ->

        % Handle different cases and call proper functions
        % Types are even and odd
        (   Type1 =@= even, Type2 =@= odd ->
            handleEvenOdd(D1, D2, Op, Total)
        
        ;   Type1 =@= odd, Type2 =@= even ->
            handleEvenOdd(D2, D1, Op, Total)

            % Types are both even
        ;   Type1 =@= even, Type2 =@= even ->
            handleEvenEven(D1, D2, Op, Total)

            % Types are both odd
        ;   Type1 =@= odd, Type2 =@= odd ->
            handleOddOdd(D1, D2, Op, Total)

            % Type is both both
        ;   Type1 =@= both, Type2 =@= both ->
            handleBothBoth(D1, D2, Op, Total)

            % Type is even & both
        ;   Type1 =@= even, Type2 =@= both ->
            handleEvenBoth(D1, D2, Op, Total)

        ;   Type1 =@= both, Type2 =@= even ->
            handleEvenBoth(D2, D1, Op, Total)

            % Type is odd & both
        ;   Type1 =@= odd, Type2 =@= both ->
            handleOddBoth(D1, D2, Op, Total)
        
        ;   Type1 =@= both, Type2 =@= odd ->
            handleOddBoth(D2, D1, Op, Total)
        )

    ;   format('Invalid String\n')
    ).

% Handler functions dispatch to the proper computation functions
handleEvenOdd(Deven, Dodd, Op, Total) :-
    (   Op =@= sum ->
        (   sumEvenOdd(Deven, Dodd, Total) ;
            format('No Solution\n')
        )
    ;   Op =@= multiply ->
        (   productEvenOdd(Deven, Dodd, Total) ;
            format('No Solution\n')
        )
    ;   format('invalid operation\n'),
        fail
    ).

handleEvenEven(D1, D2, Op, Total) :-
    (   Op =@= sum ->
        (   sumEvenEven(D1, D2, Total) ;
            format('No Solution\n')
        )
    ;   Op =@= multiply ->
        (   productEvenEven(D1, D2, Total) ;
            format('No Solution\n')
        )
    ;   format('invalid operation\n'),
        fail
    ).

handleOddOdd(D1, D2, Op, Total) :-
    (   Op =@= sum ->
        (   sumOddOdd(D1, D2, Total) ;
            format('No Solution\n')
        )
    ;   Op =@= multiply ->
        (   productOddOdd(D1, D2, Total) ;
            format('No Solution\n')
        )
    ;   format('invalid operation\n'),
        fail
    ).

handleBothBoth(D1, D2, Op, Total) :-
    (   Op =@= sum ->
        (   sumBothBoth(D1, D2, Total) ;
            format('No Solution\n')
        )
    ;   Op =@= multiply ->
        (   productBothBoth(D1, D2, Total) ;
            format('No Solution\n')
        )
    ;   format('invalid operation\n'),
        fail
    ).

handleEvenBoth(Deven, Dboth, Op, Total) :-
    (   Op =@= sum ->
        (   sumBothBoth(Deven, Dboth, Total) ;
            format('No Solution\n')
        )
    ;   Op =@= multiply ->
        (   productBothBoth(Deven, Dboth, Total) ;
            format('No Solution\n')
        )
    ;   format('invalid operation\n'),
        fail
    ).

handleOddBoth(Dodd, Dboth, Op, Total) :-
    (   Op =@= sum ->
        (   sumOddBoth(Dodd, Dboth, Total) ;
            format('No Solution\n')
        )
    ;   Op =@= multiply ->
        (   productOddBoth(Dodd, Dboth, Total) ;
            format('No Solution\n')
        )
    ;   format('invalid operation\n'),
        fail
    ).


%% Common constraints

% All items in list must be even
even([]).
even([X|Xs]) :-
    X mod 2 #= 0,
    even(Xs).

% All items in list must be odd
odd([]).
odd([X|Xs]) :-
    X mod 2 #= 1,
    odd(Xs).

% All items in list must be 0..Total, 0..128
range([], _).
range([X|Xs], Total) :-
    between(0,Total,X),
    between(0,128,X),
    range(Xs, Total).

% All items in list must sum to Total
mySum([], Sum, Total) :-
    Sum =:= Total.
mySum([X|Xs], Sum, Total) :-
    Sum =< Total,
    mySum(Xs, X + Sum, Total).

% All items in list must multiply to Total
product([], Product, Total) :-
    Product =:= Total.
product([X|Xs], Product, Total) :-
    Product =< Total,
    product(Xs, X * Product, Total).

%%% Operation functions

% One set

% Sum even
sumEven(D1, Total) :-
    length(X, D1),
    range(X, Total),
    even(X),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Sum odd
sumOdd(D1, Total) :-
    length(X, D1),
    range(X, Total),
    odd(X),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Sum both
sumBoth(D1, Total) :-
    length(X, D1),
    range(X, Total),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Product even
productEven(D1, Total) :-
    length(X, D1),
    range(X, Total),
    even(X),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

% Product odd
productOdd(D1, Total) :-
    length(X, D1),
    range(X, Total),
    odd(X),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

% Product both
productBoth(D1, Total) :-
    length(X, D1),
    range(X, Total),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

%% Two sets

% Sum even odd
sumEvenOdd(Deven, Dodd, Total) :-
    length(X1, Deven),
    length(X2, Dodd),
    even(X1),
    odd(X2),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Sum even even
sumEvenEven(D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    even(X),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Sum odd odd
sumOddOdd(D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    odd(X),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Sum even both
sumEvenBoth(Deven, Dboth, Total) :-
    length(X1, Deven),
    length(X2, Dboth),
    even(X1),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Sum odd both
sumOddBoth(Dodd, Dboth, Total) :-
    length(X1, Dodd),
    length(X2, Dboth),
    odd(X1),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Sum both both
sumBothBoth(D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    all_different(X),
    mySum(X, 0, Total),
    writeVals(X).

% Product even odd
productEvenOdd(Deven, Dodd, Total) :-
    length(X1, Deven),
    length(X2, Dodd),
    even(X1),
    odd(X2),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

% Product even even
productEvenEven(D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    even(X),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

% Product odd odd
productOddOdd(D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    odd(X),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

% Product even both
productEvenBoth(Deven, Dboth, Total) :-
    length(X1, Deven),
    length(X2, Dboth),
    even(X1),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

% Product even both
productOddBoth(Dodd, Dboth, Total) :-
    length(X1, Dodd),
    length(X2, Dboth),
    odd(X1),
    append(X1, X2, X),
    range(X, Total),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).

% Product both both
productBothBoth(D1, D2, Total) :-
    D3 is D1 + D2,
    length(X, D3),
    range(X, Total),
    all_different(X),
    product(X, 1, Total),
    writeVals(X).


% Formatting functions

writeVals([]) :-
    format('[]').

writeVals([X|Xs]) :-
    write(X),
    writeNextVal(Xs).

writeNextVal([]) :-
    format('\n').

writeNextVal([X|Xs]) :-
    format(','),
    write(X), 
    writeNextVal(Xs).