:- dynamic symptom/1, not_symptom/1.

diagnose :-
    write('Chief complaint: '), nl, 
    chief_complaint(Comp, _),
    chief_complaint_query(Comp),
    write('Does patient have the following symptoms: '), nl, 
    possible_disease(Dis),
    disease(Dis, Desc),
    write('The patient may have the following illness:'), nl,
    write(Desc).

check_symptom(Symp) :-
    (symptom(Symp) -> true ; (not_symptom(Symp) -> fail ; query(Symp))). 

chief_complaint_query(Symp) :-
    chief_complaint(Symp, Desc),
    write(Desc),
    write('? '),
    read(Ans), nl,
    chief_complaint_add_symptom(Symp, Ans).

chief_complaint_add_symptom(Symp, Ans) :-
    (Ans == y -> (assertz(symptom(Symp)) , fail); 
    assertz(not_symptom(Symp)), fail) ; (Symp == wheezing -> true).

query(Symp) :-
    possible_symptoms(Symp, Desc),
    write(Desc),
    write('? '),
    read(Ans), nl,
    add_symptom(Symp, Ans).

add_symptom(Symp, Ans) :-
    (Ans == y ->  assert(symptom(Symp)) ; 
    assert(not_symptom(Symp)), fail).

chief_complaint(fatigue, 'Fatigue').
chief_complaint(coughing, 'Coughing').
chief_complaint(fever, 'Fever').
chief_complaint(breathing, 'Difficulty breathing').
chief_complaint(chest_pain, 'Chest pains').
chief_complaint(wheezing, 'Wheezing').

possible_disease(bronchitis).
possible_disease(tuberculosis).
possible_disease(acute_respiratory_infection).
possible_disease(pneumonia).
possible_disease(asthma).
possible_disease(cardiomyopathy).
possible_disease(influenza).
possible_disease(pneumoconiosis).
possible_disease(cystic_fibrosis).
possible_disease(sleep_apnea).
possible_disease(none).

possible_symptoms(fever, 'Fever').
possible_symptoms(fatigue, 'Fatigue').
possible_symptoms(headache, 'Headache').
possible_symptoms(swallow, 'Having a hard time swallowing').
possible_symptoms(wheezing, 'Wheezing when breathing').
possible_symptoms(coughing, 'Coughing').
possible_symptoms(breathing, 'Difficulty breathing').
possible_symptoms(short_breathing, 'Shortness of breath').
possible_symptoms(heartbeat, 'Rapid Heartbeat').
possible_symptoms(shivering, 'Shivering').
possible_symptoms(appetite, 'Lost of appetite').
possible_symptoms(chest_pain, 'Chest pains').
possible_symptoms(chest_tightening, 'Chest tightening').
possible_symptoms(mucus, 'Production of mucus').
possible_symptoms(throat, 'Sore throat').
possible_symptoms(runny_nose, 'Runny nose').
possible_symptoms(muscle_pain, 'Muscle pains').
possible_symptoms(night_sweats, 'Sweating at night').
possible_symptoms(weight_loss, 'Weight loss').
possible_symptoms(poor_growth, 'Poor growth in spite of good appetite').
possible_symptoms(fainting, 'Fainting').
possible_symptoms(lightheadedness, 'Lightheadedness').
possible_symptoms(daytime, 'Excessive daytime sleepiness').
possible_symptoms(snoring, 'Frequent loud snoring').
possible_symptoms(reduced, 'Reduced or absent breathing during sleep').
possible_symptoms(salt_tasting, 'Salty-tasting skin').

disease(bronchitis, 'Bronchitis') :-
                bronchitis.
disease(tuberculosis, 'Tuberculosis') :-
                tuberculosis.
disease(acute_respiratory_infection, 'Acute Respiratory Infection') :-
                acute_respiratory_infection.
disease(pneumonia, 'Pneumonia') :-
                pneumonia.
disease(influenza, 'Influenza') :-
                influenza.
disease(asthma, 'Asthma') :-
                asthma.
disease(cystic_fibrosis, 'Cystic Fibrosis') :-
                cystic_fibrosis.
disease(cardiomyopathy, 'Cardiomyopathy') :-
                cardiomyopathy.
disease(pneumoconiosis, 'Pneumoconiosis') :-
                pneumoconiosis.
disease(sleep_apnea, 'Obstructive Sleep Apnea') :-
                sleep_apnea, !.
