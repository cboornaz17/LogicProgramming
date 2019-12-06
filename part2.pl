% "Learn Prolog Now!"  Exercise 2.3
:- use_module(library(clpfd)).

sentence(D1, Type, Op, Total)  --> find, a, set, of, digit(D1), type(Type), integers, that, oper(Op), to, digit(Total).
sentence(D1, Type1, D2, Type2, Op, Total)  --> find, a, set, of, digit(D1), type(Type1), and, digit(D2), type(Type2), integers, that, oper(Op), to, digit(Total).

digit(0) --> ["0"].
digit(1) --> ["1"].
digit(2) --> ["2"].
digit(3) --> ["3"].
digit(4) --> ["4"].
digit(5) --> ["5"].
digit(6) --> ["6"].
digit(7) --> ["7"].
digit(8) --> ["8"].
digit(9) --> ["9"].
digit(10) --> ["10"].
digit(11) --> ["11"].
digit(12) --> ["12"].
digit(13) --> ["13"].
digit(14) --> ["14"].
digit(15) --> ["15"].
digit(16) --> ["16"].
digit(17) --> ["17"].
digit(18) --> ["18"].
digit(19) --> ["19"].
digit(20) --> ["20"].
digit(21) --> ["21"].
digit(22) --> ["22"].
digit(23) --> ["23"].
digit(24) --> ["24"].
digit(25) --> ["25"].
digit(26) --> ["26"].
digit(27) --> ["27"].
digit(28) --> ["28"].
digit(29) --> ["29"].
digit(30) --> ["30"].
digit(31) --> ["31"].
digit(32) --> ["32"].
digit(33) --> ["33"].
digit(34) --> ["34"].
digit(35) --> ["35"].
digit(36) --> ["36"].
digit(37) --> ["37"].
digit(38) --> ["38"].
digit(39) --> ["39"].
digit(40) --> ["40"].
digit(41) --> ["41"].
digit(42) --> ["42"].
digit(43) --> ["43"].
digit(44) --> ["44"].
digit(45) --> ["45"].
digit(46) --> ["46"].
digit(47) --> ["47"].
digit(48) --> ["48"].
digit(49) --> ["49"].
digit(50) --> ["50"].
digit(51) --> ["51"].
digit(52) --> ["52"].
digit(53) --> ["53"].
digit(54) --> ["54"].
digit(55) --> ["55"].
digit(56) --> ["56"].
digit(57) --> ["57"].
digit(58) --> ["58"].
digit(59) --> ["59"].
digit(60) --> ["60"].
digit(61) --> ["61"].
digit(62) --> ["62"].
digit(63) --> ["63"].
digit(64) --> ["64"].
digit(65) --> ["65"].
digit(66) --> ["66"].
digit(67) --> ["67"].
digit(68) --> ["68"].
digit(69) --> ["69"].
digit(70) --> ["70"].
digit(71) --> ["71"].
digit(72) --> ["72"].
digit(73) --> ["73"].
digit(74) --> ["74"].
digit(75) --> ["75"].
digit(76) --> ["76"].
digit(77) --> ["77"].
digit(78) --> ["78"].
digit(79) --> ["79"].
digit(80) --> ["80"].
digit(81) --> ["81"].
digit(82) --> ["82"].
digit(83) --> ["83"].
digit(84) --> ["84"].
digit(85) --> ["85"].
digit(86) --> ["86"].
digit(87) --> ["87"].
digit(88) --> ["88"].
digit(89) --> ["89"].
digit(90) --> ["90"].
digit(91) --> ["91"].
digit(92) --> ["92"].
digit(93) --> ["93"].
digit(94) --> ["94"].
digit(95) --> ["95"].
digit(96) --> ["96"].
digit(97) --> ["97"].
digit(98) --> ["98"].
digit(99) --> ["99"].
digit(100) --> ["100"].
digit(101) --> ["101"].
digit(102) --> ["102"].
digit(103) --> ["103"].
digit(104) --> ["104"].
digit(105) --> ["105"].
digit(106) --> ["106"].
digit(107) --> ["107"].
digit(108) --> ["108"].
digit(109) --> ["109"].
digit(110) --> ["110"].
digit(111) --> ["111"].
digit(112) --> ["112"].
digit(113) --> ["113"].
digit(114) --> ["114"].
digit(115) --> ["115"].
digit(116) --> ["116"].
digit(117) --> ["117"].
digit(118) --> ["118"].
digit(119) --> ["119"].
digit(120) --> ["120"].
digit(121) --> ["121"].
digit(122) --> ["122"].
digit(123) --> ["123"].
digit(124) --> ["124"].
digit(125) --> ["125"].
digit(126) --> ["126"].
digit(127) --> ["127"].
digit(128) --> ["128"].

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


compute(D1, Type, Oper, Total) :-
    format('D1 ~d\n', D1),
    fail.

compute(D1, Type1, D2, Type2, Oper, Total) :-
    format('word\n'),
    fail.

main(W) :-
    
    nth0(0, W, A),
    split_string(A, " ", "", L1),

    write(L1), nl,

    sentence(D1, Type, Op, Total, L1, []),

    format('~d\n', D1),
    format('~s\n', Type),
    format('~s\n', Op),
    format('~d\n', Total).

    %% nth0(0, W, A),
    %% format('A ~s\n', A),

    %% atom_string(A, S),
    %% format('S ~s\n', S),

    %% split_string(S, " ", "", L1),
    %% write(L1).

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
    0 #=< X,
    X #=< 128,
    range(Xs).

product([X|Xs], Product, Total) :-
    Temp = X * Product,
    product([Xs], Temp, Total).
product(X, Product, Total) :-
    Temp = X * Product,
    Temp #= Total.

%% Operation functions

% Sum even
sumEven(X, D1, Total) :-
    length(X, D1),
    range(X),
    even(X),
    all_different(X),
    sum(X, #=, Total).

sumEvenOut(X, D1, Total) :-
    findall(A, sumEven(A, D1, Total), X),
    term_variables(X, Vars),
    labeling([enum, ff], Vars),
    write(Vars), nl.

% Sum odd
sumOdd(X, D1, Total) :-
    length(X, D1),
    range(X),
    odd(X),
    all_different(X),
    sum(X, #=, Total).

sumOddOut(X, D1, Total) :-
    findall(A, sumOdd(A, D1, Total), X),
    term_variables(X, Vars),
    labeling([enum, ff], Vars),
    write(Vars), nl.

% Sum both
sumBoth(X, D1, Total) :-
    length(X, D1),
    range(X),
    all_different(X),
    sum(X, #=, Total).

sumBothOut(X, D1, Total) :-
    findall(A, sumBoth(A, D1, Total), X),
    term_variables(X, Vars),
    labeling([enum, ff], Vars),
    write(Vars), nl.

% Product even
productEven(X, D1, Total) :-
    length(X, D1),
    range(X),
    even(X),
    all_different(X),
    product(X, 1, Total).

productEvenOut(X, D1, Total) :-
    findall(A, productEven(A, D1, Total), X),
    term_variables(X, Vars),
    labeling([enum, ff], Vars),
    write(Vars), nl.
