%% Runs the program and prints command line arguement
:- use_module(library(clpfd)).

q(D1, D2) :-
    D1 in 0..1000, D2 in 0..1000