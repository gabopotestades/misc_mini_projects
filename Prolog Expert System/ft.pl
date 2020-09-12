father(C):-
male(F), parent(F, C), write(F), nl.

mother(C):-
female(M), parent(M, C), write(M), nl.

husband(G):-
male(B), spouse(G , B), write(B), nl.

wife(B):-
female(G), spouse(G , B), write(G), nl.

sibling(C):-
male(F), female(M),
parent(F, C), parent(M, C),
parent(F, S), parent(M, S), \+ C = S,
write(S), nl.

child(P):-
parent(P, C),
write(C), nl.

sister(S, C):-
male(F), female(M),
parent(F, C), parent(M, C),
parent(F, S), parent(M, S), female(S), \+ C = S.

brother(B, C):-
male(F), female(M),
parent(F, C), parent(M, C),
parent(F, B), parent(M, B), male(B), \+ C = B.

uncle(C):-
brother(U, D),
parent(D, C), \+ U = D,
write(U), nl.

aunt(C):-
sister(U, D),
parent(D, C), \+ U = D,
write(U), nl.

grandfather(C):-
male(G),
parent(G, P), parent(P, C), 
write(G), nl.

grandmother(C):-
female(G),
parent(G, P), parent(P, C), 
write(G), nl.

sister_in_law(C):-
(spouse(C, S) ; spouse(S, C)),
sister(SL, S),
write(SL), nl.

brother_in_law(C):-
(spouse(C, S) ; spouse(S, C)),
brother(BL, S),
write(BL), nl.

stepmother(C):-
spouse(M, F), parent(F, C), male(F),
\+ parent(M, C), write(M), nl.

ancestor(A, C):- parent(A, C).
ancestor(A, C):- parent(P, C), ancestor(A, P).

descendant(C, D) :- parent(D, C).
descendant(C, D) :- parent(A, C), descendant(A, D).

/*Stark Males*/
male(rickard).
male(eddard).
male(benjen).
male(brandon).
male(robb).
male(bran).
male(rickon).
/*Targaryen Males*/
male(aerys).
male(jon).
male(rhaegar).
male(viserys).
male(aegon).

/*Stark Females*/
female(catelyn).
female(lyanna).
female(sansa).
female(arya).
female(lyarra).
/*Targaryen Females*/
female(daenerys).
female(rhaella).
female(elia).
female(rhaenys).

/*Stark Parents*/
parent(rickard, eddard).
parent(rickard, benjen).
parent(rickard, lyanna).
parent(rickard, brandon).
parent(lyarra, eddard).
parent(lyarra, benjen).
parent(lyarra, lyanna).
parent(lyarra, brandon).

parent(eddard, robb).
parent(eddard, bran).
parent(eddard, sansa).
parent(eddard, arya).
parent(eddard, rickon).
parent(catelyn, robb).
parent(catelyn, bran).
parent(catelyn, sansa).
parent(catelyn, arya).
parent(catelyn, rickon).

/*Targaryen Parents*/
parent(aerys, rhaegar).
parent(aerys, viserys).
parent(aerys, daenerys).
parent(rhaella, rhaegar).
parent(rhaella, viserys).
parent(rhaella, daenerys).
parent(rhaegar, rhaenys).
parent(rhaegar, aegon).
parent(elia, rhaenys).
parent(elia, aegon).

/*Stark-Targaryen Parents*/
parent(rhaegar, jon).
parent(lyanna, jon).

/*Stark Couples*/
spouse(catelyn, eddard).

/*Targaryen Couples*/
spouse(rhaella, aerys).
spouse(elia, rhaegar).

/*Stark-Targaryen Couples*/
spouse(lyanna, rhaegar).