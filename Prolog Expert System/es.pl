:- dynamic not_symptom/1, symptom/1, info/2.

% Foot to inches = x12 e.g. 5.5ft = 66in - For guide only  bmi(150, 65) 5'5
% Check if underweight
bmi(Weight, Height) :-
    BMI is (Weight * 703) / (Height * Height),
    (
    (BMI < 18.5 -> BMI_var = underweight);
    (BMI >= 18.5 , BMI < 25 -> BMI_var = normal);
    (BMI >= 25 , BMI < 30  -> BMI_var = overweight);
    (BMI >= 30 -> BMI_var = obese)
    ), assert(info(bmi, BMI_var)).

coughing_duration :-
    write('Duration of coughing (in weeks): '),
    read(D), nl,
    assert(info(duration, D)).

% Print Score
print_score(Desc, Score) :-
    (
        (Score = 0 -> Rating = ': none');
        (Score >= 1 , Score < 7 -> Rating = ': low');
        (Score >= 7 , Score < 12  -> Rating = ': moderate');
        (Score >= 12   -> Rating = ': high')
    ), 
    write(Desc), write(Rating), nl.


% Ask general questions of patient's background
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
    bmi(Weight, Height),

    write('Respiratory rate: '),
    read(Resp),assert(info(respiratory_rate, Resp)), nl.

% Diagnose patient starting with chief complaint
diagnose :-
    gen_info,
    write('Chief complaint (y/n): '), nl, 
    chief_complaint(Comp, _),
    chief_complaint_query(Comp),
    ((symptom(coughing) -> coughing_duration) ; true),
    write('Does patient have the following symptoms (y/n): '), nl, 
    possible_disease(Dis, _),
    disease(Dis),
    check_scores,
    undo.

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

check_scores :-
    write('DIAGNOSIS PER DISEASE: '), nl, nl,
    possible_disease(Disease, Desc),
    score(Disease, Desc).

chief_complaint(fatigue, 'Fatigue').
chief_complaint(coughing, 'Coughing').
chief_complaint(fever, 'Fever').
chief_complaint(breathing, 'Difficulty breathing').
chief_complaint(chest_pain, 'Chest pains').
chief_complaint(wheezing, 'Wheezing').

possible_disease(bronchitis, 'Bronchitis').
possible_disease(tuberculosis, 'Tuberculosis').
possible_disease(acute_respiratory_infection, 'Acute Respiratory Infection').
possible_disease(pneumonia, 'Pneumonia').
possible_disease(asthma, 'Asthma').
possible_disease(cardiomyopathy, 'Cardiomyopathy').
possible_disease(influenza, 'Influenza').
possible_disease(pneumoconiosis, 'Pneumoconiosis').
possible_disease(cystic_fibrosis, 'Cystic Fibrosis').
possible_disease(sleep_apnea, 'Sleep Apnea').

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
possible_symptoms(vomitting, 'Vomitting').
possible_symptoms(diarrhea, 'Diarrhea').
possible_symptoms(dust_exposure, 'Dust Exposure').
possible_symptoms(cracking, 'Cracking sound in lungs').

disease(bronchitis) :- bronchitis.
disease(tuberculosis) :- tuberculosis.
disease(acute_respiratory_infection) :- acute_respiratory_infection.
disease(pneumonia) :- pneumonia.
disease(asthma) :- asthma.
disease(cardiomyopathy) :- cardiomyopathy.
disease(influenza) :- influenza.
disease(pneumoconiosis) :- pneumoconiosis.
disease(cystic_fibrosis) :- cystic_fibrosis.
disease(sleep_apnea) :- sleep_apnea ; true.

score(bronchitis, Desc) :- 
    score_bronchitis(Score), print_score(Desc, Score), fail.

score(tuberculosis, Desc) :-
     score_tuberculosis(Score), print_score(Desc, Score), fail.

score(acute_respiratory_infection, Desc) :-
     score_acute_respiratory_infection(Score),  print_score(Desc, Score), fail.
    
score(pneumonia, Desc) :-
     score_pneumonia(Score), print_score(Desc, Score), fail.
    
