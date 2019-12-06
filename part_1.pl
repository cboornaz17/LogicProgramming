:- use_module(library(clpfd)).

main :-
	q(D1, D2, D3).

%% The integers 1, 3, 8, and 120 form a set with a remarkable property: the product of any two integers is
%% one less than a perfect square. Find another set containing four unique numbers between 0 and 10000 that
%% also has this property and it contains no numbers from the original set of {1, 3, 8, 120}.
digit(D) :- 
    between(1, 1000, D),
    D #\= 1,
    D #\= 3,
    D #\= 8,
    D #\= 120.

q(D2, D3, D4) :-
    % Get first 2 digits
    digit(D2),
    digit(D3),

    D2 #< D3,
    A is D2 * D3 + 1,
    ASquare is round(sqrt(A)),
    A is ASquare ** 2,
    
    % Get last digit and test
    digit(D4),
    D3 #< D4,
    B is D2 * D4 + 1,
    BSquare is round(sqrt(B)),
    B is BSquare ** 2,

    C is D3 * D4 + 1,
    CSquare is round(sqrt(C)),
    C is CSquare ** 2,


    write(0), format(','),
    write(D2), format(','),
    write(D3), format(','),
    write(D4), format('\n').