:- dynamic possible_disease/2, symptom/1, not_symptom/1, info/2.

/* Foot to inches = x12 e.g. 5.5ft = 66in - For guide only  bmi(150, 65) 5'5*/
/*Check if underweight*/
bmi(Weight, Height) :-
    BMI is (Weight * 703) / (Height * Height),
    (
    (BMI < 18.5 -> BMI_var = underweight);
    (BMI >= 18.5 , BMI < 25 -> BMI_var = normal);
    (BMI >= 25 , BMI < 30  -> BMI_var = overweight);
    (BMI >= 30 -> BMI_var = obese)
    ), assert(info(bmi, BMI_var)).

/*Used to tally score*/
add_score_symp(Input, Output) :-
    Output = Input + 2.

/*Ask general questions of patient's background*/
gen_info :-
    write('General information: '), nl,
    write('Name: '),
    read(Name), assert(info(name, Name)), nl,
    write('Sex: '),
    read(Sex), assert(info(sex, Sex)), nl,

    write('Age: '),
    read(Age),
    (
        (Age < 1 -> Age_var = infant);
        (Age > 0 , Age < 11 -> Age_var = child);
        (Age > 11 , Age < 18  -> Age_var = teen);
        (Age > 17 , Age < 65  -> Age_var = adult);
        (Age > 65 -> Age_var = elder)
    ), 
    assert(info(age, Age)),
    assert(info(age_group, Age_var)), nl,

    write('Weight (lb): '),
    read(Weight),assert(info(weight, Weight)), nl,
    write('Height (in): '),
    read(Height),assert(info(height, Height)), nl,
    bmi(Weight, Height).

/* Diagnose patient starting with chief complaint*/
diagnose :-
    % gen_info,
    write('Chief complaint (y/n): '), nl, 
    chief_complaint(Comp, _),
    chief_complaint_query(Comp),
    write('Does patient have the following symptoms (y/n): '), nl, 
    possible_disease(Dis, _),
    disease(Dis, Desc, 0),
    write('The patient may have the following illness:'), nl,
    write(Desc).

check_symptom(Symp) :-
    (symptom(Symp) -> true ; (not_symptom(Symp) -> true ; query(Symp))).

chief_complaint_query(Symp) :-
    chief_complaint(Symp, Desc),
    write(Desc),
    write('? '),
    read(Ans), nl  ,
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
    ((Ans == y ->  assert(symptom(Symp))) ;
    assert(not_symptom(Symp)), Symp == daytime -> fail).

chief_complaint(fatigue, 'Fatigue').
chief_complaint(coughing, 'Coughing').
chief_complaint(fever, 'Fever').
chief_complaint(breathing, 'Difficulty breathing').
chief_complaint(chest_pain, 'Chest pains').
chief_complaint(wheezing, 'Wheezing').

possible_disease(bronchitis, 0).
possible_disease(tuberculosis, 0).
possible_disease(acute_respiratory_infection, 0).
possible_disease(pneumonia, 0).
possible_disease(asthma, 0).
possible_disease(cardiomyopathy, 0).
possible_disease(influenza, 0).
possible_disease(pneumoconiosis, 0).
possible_disease(cystic_fibrosis, 0).
possible_disease(sleep_apnea, 0).
possible_disease(none, 0).

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

disease(bronchitis, 'Bronchitis', Score) :-
                bronchitis(Score).
disease(tuberculosis, 'Tuberculosis', Score) :-
                tuberculosis(Score).
disease(acute_respiratory_infection, 'Acute Respiratory Infection', Score) :-
                acute_respiratory_infection(Score).
disease(pneumonia, 'Pneumonia', Score) :-
                pneumonia(Score).
disease(influenza, 'Influenza', Score) :-
                influenza(Score).
disease(asthma, 'Asthma', Score) :-
                asthma(Score).
disease(cystic_fibrosis, 'Cystic Fibrosis', Score) :-
                cystic_fibrosis(Score).
disease(cardiomyopathy, 'Cardiomyopathy', Score) :-
                cardiomyopathy(Score).
disease(pneumoconiosis, 'Pneumoconiosis', Score) :-
                pneumoconiosis(Score).
disease(sleep_apnea, 'Obstructive Sleep Apnea', Score) :-
                sleep_apnea(Score) ; true.
disease(none, 'No serious illness.', 0).

bronchitis(Score) :-
/*
    symptom(fatigue),
    symptom(coughing),
    symptom(fever),
    symptom(breathing),
*/
    (
        (symptom(fatigue) , symptom(coughing) -> true) ;
        (symptom(fatigue) , symptom(fever) -> true) ;
        (symptom(fatigue) , symptom(breathing) -> true) ;
        (symptom(coughing) , symptom(fever) -> true) ;
        (symptom(coughing) , symptom(breathing) -> true) ;
        (symptom(fever) , symptom(breathing) -> true)
    ) , write(Score), nl,
    (
        symptom(chest_pain); 
        symptom(wheezing); 
        check_symptom(mucus)
    ), fail.
    
