-- ============================================================
-- Nurse Rocky — Patch 016: Module 10 Full Content
-- "Measures Vital Signs"
-- Source: 10.0 Competency Measures Vital Signs.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 10;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 10 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Measures Vital Signs',
    description = 'Normal vital sign ranges, temperature, pulse, respirations, blood pressure, height and weight measurement, documentation, and reporting abnormal findings.',
    is_published = true,
    lessons_count = 6
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '10.1 — Normal Vital Signs Values and Age-Related Variations',
   '10.0 Competency: Measures Vital Signs
Certified Nursing Assistant (CNA) students must understand how to accurately measure vital signs and recognize normal ranges and age-related variations. Vital signs are essential indicators of a resident’s basic body function and overall health status. They provide important information about changes in condition and help the healthcare team identify when further assessment or intervention may be needed.
CNAs are responsible for obtaining vital signs correctly, using proper technique and equipment, and reporting any abnormal findings promptly to the supervising nurse.
 
10.1 Identifies Normal Vital Signs Values and Age-Related Variations
 
Normal Vital Signs Values by Age Groups
CNA students must understand that normal vital signs vary depending on age, health status, and individual conditions.
 
A. Normal Range of Temperature (Oral, Rectal, Tympanic)
Temperature reflects the body’s ability to maintain heat balance.
	•	Oral temperature: Typically ranges from 97.6°F to 99.6°F
	•	Rectal temperature: Typically 0.5°F to 1.0°F higher than oral
	•	Tympanic (ear) temperature: Similar to oral readings, approximately 97.6°F to 99.6°F
CNA students must recognize that rectal temperatures are generally higher and are used when more accurate core temperature readings are needed.
 
B. Normal Pulse Rates
Pulse measures heart rate and rhythm.
	•	Adults: Typically 60 to 100 beats per minute
	•	Pulse may be influenced by activity, emotions, medications, and health conditions.
	•	A pulse that is too fast (tachycardia) or too slow (bradycardia) should be reported.
 
C. Normal Respiratory Rate
Respiratory rate measures the number of breaths per minute.
	•	Adults: Typically 12 to 20 breaths per minute
	•	Breathing should be regular, unlabored, and quiet.
	•	Abnormal breathing patterns, difficulty breathing, or irregular respirations must be reported immediately.
 
D. Normal Blood Pressure
Blood pressure measures the force of blood against artery walls.
	•	Normal adult range: Approximately 90/60 mmHg to 120/80 mmHg
	•	Blood pressure may vary based on age, activity level, medications, and health conditions.
	•	High blood pressure (hypertension) or low blood pressure (hypotension) must be reported to the nurse.
 
Key Concepts for CNA Students
	•	Vital signs provide essential information about a resident’s health status.
	•	Normal ranges may vary based on age, condition, and individual factors.
	•	CNAs must measure vital signs accurately using correct technique and equipment.
	•	Any abnormal findings must be reported immediately to the supervising nurse.
	•	Consistent monitoring helps detect early changes in a resident’s condition.
	•	Accuracy, attention to detail, and proper documentation are essential responsibilities.
