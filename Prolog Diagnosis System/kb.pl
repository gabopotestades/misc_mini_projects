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
	