score(asthma, Desc) :-
     score_asthma(Score), print_score(Desc, Score), fail.
    
score(cardiomyopathy, Desc) :-
     score_cardiomyopathy(Score), print_score(Desc, Score), fail.

score(influenza, Desc) :-
     score_influenza(Score), print_score(Desc, Score), fail.
    
score(pneumoconiosis, Desc) :-
     score_pneumoconiosis(Score), print_score(Desc, Score), fail.
    
score(cystic_fibrosis, Desc) :-
     score_cystic_fibrosis(Score), print_score(Desc, Score), fail.
    
score(sleep_apnea, Desc) :-
     score_sleep_apnea(Score), print_score(Desc, Score), nl.

bronchitis :-
    (
        (symptom(fatigue) , symptom(coughing) -> true) ;
        (symptom(fatigue) , symptom(fever) -> true) ;
        (symptom(fatigue) , symptom(breathing) -> true) ;
        (symptom(coughing) , symptom(fever) -> true) ;
        (symptom(coughing) , symptom(breathing) -> true) ;
        (symptom(fever) , symptom(breathing) -> true)
    ) ,
    (
        symptom(chest_pain); 
        symptom(wheezing); 
        check_symptom(mucus)
    ), fail.
    
tuberculosis:-
    (
        (symptom(fatigue) , symptom(coughing) -> true) ;
        (symptom(fatigue) , symptom(fever) -> true) ;
        (symptom(fatigue) , symptom(chest_pain) -> true) ;
        (symptom(coughing) , symptom(fever) -> true) ;
        (symptom(coughing) , symptom(chest_pain) -> true) ;
        (symptom(fever) , symptom(chest_pain) -> true)
    ),
    (
        check_symptom(appetite); 
        check_symptom(night_sweats); 
        check_symptom(weight_loss)
    ), fail.

acute_respiratory_infection :-
    (
        (symptom(fatigue) , symptom(fever) -> true) ;
        (symptom(fatigue) , symptom(wheezing) -> true) ;
        (symptom(fever) , symptom(wheezing))
    ) ,
    (
        check_symptom(headache); 
        check_symptom(swallow)
    ), fail.

pneumonia :-
    (
        (symptom(fever) , symptom(breathing) -> true) ;
        (symptom(fever) , symptom(chest_pain) -> true) ;
        (symptom(breathing) , symptom(chest_pain))
    ) , 
    (
        check_symptom(heartbeat); 
        check_symptom(shivering); 
        check_symptom(appetite)
    ), fail.

asthma :-
    (
        (symptom(coughing) , symptom(breathing) -> true) ;
        (symptom(coughing) , symptom(wheezing) -> true) ;
        (symptom(breathing) , symptom(wheezing))
    ) , 
    (
        check_symptom(chest_tightening); 
        check_symptom(short_breathing)
    ), fail.

cardiomyopathy :-
    (
        (symptom(fatigue) , symptom(breathing) -> true) ;
        (symptom(fatigue) , symptom(chest_pain) -> true) ;
        (symptom(breathing) , symptom(chest_pain))
    ) , 
    (
        check_symptom(fainting); 
        check_symptom(cracking); 
        check_symptom(lightheadedness)
    ), fail.

influenza :-
    symptom(fatigue), symptom(coughing), 
    (
        (info(age_group, child) -> check_symptom(vomitting), check_symptom(diarrhea) ; true) ;
        check_symptom(headache); 
        check_symptom(runny_nose); 
        check_symptom(throat); 
        check_symptom(muscle_pain)
    ), fail.

pneumoconiosis :-
    symptom(fatigue), symptom(coughing), 
    (
        check_symptom(dust_exposure); 
        check_symptom(runny_nose); 
        check_symptom(short_breathing); 
        check_symptom(chest_tightening)
    ), fail.

cystic_fibrosis :-
    symptom(coughing), symptom(wheezing), 
    (
        check_symptom(short_breathing); 
        check_symptom(poor_growth); 
        check_symptom(salt_tasting)
    ), fail.

