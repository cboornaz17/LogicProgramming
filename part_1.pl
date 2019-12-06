:- use_module(library(clpfd)).

%% Runs the program and prints command line arguement
main :-
	findnsols(1, p(D1, D2, D3), q(D1, D2, D3), D),
    nth0(0, D, Val1),
    nth0(1, D, Val2),
    nth0(2, D, Val3),
    format('0,~d,~d,~d\n', Val1, Val2, Val3).

%% The integers 1, 3, 8, and 120 form a set with a remarkable property: the product of any two integers is
%% one less than a perfect square. Find another set containing four unique numbers between 0 and 10000 that
%% also has this property and it contains no numbers from the original set of {1, 3, 8, 120}.

digit(D) :- 
    D #\= 1,
    D #\= 3,
    D #\= 8,
    D #\= 120,
    between(1, 1000, D).

q(D2, D3, D4) :-
    digit(D2),
    digit(D3),
    digit(D4),

    D2 #> D3,
    D3 #> D4,

    A #= (D2 * D3) + 1,
	member(A, [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961]),
    
    B #= (D2 * D4) + 1,
    member(B, [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961]),
    
    C #= (D3 * D4) + 1,
    member(C, [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961]).