disease(none, 'No serious illness.').

bronchitis :-
/*
    check_symptom(fatigue),
    check_symptom(fever), 
    check_symptom(coughing),
    check_symptom(breathing),
    (check_symptom(wheezing) ; check_symptom(chest_pain)),
    check_symptom(mucus).
*/
    symptom(fatigue),
    symptom(coughing),
    symptom(fever),
    symptom(breathing),
    (symptom(chest_pain) ; symptom(wheezing) ; check_symptom(mucus)).
    
tuberculosis :-
/*
    check_symptom(fatigue),
    check_symptom(fever),
    check_symptom(coughing),
    check_symptom(chest_pain),
    check_symptom(night_sweats),
    (check_symptom(appetite) ; check_symptom(weight_loss)).
*/
    symptom(fatigue), 
    symptom(coughing),
    symptom(fever), 
    not_symptom(breathing),
    symptom(chest_pain), 
    not_symptom(wheezing),
    (check_symptom(night_sweats) ; check_symptom(appetite) ; check_symptom(weight_loss)).

acute_respiratory_infection :-
/*
    check_symptom(fatigue),
    check_symptom(fever), 
    check_symptom(wheezing),
    check_symptom(headache),
    check_symptom(swallow).
*/
    symptom(fatigue), 
    not_symptom(coughing),
    symptom(fever),
    not_symptom(breathing), 
    not_symptom(chest_pain),
    symptom(wheezing),
    (check_symptom(headache) ; check_symptom(swallow)).

pneumonia :-
/*
    check_symptom(fever), 
    check_symptom(breathing),
    check_symptom(chest_pain),
    check_symptom(heartbeat),
    check_symptom(shivering),
    check_symptom(appetite).
*/
    not_symptom(fatigue), 
    not_symptom(coughing),
    symptom(fever), 
    symptom(breathing),
    symptom(chest_pain), 
    not_symptom(wheezing), 
    (check_symptom(heartbeat) ; check_symptom(shivering) ; check_symptom(appetite)).

asthma :-
/*
    check_symptom(coughing), 
    check_symptom(wheezing),
    check_symptom(breathing),
    check_symptom(chest_tightening),
    check_symptom(short_breathing).
*/
    not_symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    symptom(breathing),
    not_symptom(chest_pain),
    symptom(wheezing),
    (check_symptom(chest_tightening) ; check_symptom(short_breathing)).

cardiomyopathy :-
/*
    check_symptom(fatigue),
    check_symptom(breathing),
    check_symptom(chest_pain),
    check_symptom(fainting),
    check_symptom(lightheadedness).

*/
    symptom(fatigue),
    not_symptom(coughing),
    not_symptom(fever),
    symptom(breathing),
    symptom(chest_pain),
    not_symptom(wheezing),
    (check_symptom(fainting) ; check_symptom(lightheadedness)).

influenza :-
/*
    check_symptom(coughing),
    check_symptom(fatigue),
    check_symptom(headache),
    check_symptom(throat),
    check_symptom(runny_nose),
    check_symptom(muscle_pain).
*/
    symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    not_symptom(wheezing), 
    (check_symptom(headache) ; check_symptom(throat) ; 
    check_symptom(runny_nose) ; check_symptom(muscle_pain)).

pneumoconiosis :-
/*
    check_symptom(fatigue),
    check_symptom(coughing),
    check_symptom(short_breathing),
    check_symptom(runny_nose),
    check_symptom(chest_tightening).
*/
    symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    not_symptom(wheezing),
    (check_symptom(short_breathing) ; check_symptom(chest_tightening) ; check_symptom(runny_nose)).

cystic_fibrosis :-
/*
    check_symptom(coughing),
    check_symptom(wheezing),
    check_symptom(short_breathing),
    check_symptom(poor_growth),
    check_symptom(salt_tasting).
*/
    not_symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    symptom(wheezing),
    (check_symptom(short_breathing) ; check_symptom(poor_growth) ; check_symptom(salt_tasting)).

sleep_apnea :-
    not_symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    not_symptom(wheezing),
    (symptom(fatigue) ; check_symptom(daytime)) ;  check_symptom(headache) ; 
    check_symptom(throat) ;  check_symptom(snoring) ;  check_symptom(reduced).

undo :- retract(symptom(_)),fail.
undo :- retract(not_symptom(_)),fail.
undo.