sleep_apnea :-
    symptom(fatigue), check_symptom(daytime), 
    ( 
        check_symptom(headache); 
        check_symptom(throat);  
        check_symptom(snoring);  
        check_symptom(reduced)
    ), fail.

score_bronchitis(Score) :-
    % Common symptoms
    (symptom(fatigue) -> Fa = 1 ; Fa = 0 ),
    (symptom(coughing) -> Co = 1 ; Co = 0 ),
    (symptom(fever) -> Fe = 1 ; Fe = 0 ),
    (symptom(breathing) -> Br = 1 ; Br = 0),

    % Info symptoms
    (info(duration, D), D > 1 -> Du = 2 ; Du = 0),

    % Unique symptoms
    (symptom(chest_pain) -> Ch = 5 ; Ch = 0),
    (symptom(wheezing) -> Wh = 5 ; Wh = 0),
    (symptom(mucus) -> Mu = 5 ; Mu = 0),

    Score is Fa + Co + Fe + Br + Ch + Wh + Mu + Du.

score_tuberculosis(Score) :- 
    % Common symptoms
    (symptom(fatigue) -> Fa = 1 ; Fa = 0 ),
    (symptom(coughing) -> Co = 1 ; Co = 0 ),
    (symptom(fever) -> Fe = 1 ; Fe = 0 ),
    (symptom(chest_pain) -> Ch = 1 ; Ch = 0),

    % Info symptoms
    (info(duration, D), D > 3 -> Du = 2 ; Du = 0),

    % Unique symptoms
    (symptom(appetite) -> Ap = 5 ; Ap = 0),
    (symptom(night_sweats) -> Ni = 5 ; Ni = 0),
    (symptom(weight_loss) -> We = 5 ; We = 0),

    Score is Fa + Co + Fe + Ch+ Ap + Ni + We + Du.

score_acute_respiratory_infection(Score) :- 
    % Common symptoms
    (symptom(fatigue) -> Fa = 1 ; Fa = 0 ),
    (symptom(fever) -> Fe = 1 ; Fe = 0 ),
    (symptom(wheezing) -> Wh = 1 ; Wh = 0),

    % Info symptoms
    ((info(age_group, teen) ; info(age_group, adult)) -> Ag = 2 ; Ag = 0),

    % Unique symptoms
    (symptom(headache) -> He = 5 ; He = 0),
    (symptom(swallow) -> Sw = 5 ; Sw = 0),

    Score is Fa + Fe + Wh + He + Sw + Ag.

score_pneumonia(Score) :- 
    % Common symptoms
    (symptom(fever) -> Fe = 1 ; Fe = 0 ),
    (symptom(breathing) -> Br = 1 ; Br = 0 ),
    (symptom(chest_pain) -> Ch = 1 ; Ch = 0),

    % Unique symptoms
    (symptom(heartbeat) -> He = 5 ; He = 0 ),
    (symptom(shivering) -> Sh = 5 ; Sh = 0 ),
    (symptom(appetite) -> Ap = 5 ; Ap = 0 ),

    Score is Fe + Br + Ch + He + Sh + Ap.

score_asthma(Score) :- 
    % Common symptoms
    (symptom(coughing) -> Co = 1 ; Co = 0 ),
    (symptom(breathing) -> Br = 1 ; Br = 0 ),
    (symptom(wheezing) -> Wh = 1 ; Wh = 0 ),
    
    % Info symptoms
    ((info(age_group, infant) ; info(age_group, children) , info(sex, male)) -> Ag = 1 ; Ag = 0 ),
    (((info(age_group, teen) ; info(age_group, adult) ;  info(age_group, elder)), info(sex, female)) -> Age = 1 ; Age = 0 ),

    % Unique symptoms
    (symptom(chest_tightening) -> Ch = 5 ; Ch = 0 ),
    (symptom(short_breathing) -> Sh = 5 ; Sh = 0 ),

    Score is Co + Br + Wh + Ch + Sh + Ag + Age.

