:- dynamic symptom/1, not_symptom/1.

diagnose :-
    write('Does patient have the following: '), nl,
    diseases(Dis), possible_disease(Dis, Desc),
    write('The patient may have the following illnesses:'), nl,
    write(Desc).

check_symptom(Symp) :-
    (symptom(Symp) -> true ; (not_symptom(Symp) -> fail ; query(Symp))). 

query(Symp) :-
    possible_symptoms(Symp, Desc),
    write(Desc),
    write('? '),
    read(Ans), nl,
    add_symptom(Symp, Ans), fail.

add_symptom(Symp, Ans) :-
    (  Ans = y -> Fact =.. [symptom, Symp] ;
    \+ Ans = y -> Fact =.. [not_symptom, Symp]),
    assertz(Fact).

diseases(acute_respiratory_infection).
diseases(pneumonia).
/*
diseases(bronchitis).
diseases(hypertension).
diseases(acute_watery_diarrhea).
diseases(influenza).
diseases(uti).
diseases(tb).
diseases(injury).
diseases(heart_disease).
*/
diseases(none).

possible_symptoms(fever, 'Fever').
possible_symptoms(fatigue, 'Fatigue').
possible_symptoms(headache, 'Headache').
possible_symptoms(swallow, 'Having a hard time swallowing').
possible_symptoms(wheezing, 'Wheezing when breathing').
possible_symptoms(coughing, 'Coughing').
possible_symptoms(breathing, 'Difficulty breathing').
possible_symptoms(heartbeat, 'Rapid Heartbeat').
possible_symptoms(shivering, 'Shivering').
possible_symptoms(appetite, 'Lost of appetite').
possible_symptoms(chest_pain, 'Chest pains').

possible_disease(acute_respiratory_infection, 'Acute Respiratory Infection') :-
                 acute_respiratory_infection.
possible_disease(pneumonia, 'Pneumonia') :-
                 pneumonia, !.
possible_disease(none, 'None').

acute_respiratory_infection :-
    check_symptom(fever), 
    check_symptom(fatigue),
    check_symptom(headache),
    check_symptom(swallow),
    check_symptom(wheezing).

pneumonia :-
    check_symptom(fever), 
    check_symptom(breathing),
    check_symptom(heartbeat),
    check_symptom(shivering),
    check_symptom(appetite),
    check_symptom(chest_pain).

undo :- retract(symptom(_)),fail.
undo :- retract(not_symptom(_)),fail.
undo.

    




