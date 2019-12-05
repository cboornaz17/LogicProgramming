% "Learn Prolog Now!"  Exercise 2.3

sentence(D1, Type, Op, Total)  --> find, a, set, of, digit(D1), type(Type), integers, that, oper(Op), to, digit(Total).
sentence(D1, Type1, D2, Type2, Op, Total)  --> find, a, set, of, digit(D1), type(Type1), and, digit(D2), type(Type2), integers, that, oper(Op), to, digit(Total).

digit(D) :- between(0, 100, D).
type(T) --> [T], ["even"] | ["odd"] | ["both"].
oper(O) --> [O], ["sum"] | ["multiply"].

find --> ["Find"].
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

    %compute(sentence(W)),

    nth0(0, W, A),
    format('A ~s\n', A),

    atom_string(A, S),
    format('S ~s\n', S),

    split_string(S, " ", "", L1),
    write(L1).




word(article,a). 
word(article,every). 
word(noun,criminal). 
word(noun,'big kahuna burger'). 
word(verb,eats). 
word(verb,likes). 

sentence(Word1,Word2,Word3,Word4,Word5):-
	word(article,Word1), 
	word(noun,Word2), 
	word(verb,Word3), 
	word(article,Word4), 
	word(noun,Word5). 

printsentences :-
	sentence(W1,W2,W3,W4,W5),
	write([W1,W2,W3,W4,W5]), nl,
	fail.

allsentences(L):-
	findall([W1,W2,W3,W4,W5],sentence(W1,W2,W3,W4,W5),L).