score_cardiomyopathy(Score) :- 
    % Common symptoms
    (symptom(fatigue) -> Fa = 1 ; Fa = 0 ),
    (symptom(breathing) -> Br = 1 ; Br = 0 ),
    (symptom(chest_pain) -> Ch = 1 ; Ch = 0 ),

    % Unique symptoms
    (symptom(fainting) -> Fai = 5 ; Fai = 0 ),
    (symptom(cracking) -> Cr = 5 ; Cr = 0 ),
    (symptom(lightheadedness) -> Li = 5 ; Li = 0 ),

    Score is Fa + Br + Ch + Fai + Li + Cr.

score_influenza(Score) :- 
    % Common symptoms
    (symptom(fatigue) -> Fa = 1 ; Fa = 0 ),
    (symptom(coughing) -> Co = 1 ; Co = 0 ),

    %Child symtpoms
    (symptom(vomitting) -> Vo = 5 ; Vo = 0 ),
    (symptom(diarrhea) -> Di = 5 ; Di = 0 ),

    % Unique symptoms
    (symptom(headache) -> He = 5 ; He = 0 ),
    (symptom(throat) -> Th = 5 ; Th = 0 ),
    (symptom(runny_nose) -> Ru = 5 ; Ru = 0 ),
    (symptom(muscle_pain) -> Mu = 5 ; Mu = 0 ),

    Score is Fa + Co + He + Ru + Th + Mu + Vo + Di.

score_pneumoconiosis(Score) :- 
    % Common symptoms
    (symptom(fatigue) -> Fa = 1 ; Fa = 0 ),
    (symptom(coughing) -> Co = 1 ; Co = 0 ),
    
    % Info symptoms
    (info(age, Age), Age < 51, info(respiratory_rate, Resp), Resp >= 25 -> Res = 2 ; Res = 0 ),
    (info(age, Age2), Age2 > 50, info(respiratory_rate, Resp2), Resp2 >= 30 -> Res2 = 2 ; Res2 = 0 ),
    (info(sex, male) -> Se = 1 ; Se = 0 ),

    % Unique symptoms
    (symptom(dust_exposure) -> Du = 5 ; Du = 0 ),
    (symptom(runny_nose) -> Ru = 5 ; Ru = 0 ),
    (symptom(short_breathing) -> Sh = 5 ; Sh = 0 ),
    (symptom(chest_tightening) -> Ch = 5 ; Ch = 0 ),

    Score is Fa + Co + Ru + Sh + Ch + Se + Res + Res2 + Du.

score_cystic_fibrosis(Score) :- 
    % Common symptoms
    (symptom(coughing) -> Co = 1 ; Co = 0 ),
    (symptom(wheezing) -> Wh = 1 ; Wh = 0 ),

    %Info symptoms
    (info(bmi, underweight) -> Un = 2 ; Un = 0 ),

    % Unique symptoms
    (symptom(short_breathing) -> Sh = 5 ; Sh = 0 ),
    (symptom(poor_growth) -> Po = 5 ; Po = 0 ),
    (symptom(salt_tasting) -> St = 5 ; St = 0 ),

    Score is Co + Wh + Sh + Po + St + Un.

score_sleep_apnea(Score) :- 
    % Common symptoms
    (symptom(fatigue) -> Fa = 1 ; Fa = 0 ),
    (symptom(daytime) -> Da = 1 ; Da = 0 ),

    %Info symptoms
    (info(bmi, obese) -> Ob = 2 ; Ob = 0 ),
    (info(age, S), S > 44, S < 66 -> Ag = 2 ; Ag = 0 ),
    (info(sex, male) -> Se = 1 ; Se = 0 ),

    % Unique symptoms
    (symptom(headache) -> He = 5 ; He = 0 ),
    (symptom(throat) -> Th = 5 ; Th = 0 ),
    (symptom(snoring) -> Sn = 5 ; Sn = 0 ),
    (symptom(reduced) -> Re = 5 ; Re = 0 ),

    Score is Fa + Da + He + Th + Sn + Re + Ob + Ag + Se.

undo :- retract(symptom(_)),fail.
undo :- retract(not_symptom(_)),fail.
undo :- retract(info(_, _)),fail.
undo.