By understanding normal vital sign ranges and recognizing variations, CNA students help ensure timely reporting, early intervention, and safe, effective resident care.',
   1),

  (v_mod_id,
   '10.2 — Measures and Records Body Temperature',
   '10.2 Competency: Measures and Records Body Temperature
Certified Nursing Assistant (CNA) students must understand how to properly measure, record, and report body temperature as part of vital sign assessment. Body temperature is a key indicator of a resident’s health status and may signal infection, illness, or changes in physiological condition. Accurate temperature measurement is essential for early detection of health problems and effective communication with the healthcare team.
 
Principles of Body Temperature
 
A. Purpose of Taking a Temperature
CNA students must understand that taking a temperature is used to:
	•	Assess overall health status
	•	Detect fever or infection
	•	Monitor changes in condition
	•	Evaluate response to treatment or medication
	•	Provide baseline data for ongoing assessment
 
B. Factors That Affect Body Temperature
CNA students must recognize that several factors can influence body temperature, including:
	•	Age (older adults may have lower baseline temperatures)
	•	Time of day (lower in the morning, higher in the evening)
	•	Physical activity or exercise
	•	Emotional stress or anxiety
	•	Illness or infection
	•	Environmental temperature
	•	Hormonal changes or medical conditions
	•	Medications that affect temperature regulation
 
C. Procedures for Obtaining Temperatures
CNA students must demonstrate proper technique when obtaining different types of temperatures:
	•	Oral Temperature
	•	Placed under the tongue using a clean probe or thermometer.
	•	Resident must be able to follow instructions and keep mouth closed.
	•	Rectal Temperature
	•	Provides the most accurate core body temperature.
	•	Used when oral or other methods are not appropriate.
	•	Requires strict infection control and privacy measures.
	•	Tympanic Temperature
	•	Taken using an ear thermometer placed gently in the ear canal.
	•	Quick and commonly used in healthcare settings.
All procedures must be performed according to facility policy, infection control standards, and resident safety guidelines.
 
D. Recording Temperature and Units of Measurement
CNA students must accurately document temperature readings by:
	•	Recording values immediately after measurement
	•	Using correct units (Fahrenheit or Celsius as required by facility policy)
	•	Documenting method used (oral, rectal, tympanic)
	•	Reporting results in the resident’s record or flow sheet
	•	Ensuring accuracy and legibility in all documentation
 
E. Identifies and Reports Abnormal Findings
CNA students must recognize and promptly report abnormal temperature readings, including:
	•	Fever (elevated temperature above normal range)
	•	Hypothermia (lower-than-normal body temperature)
	•	Sudden changes from baseline temperature
	•	Signs of infection such as chills, sweating, or confusion
All abnormal findings must be reported immediately to the supervising nurse.
 
Key Concepts for CNA Students
	•	Temperature is a vital sign used to monitor health and detect illness.
	•	Proper technique is essential for accurate readings.
	•	CNAs must understand differences between oral, rectal, and tympanic methods.
	•	Accurate documentation supports safe and effective resident care.
	•	Abnormal findings must be reported immediately.
	•	Infection control and resident comfort are critical during temperature measurement.
By accurately measuring and recording body temperature, CNA students contribute to early detection of illness, effective communication, and high-quality resident care.',
   2),

  (v_mod_id,
   '10.3 — Measures and Records Pulse (Radial, Apical)',
   '10.3 Competency: Measures and Records Pulse (Radial, Apical)
Certified Nursing Assistant (CNA) students must understand how to accurately measure and record a resident’s pulse as part of vital sign assessment. The pulse reflects the heart’s rate and rhythm and provides important information about cardiovascular function and overall health status. Accurate pulse measurement is essential for identifying changes in condition and communicating concerns to the healthcare team.
 
Pulse (Radial, Apical, Carotid, Brachial)
 
A. Purpose of Obtaining a Pulse Rate
CNA students must understand that measuring the pulse is used to:
	•	Assess heart rate and rhythm
	•	Monitor cardiovascular health
	•	Detect changes in a resident’s condition
	•	Evaluate response to medications or treatments
	•	Provide baseline data for ongoing assessment
 
B. Factors Affecting Pulse Rate
CNA students must recognize that several factors can influence pulse rate, including:
	•	Age (children typically have higher pulse rates than adults)
	•	Physical activity or exercise
	•	Emotional stress or anxiety
	•	Pain or discomfort
	•	Fever or infection
	•	Medications (such as cardiac medications)
	•	Blood loss or dehydration
	•	Overall health condition
 
C. Procedure for Taking a Radial Pulse
The radial pulse is the most common method used in healthcare settings.
CNA students must:
	•	Use the index and middle fingers (not the thumb).
	•	Locate the radial artery on the wrist.
	•	Count beats for a full minute if rhythm is irregular or per facility policy.
	•	Observe rate, rhythm, and strength of pulse.
	•	Ensure the resident is at rest before measuring.
 
D. Procedure for Taking an Apical Pulse
The apical pulse is taken using a stethoscope and is located at the heart.
CNA students must:
	•	Place the stethoscope over the apex of the heart (left side of chest, fifth intercostal space).
	•	Listen carefully for heartbeats.
	•	Count beats for one full minute.
	•	Ensure the environment is quiet for accurate measurement.
	•	Follow facility policy and training for proper technique.
 
E. Recording Pulse Rate
CNA students must accurately document pulse findings by:
	•	Recording the rate in beats per minute (BPM)
	•	Documenting whether the pulse is regular or irregular
	•	Reporting the method used (radial or apical)
	•	Recording information immediately after measurement
	•	Following facility documentation procedures
 
F. Identifies and Reports Abnormal Findings
CNA students must recognize and report abnormal pulse findings, including:
	•	Tachycardia
	•	Pulse rate faster than normal (>100 bpm in adults)
	•	Bradycardia
	•	Pulse rate slower than normal (<60 bpm in adults)
	•	Arrhythmia
	•	Irregular heartbeat or abnormal rhythm
Any abnormal findings must be reported immediately to the supervising nurse.
 
Key Concepts for CNA Students
	•	The pulse reflects heart rate and cardiovascular function.
	•	Accurate technique is essential for reliable results.
	•	Radial pulse is most commonly used; apical pulse is used for specific conditions.
	•	Several factors can affect pulse rate and rhythm.
	•	Abnormal findings must always be reported promptly.
	•	Proper documentation supports safe and effective resident care.
By accurately measuring and recording pulse rates, CNA students contribute to early detection of health changes, effective communication, and high-quality resident care.',
   3),

  (v_mod_id,
   '10.4 — Measures and Records Respirations',
   '10.4 Competency: Measures and Records Respirations
Certified Nursing Assistant (CNA) students must understand how to accurately measure and record respirations as part of vital sign assessment. Respirations reflect the body’s ability to exchange oxygen and carbon dioxide and are a critical indicator of respiratory and overall health status. Accurate assessment of respirations helps identify early signs of distress or changes in a resident’s condition.
 
Respirations
 
A. Purpose of Obtaining a Respiratory Rate
CNA students must understand that measuring respirations is used to:
	•	Assess breathing rate, depth, and rhythm
	•	Monitor oxygenation and respiratory function
	•	Detect early signs of respiratory distress or illness
	•	Evaluate response to treatments or medications
	•	Provide baseline data for ongoing resident assessment
 
B. Factors Influencing Respiratory Rate
CNA students must recognize that respiratory rate can be affected by:
	•	Age (children typically breathe faster than adults)
	•	Physical activity or exertion
	•	Pain or anxiety
	•	Fever or infection
	•	Respiratory or cardiac conditions
	•	Medications (such as sedatives or opioids)
	•	Body position
	•	Emotional stress
 
C. Procedure for Obtaining a Respiratory Rate
CNA students must accurately assess respirations by:
	•	Observing chest rise and fall or abdominal movement.
	•	Counting respirations without alerting the resident (to avoid changing breathing pattern).
	•	Counting for a full 60 seconds if irregular or per facility policy.
	•	Noting rate, rhythm, and depth of breathing.
	•	Observing for signs of difficulty breathing such as use of accessory muscles or labored breathing.
 
D. Recording Respirations
CNA students must document respirations accurately by:
	•	Recording breaths per minute (RPM)
	•	Noting whether respirations are regular or irregular
	•	Recording depth (normal, shallow, or deep) when required
	•	Documenting immediately after measurement
	•	Following facility documentation procedures precisely
 
E. Identifies and Reports Abnormal Respiratory Rates
CNA students must recognize and promptly report abnormal respiratory findings, including:
	•	Tachypnea
	•	Abnormally fast breathing rate
	•	Bradypnea
	•	Abnormally slow breathing rate
	•	Apnea
	•	Temporary or complete absence of breathing
	•	Variable or Irregular Patterns
	•	Uneven or abnormal breathing rhythm or depth
Any abnormal respiratory findings must be reported immediately to the supervising nurse.
 
Key Concepts for CNA Students
	•	Respirations are a vital indicator of oxygenation and health status.
	•	Accurate counting requires careful observation without disturbing the resident.
	•	Rate, rhythm, and depth are all important components of respiratory assessment.
	•	Several factors can influence breathing patterns.
	•	Abnormal respirations require immediate reporting.
	•	Proper documentation ensures continuity of care and resident safety.
By accurately measuring and recording respirations, CNA students help ensure early detection of respiratory problems and support safe, effective resident care.',
   4),

  (v_mod_id,
   '10.5 — Measures and Records Blood Pressure',
   '10.5 Competency: Measures and Records Blood Pressure
Certified Nursing Assistant (CNA) students must understand how to accurately measure and record blood pressure as part of vital sign assessment. Blood pressure reflects the force of blood against the walls of the arteries and is a key indicator of cardiovascular health. Accurate blood pressure measurement is essential for detecting changes in a resident’s condition and supporting timely medical intervention.
CNAs must demonstrate proper technique, use equipment correctly, and report abnormal findings immediately to the supervising nurse.
 
A. Purpose of Taking a Blood Pressure
CNA students must understand that blood pressure is taken to:
	•	Assess cardiovascular function and circulation
	•	Detect hypertension (high blood pressure) or hypotension (low blood pressure)
	•	Monitor the effects of medications and treatments
	•	Identify changes in a resident’s condition
	•	Provide baseline information for ongoing assessment
 
B. Factors Influencing Blood Pressure
CNA students must recognize that blood pressure may be affected by:
	•	Age and overall health status
	•	Stress, anxiety, or pain
	•	Physical activity or recent movement
	•	Medications (e.g., antihypertensives, diuretics)
	•	Body position (lying, sitting, standing)
	•	Fluid volume and hydration status
	•	Illness or chronic conditions
 
C. Use of the Stethoscope
CNA students must demonstrate proper use of a stethoscope when measuring blood pressure by:
	•	Placing the earpieces correctly in the ears facing forward.
	•	Ensuring a proper seal with the diaphragm placed over the brachial artery.
	•	Listening carefully for clear heart sounds (Korotkoff sounds).
	•	Maintaining a quiet environment for accurate measurement.
 
D. Using a Sphygmomanometer (Blood Pressure Cuff)
CNA students must demonstrate correct use of a sphygmomanometer, including:
	•	Selecting the correct cuff size based on resident’s arm circumference.
	•	Placing the cuff snugly on the upper arm above the elbow.
	•	Ensuring proper alignment of the cuff with the brachial artery.
	•	Inflating and deflating the cuff slowly and accurately.
	•	Avoiding improper cuff placement that may result in inaccurate readings.
 
E. Procedure for Obtaining Blood Pressure
CNA students must follow proper steps when obtaining blood pressure:
	•	Position the resident comfortably with arm supported at heart level.
	•	Apply appropriate cuff size correctly.
	•	Inflate cuff and slowly release pressure while listening with stethoscope.
	•	Identify systolic (first sound) and diastolic (last sound) readings.
	•	Repeat measurement if necessary according to facility policy.
 
F. Precautions and Contraindications
CNA students must be aware of situations where blood pressure should be avoided or used cautiously:
	•	Do not take blood pressure on an arm with:
	•	IV lines
	•	Dialysis access (fistula or graft)
	•	Injuries, wounds, or surgery
	•	Severe lymphedema or mastectomy on that side (as directed by facility policy)
	•	Avoid tight cuff placement that may cause discomfort or injury.
	•	Follow infection control procedures at all times.
 
G. Orthostatic Blood Pressure
CNA students must understand how to measure orthostatic blood pressure to assess for changes related to position:
	•	Measure blood pressure while the resident is lying down.
	•	Repeat measurement while sitting.
	•	Repeat again while standing (if safe and ordered).
	•	Observe for dizziness, weakness, or lightheadedness.
	•	Report significant drops in blood pressure or symptoms immediately.
 
H. Recording Systolic and Diastolic Pressure
CNA students must accurately document blood pressure readings by:
	•	Recording systolic pressure (top number).
	•	Recording diastolic pressure (bottom number).
	•	Including position if required (lying, sitting, standing).
	•	Documenting immediately after measurement.
	•	Following facility documentation procedures.
 
I. Reports Abnormal Blood Pressure Values
CNA students must recognize and report abnormal findings, including:
	•	Hypertension: Elevated blood pressure above normal range.
	•	Hypotension: Abnormally low blood pressure.
	•	Sudden changes from baseline readings.
	•	Symptoms such as dizziness, fainting, headache, or confusion.
All abnormal findings must be reported immediately to the supervising nurse.
 
Key Concepts for CNA Students
	•	Blood pressure is a critical indicator of cardiovascular health.
	•	Proper technique and correct equipment are essential for accuracy.
	•	Cuff size and placement directly affect readings.
	•	Orthostatic measurements help identify risk for falls and dizziness.
	•	Certain conditions require avoiding blood pressure on specific limbs.
	•	All abnormal results must be reported promptly.
	•	Accurate documentation supports safe and effective care.
By accurately measuring and recording blood pressure, CNA students contribute to early detection of health concerns, prevention of complications, and high-quality resident care.',
   5),

  (v_mod_id,
   '10.6 — Measures and Records Height and Weight',
   '10.6 Competency: Measures and Records Height and Weight
Certified Nursing Assistant (CNA) students must understand how to accurately measure and record height and weight as part of essential resident assessment. Height and weight measurements are important indicators of nutritional status, fluid balance, growth, and overall health. Consistent and accurate measurements help the healthcare team identify changes in condition and evaluate the effectiveness of care plans.
CNAs are responsible for using proper equipment and technique, ensuring accuracy, and reporting significant changes to the supervising nurse.
 
Height and Weight
 
A. Purpose of Measuring Height and Weight
CNA students must understand that height and weight measurements are used to:
	•	Monitor nutritional status and hydration
	•	Detect weight gain or loss over time
	•	Evaluate effectiveness of dietary or medical interventions
	•	Assist in medication dosing calculations
	•	Identify health concerns such as malnutrition, edema, or fluid overload
	•	Provide baseline data for ongoing assessments
 
B. Factors Affecting Height and Weight
CNA students must recognize that several factors may influence height and weight, including:
	•	Age-related changes (loss of height due to bone density changes)
	•	Dietary intake and nutrition
	•	Fluid retention or dehydration
	•	Illness or chronic disease
	•	Physical activity level
	•	Medication effects
	•	Mobility limitations
	•	Clothing or equipment differences during measurement
 
C. Scales and Measuring Devices
CNA students must be familiar with tools used to obtain accurate measurements, including:
	•	Standing balance scales
	•	Wheelchair scales
	•	Chair scales
	•	Bed scales
	•	Measuring bars attached to scales or walls
	•	Tape measures for bedridden residents
Proper calibration and correct use of equipment are essential for accuracy.
 
D. Procedure for Measuring Weight Using a Balanced Scale
CNA students must demonstrate proper technique by:
	•	Ensuring the scale is balanced and calibrated to zero.
	•	Assisting the resident onto the scale safely.
	•	Ensuring the resident is wearing similar clothing and no heavy items.
	•	Positioning the resident correctly and ensuring safety.
	•	Reading and recording the measurement accurately.
	•	Repeating the measurement if needed according to facility policy.
 
E. Procedure for Measuring Height Using a Measure Bar
CNA students must measure height by:
	•	Ensuring the resident stands straight with heels together when possible.
	•	Positioning the head in a neutral alignment.
	•	Lowering the measuring bar gently to rest on the top of the head.
	•	Recording the measurement accurately in inches or centimeters per facility policy.
 
F. Measuring Height and Weight in Bedridden Residents
CNA students must understand alternative methods for residents who cannot stand, including:
	•	Using bed scales to measure weight.
	•	Using chair or wheelchair scales when appropriate.
	•	Estimating height using arm span or recumbent measurement techniques.
	•	Ensuring safety and comfort during all measurements.
	•	Following facility policy for bedridden measurements.
 
G. Recording Height and Weight
CNA students must document measurements accurately by:
	•	Recording weight in pounds or kilograms as required.
	•	Recording height in inches or centimeters.
	•	Documenting measurements immediately after obtaining them.
	•	Ensuring accuracy and consistency in documentation.
	•	Following facility recordkeeping procedures.
 
H. Reports Abnormal Weight Changes
CNA students must recognize and report significant changes, including:
	•	Sudden or unexplained weight loss
	•	Rapid weight gain
	•	Gradual but consistent changes outside expected range
	•	Signs of fluid retention (swelling, edema)
	•	Signs of malnutrition or dehydration
All abnormal findings must be reported immediately to the supervising nurse.
 
Key Concepts for CNA Students
	•	Height and weight are essential indicators of health and nutritional status.
	•	Accurate measurement requires proper technique and correct equipment.
	•	Consistency in measurement conditions is critical for reliable results.
	•	Bedridden residents require alternative measurement methods.
	•	Significant weight changes must always be reported promptly.
	•	Documentation must be accurate, timely, and complete.
By accurately measuring and recording height and weight, CNA students contribute to early detection of health changes, effective care planning, and improved resident outcomes.',
   6);

  RAISE NOTICE 'Module 10 updated with 6 lessons.';
END $$;
