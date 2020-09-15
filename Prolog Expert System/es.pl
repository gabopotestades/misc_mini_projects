:- dynamic symptom/1, not_symptom/1.

diagnose :-
    write('Does patient have the following symptoms: '), nl, 
    possible_disease(Dis),
    disease(Dis, Desc),
    write('The patient may have the following illnesses:'), nl,
    write(Desc).

check_symptom(Symp) :-
    (symptom(Symp) -> true ; (not_symptom(Symp) -> fail ; query(Symp))). 

query(Symp) :-
    possible_symptoms(Symp, Desc),
    write(Desc),
    write('? '),
    read(Ans), nl,
    add_symptom(Symp, Ans).

add_symptom(Symp, Ans) :-
    (Ans == y ->  assert(symptom(Symp)) ; 
    assert(not_symptom(Symp)), fail).

possible_disease(acute_respiratory_infection).
possible_disease(pneumonia).
possible_disease(bronchitis).
possible_disease(influenza).
possible_disease(uti).
possible_disease(tuberculosis).
possible_disease(diabetes).
/*
possible_disease(acute_watery_diarrhea).
possible_disease(injury).
possible_disease(heart_disease).
*/
possible_disease(none).

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
possible_symptoms(mucus, 'Production of mucus').
possible_symptoms(throat, 'Sore throat').
possible_symptoms(runny_nose, 'Runny nose').
possible_symptoms(muscle_pain, 'Muscle pains').
possible_symptoms(back_pain, 'Back pain').
possible_symptoms(lower_abdominal, 'Lower abdominal pain').
possible_symptoms(burning, 'Burning sensation when urinating').
possible_symptoms(frequent, 'Frequent urination').
possible_symptoms(difficulty_urinating, 'Difficulty urinating').
possible_symptoms(night_sweats, 'Sweating at night').
possible_symptoms(weight_loss, 'Weight loss').
possible_symptoms(excessive_thirst, 'Excessive thirst').
possible_symptoms(excessive_hunger, 'Excessive hunger').
possible_symptoms(blurred_vision, 'Blurred vision').

disease(acute_respiratory_infection, 'Acute Respiratory Infection') :-
                acute_respiratory_infection.
disease(pneumonia, 'Pneumonia') :-
                pneumonia.
disease(bronchitis, 'Bronchitis') :-
                bronchitis.
disease(influenza, 'Influenza') :-
                influenza.
disease(tuberculosis, 'Tuberculosis') :-
                tuberculosis.
disease(uti, 'Urinary Tract Infection') :-
                uti.
disease(diabetes, 'Diabetes') :-
                diabetes, !.
disease(none, 'None').

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

bronchitis :-
    check_symptom(fever), 
    check_symptom(coughing),
    check_symptom(fatigue),
    check_symptom(breathing),
    check_symptom(mucus),
    (check_symptom(wheezing) ; check_symptom(chest_pain)).

influenza :-
    check_symptom(headache), 
    check_symptom(coughing),
    check_symptom(fatigue),
    check_symptom(throat),
    check_symptom(runny_nose),
    check_symptom(muscle_pain).

uti :-
    check_symptom(fever), 
    check_symptom(back_pain),
    check_symptom(lower_abdominal),
    (check_symptom(burning) ; check_symptom(frequent) ; check_symptom(difficulty_urinating)).

tuberculosis :-
    check_symptom(fever),
    check_symptom(coughing),
    check_symptom(fatigue),
    check_symptom(chest_pain),
    check_symptom(night_sweats),
    (check_symptom(appetite) ; check_symptom(weight_loss)).

diabetes :-
    check_symptom(fatigue),
    check_symptom(frequent),
    check_symptom(weight_loss),
    check_symptom(blurred_vision),
    (check_symptom(excessive_thirst) ; check_symptom(excessive_hunger)).

undo :- retract(symptom(_)),fail.
undo :- retract(not_symptom(_)),fail.
undo.