tuberculosis(Score) :-
/*
    symptom(fatigue), 
    symptom(coughing),
    symptom(fever), 
    not_symptom(breathing),
    symptom(chest_pain), 
    not_symptom(wheezing)
*/
    (
        (symptom(fatigue) , symptom(coughing) -> true) ;
        (symptom(fatigue) , symptom(fever) -> true) ;
        (symptom(fatigue) , symptom(chest_pain) -> true) ;
        (symptom(coughing) , symptom(fever) -> true) ;
        (symptom(coughing) , symptom(chest_pain) -> true) ;
        (symptom(fever) , symptom(chest_pain) -> true)
    ), write(Score), nl,
    (
        check_symptom(appetite); 
        check_symptom(night_sweats); 
        check_symptom(weight_loss)
    ), fail.

acute_respiratory_infection(Score) :-
/*
    symptom(fatigue), 
    not_symptom(coughing),
    symptom(fever),
    not_symptom(breathing), 
    not_symptom(chest_pain),
    symptom(wheezing),
*/  
    (
        (symptom(fatigue) , symptom(fever) -> true) ;
        (symptom(fatigue) , symptom(wheezing) -> true) ;
        (symptom(fever) , symptom(wheezing))
    ) , write(Score), nl,
    (
        check_symptom(headache); 
        check_symptom(swallow)
    ), fail.

pneumonia(Score) :-
/*
    not_symptom(fatigue), 
    not_symptom(coughing),
    symptom(fever), 
    symptom(breathing),
    symptom(chest_pain), 
    not_symptom(wheezing), 
*/
    (
        (symptom(fever) , symptom(breathing) -> true) ;
        (symptom(fever) , symptom(chest_pain) -> true) ;
        (symptom(breathing) , symptom(chest_pain))
    ) , write(Score), nl,
    (
        check_symptom(heartbeat); 
        check_symptom(shivering); 
        check_symptom(appetite)
    ), fail.

asthma(Score) :-
/*
    not_symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    symptom(breathing),
    not_symptom(chest_pain),
    symptom(wheezing), 
*/
    (
        (symptom(coughing) , symptom(breathing) -> true) ;
        (symptom(coughing) , symptom(wheezing) -> true) ;
        (symptom(breathing) , symptom(wheezing))
    ) , write(Score), nl,
    (
        check_symptom(chest_tightening); 
        check_symptom(short_breathing)
    ), fail.

cardiomyopathy(Score) :-
/*
    symptom(fatigue),
    not_symptom(coughing),
    not_symptom(fever),
    symptom(breathing),
    symptom(chest_pain),
    not_symptom(wheezing),
*/
    (
        (symptom(fatigue) , symptom(breathing) -> true) ;
        (symptom(fatigue) , symptom(chest_pain) -> true) ;
        (symptom(breathing) , symptom(chest_pain))
    ) , write(Score), nl,
    (
        check_symptom(fainting); 
        check_symptom(lightheadedness)
    ), fail.

influenza(Score) :-
/*
    symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    not_symptom(wheezing),
*/
    symptom(fatigue), symptom(coughing), Score = 6, write(Score), nl,
    (
        check_symptom(headache); 
        check_symptom(runny_nose); 
        check_symptom(throat); 
        check_symptom(muscle_pain)
    ), fail.

pneumoconiosis(Score) :-
/*
    symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    not_symptom(wheezing),
*/
    symptom(fatigue), symptom(coughing), Score = 7, write(Score), nl,
    (
        check_symptom(runny_nose); 
        check_symptom(short_breathing); 
        check_symptom(chest_tightening)
    ), fail.

cystic_fibrosis(Score) :-
/*
    not_symptom(fatigue),
    symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    symptom(wheezing),
*/
    symptom(coughing), symptom(wheezing), Score = 8, write(Score), nl,
    (
        check_symptom(short_breathing); 
        check_symptom(poor_growth); 
        check_symptom(salt_tasting)
    ), fail.

sleep_apnea(Score) :-
/*
    symptom(fatigue),
    not_symptom(coughing),
    not_symptom(fever),
    not_symptom(breathing),
    not_symptom(chest_pain),
    not_symptom(wheezing),
*/
    symptom(fatigue), check_symptom(daytime), Score = 9, write(Score), nl,
    ( 
        check_symptom(headache); 
        check_symptom(throat);  
        check_symptom(snoring);  
        check_symptom(reduced)
    ), fail.

undo :- retract(symptom(_)),fail.
undo :- retract(not_symptom(_)),fail.
undo :- retract(info(_, _)),fail.
undo.