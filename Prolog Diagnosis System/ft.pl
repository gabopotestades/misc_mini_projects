siblings(C):-
male(F), female(M),
parent(F, C), parent(M, C),
parent(F, S), parent(M, S), \+ C = S,
write(S), nl.

sister(C):-
male(F), female(M),
parent(F, C), parent(M, C),
parent(F, S), parent(M, S), female(S), \+ C = S,
write(S), nl.

brother(C):-
male(F), female(M),
parent(F, C), parent(M, C),
parent(F, S), parent(M, S), male(S), \+ C = S,
write(S), nl.

uncle(C):-
male(U),
parent(F, U),
parent(F, D),
parent(D, C), \+ U = D,
write(U), nl.

aunt(C):-
female(U),
parent(F, U),
parent(F, D),
parent(D, C), \+ U = D,
write(U), nl.

father(C):-
male(F), parent(F, C), write(F), nl.

mother(C):-
female(M), parent(M, C), write(M), nl.

husband(G):-
male(B), spouse(G , B), write(B), nl.

wife(B):-
female(G), spouse(B , G), write(G), nl.

/*Stark Males*/
male(rickard).
male(eddard).
male(robb).
male(brandon).
/*Targaryen Males*/
male(aerys).
male(jon).
male(rhaegar).
male(viserys).

/*Stark Females*/
female(catelyn).
female(lyanna).
female(sansa).
female(arya).
female(lyarra).
/*Targaryen Females*/
female(daenerys).
female(rhaella).

/*Stark Parents*/
parent(rickard, eddard).
parent(rickard, lyanna).
parent(lyarra, eddard).
parent(lyarra, lyanna).

parent(eddard, robb).
parent(eddard, brandon).
parent(eddard, sansa).
parent(eddard, arya).
parent(catelyn, robb).
parent(catelyn, brandon).
parent(catelyn, sansa).
parent(catelyn, arya).

/*Targaryen Parents*/
parent(aerys, rhaegar).
parent(aerys, viserys).
parent(aerys, daenerys).
parent(rhaella, rhaegar).
parent(rhaella, viserys).
parent(rhaella, daenerys).

/*Stark-Targaryen Parents*/
parent(rhaegar, jon).
parent(lyanna, jon).

/*Stark Couples*/
spouse(catelyn, eddard).

/*Targaryen Couples*/
spouse(daenerys, jon).
spouse(rhaella, rhaegar).