:-dynamic(fever/1).
:-dynamic(fatigue/1).
:-dynamic(headache/1).
:-dynamic(swallow/1).
:-dynamic(wheezing/1).
:-dynamic(diagnosis/2).

disease(acute_respiratory_infection,'Acute Respiratory Infection').
disease(pneumonia, 'Pneumonia').
disease(bronchitis, 'Bronchitis').
disease(hypertension, 'Hypertension').
disease(acute_watery_diarrhea, 'Acute Water Diarrhea').
disease(influenza, 'Influenza').
disease(uti, 'Urinary Tract Infection').
disease(tb, 'Tuberculosis').
disease(injury, 'Injury').
disease(heart_disease, 'Heart Disease').

diagnosis(P, acute_respiratory_infection) :-
	fever(P),
	fatigue(P).

bigger(elephant, horse).
bigger(horse, donkey).
bigger(donkey, dog).
bigger(donkey, monkey).

is_bigger(X, Y) :- bigger(X, Y).
is_bigger(X, Y) :- bigger(X, Z), is_bigger(Z, Y).

smaller(tardigrade, cricket).
smaller(cricket, monkey).
smaller(monkey, donkey).
smaller(monkey, panda).
smaller(panda, elephant).

smaller(X, Y) :- bigger(Y, X).

is_smaller(X, Y) :- smaller(X, Y).
is_smaller(X, Y) :- smaller(X, Z), is_smaller(Z, Y).

is_smaller(X, Y) :- is_bigger(Y, X).

male(ned).
male(jon).
female(arya).
female(sansa).
female(catelyn).
female(daenerys).

father(ned, jon).
father(ned, sansa).
father(ned, arya).

mother(catelyn, jon).
mother(catelyn, sansa).
mother(catelyn, arya).

husband(ned, catelyn).
husband(jon, daenerys).

sister_in_law(Y):-
sibling(X, Z), husband(X, Y), female(Z),
write(Z), nl.

siblings(F, M) :-
father(F, C),
mother(M, C),
write(C), nl.