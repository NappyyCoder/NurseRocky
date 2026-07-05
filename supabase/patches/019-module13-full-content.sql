-- ============================================================
-- Nurse Rocky — Patch 019: Module 13 Full Content
-- "Identifies the Function, Structure, Common Health Problems, and Normal Aging Changes of Body Systems"
-- Source: 13.0 Competency Identifies the Function, Structure, Common Health Problems, and Normal Aging Changes of Body Systems.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 13;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 13 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Identifies Function, Structure, and Normal Aging Changes of Body Systems',
    description = 'Anatomical terms, tissue types, and major body systems including structure, function, common health problems, aging changes, and signs to report.',
    is_published = true,
    lessons_count = 11
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '13.1 — Anatomical Terms and Tissue Types',
   'Competency 13.0: Identifies the Function, Structure, Common Health Problems, and Normal Aging Changes of Body Systems
Understanding the human body is essential for Certified Nursing Assistants (CNAs) in providing safe, accurate, and effective care. Knowledge of body systems, organs, tissues, and how they function helps CNAs recognize normal aging changes, identify potential health concerns, and report observations appropriately to the healthcare team. This foundational knowledge supports quality resident care and promotes early identification of changes in condition.
Students will learn basic anatomical terminology, the organization of the human body, and the types of tissues that make up body systems and organs.
 
Learning Goal 13.1
Describe major body systems and organs by defining key anatomical terms and identifying the four types of tissues.
 
A. Key Anatomical Terms
Anatomical terms are used to describe the structure, location, and movement of the human body. These terms help healthcare workers communicate clearly and accurately.
Key anatomical concepts include:
	•	Anatomy: The study of body structure and the relationship between body parts.
	•	Physiology: The study of how body systems and organs function.
	•	Cells: The smallest living units of the body.
	•	Tissues: Groups of similar cells that perform a specific function.
	•	Organs: Structures made up of different tissues that perform specific functions.
	•	Body systems: Groups of organs that work together to perform major body functions (e.g., respiratory, cardiovascular, nervous systems).
Understanding these terms allows CNAs to accurately describe observations and understand how the body functions as a whole system.
 
B. Types of Tissues
Tissues are groups of specialized cells that work together to perform specific functions within the body. There are four main types of tissue in the human body:
	•	Epithelial Tissue:Covers body surfaces, lines organs and cavities, and forms glands. It protects the body and helps with absorption and secretion.
	•	Connective Tissue:Supports, binds, and connects other tissues and organs. Examples include bone, blood, cartilage, fat, and ligaments.
	•	Muscle Tissue:Responsible for movement in the body. Includes skeletal muscle (voluntary movement), smooth muscle (involuntary movement in organs), and cardiac muscle (heart function).
	•	Nervous Tissue:Transmits electrical signals throughout the body. It controls communication between the brain, spinal cord, and other body parts.
 
Summary
A basic understanding of body organization, anatomical terms, and tissue types is essential for CNA practice. These concepts provide the foundation for recognizing how the body functions and responding appropriately to changes in resident condition. By understanding how cells, tissues, organs, and systems work together, CNAs are better prepared to deliver safe, informed, and effective care.',
   1),

  (v_mod_id,
   '13.2 — Respiratory System',
   'Competency 13.2: Respiratory System—Function, Structure, Health Problems, and Aging Changes
The respiratory system is essential for life because it provides the body with oxygen and removes carbon dioxide. Certified Nursing Assistants (CNAs) must understand how the respiratory system functions, recognize normal aging changes, and identify signs of respiratory illness. This knowledge allows CNAs to observe changes in residents’ breathing status and report concerns promptly to the nurse.
Students will learn the structure and function of the respiratory system, common respiratory conditions, normal aging changes, and how to measure and document oxygen saturation using a pulse oximeter.
 
Learning Goal 13.2
Identify the structure, function, common health problems, normal aging changes, and signs of respiratory system changes, including oxygen saturation monitoring.
 
A. Structure and Function of the Respiratory System
The respiratory system works together to bring oxygen into the body and remove waste gases.
Key components include:
	•	Nose and nasal cavity: Filters, warms, and moistens air.
	•	Pharynx (throat): Passageway for air and food.
	•	Larynx (voice box): Contains vocal cords and protects the airway.
	•	Trachea (windpipe): Carries air to the lungs.
	•	Bronchi and bronchioles: Branching airways that distribute air within the lungs.
	•	Alveoli: Tiny air sacs where oxygen and carbon dioxide exchange occurs.
	•	Lungs: Main organs responsible for gas exchange.
	•	Diaphragm: Muscle that helps expand and contract the lungs for breathing.
The primary function of the respiratory system is to supply oxygen to the blood and remove carbon dioxide from the body.
 
B. Age-Related Changes in the Respiratory System
As individuals age, natural changes in the respiratory system may occur, including:
	•	Decreased lung elasticity, making breathing less efficient.
	•	Reduced lung capacity.
	•	Weakened respiratory muscles.
	•	Decreased cough reflex, increasing risk of infection.
	•	Thicker secretions that are harder to clear.
	•	Reduced oxygen exchange efficiency.
These changes may make older adults more vulnerable to respiratory infections and breathing difficulties.
 
C. Common Respiratory Health Problems and Signs & Symptoms
CNAs must recognize common respiratory conditions and observe for changes in resident status.
	•	Chronic Obstructive Pulmonary Disease (COPD):
	•	Shortness of breath
	•	Chronic cough
	•	Wheezing
	•	Fatigue
	•	Bronchitis:
	•	Persistent cough
	•	Mucus production
	•	Chest discomfort
	•	Asthma:
	•	Wheezing
	•	Shortness of breath
	•	Chest tightness
	•	Coughing episodes
	•	Tuberculosis (TB):
	•	Persistent cough (may include blood)
	•	Weight loss
	•	Night sweats
	•	Fatigue
	•	Pneumonia:
	•	Fever and chills
	•	Productive cough
	•	Shortness of breath
	•	Chest pain
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and report any changes in respiratory status, including:
	•	Shortness of breath or difficulty breathing
	•	Rapid or labored breathing
	•	Wheezing, coughing, or abnormal breath sounds
	•	Bluish coloration of lips or fingertips (cyanosis)
	•	Use of accessory muscles when breathing
	•	Changes in mental status or confusion
	•	Decreased activity tolerance or fatigue
	•	Fever or signs of infection
Immediate reporting of these symptoms is essential for resident safety.
 
E. Oxygen Saturation and Pulse Oximetry
Oxygen saturation (SpO₂) measures how much oxygen is carried in the blood. It is commonly measured using a pulse oximeter, a small device placed on the finger, toe, or earlobe.
CNAs may be responsible for:
	•	Applying the pulse oximeter correctly.
	•	Ensuring the resident is at rest during measurement.
	•	Recording oxygen saturation levels accurately.
	•	Reporting low oxygen readings or changes from baseline to the nurse immediately.
Normal oxygen saturation levels are typically between 95% and 100%, but facility policy and resident condition may vary.
 
Summary
Understanding the respiratory system helps CNAs recognize normal function, aging changes, and signs of respiratory illness. By observing carefully, reporting changes promptly, and accurately measuring oxygen saturation, nursing assistants play a vital role in maintaining resident safety and supporting respiratory health.',
   2),

  (v_mod_id,
   '13.3 — Circulatory System',
   'Competency 13.3: Circulatory System—Function, Structure, Health Problems, and Aging Changes
The circulatory system is responsible for delivering oxygen, nutrients, and hormones throughout the body while removing waste products. Certified Nursing Assistants (CNAs) must understand how the circulatory system functions, recognize normal age-related changes, and identify signs of circulatory problems. This knowledge is essential for observing changes in resident condition and reporting concerns promptly to the nurse.
Students will learn the structure and function of the circulatory system, common cardiovascular conditions, age-related changes, and the signs and symptoms that must be observed and reported.
 
Learning Goal 13.3
Identify the structure, function, common health problems, and normal aging changes of the circulatory system.
 
A. Structure and Function of the Circulatory System
The circulatory system is responsible for moving blood throughout the body to maintain life and support all organ systems.
Key components include:
	•	Heart: A muscular organ that pumps blood throughout the body.
	•	Blood vessels:
	•	Arteries: Carry oxygen-rich blood away from the heart.
	•	Veins: Carry oxygen-poor blood back to the heart.
	•	Capillaries: Tiny vessels where oxygen and nutrient exchange occurs.
	•	Blood: Carries oxygen, nutrients, hormones, and waste products.
The main function of the circulatory system is to ensure proper circulation of blood to all tissues and organs.
 
B. Age-Related Changes in the Circulatory System
As the body ages, natural changes occur in the circulatory system, including:
	•	Decreased elasticity of blood vessels.
	•	Slower circulation and reduced blood flow.
	•	Increased workload on the heart.
	•	Thickening of vessel walls.
	•	Increased risk of blood pressure changes.
	•	Reduced ability to respond quickly to physical stress.
These changes may increase the risk of cardiovascular disease in older adults.
 
C. Common Circulatory System Health Problems and Signs & Symptoms
CNAs must be aware of common circulatory conditions and their observable signs.
	•	Atherosclerosis:
	•	Hardening of arteries due to plaque buildup.
	•	Arteriosclerosis:
	•	Thickening and stiffening of blood vessel walls.
	•	Angina:
	•	Chest pain or discomfort due to reduced blood flow to the heart.
	•	Myocardial Infarction (Heart Attack):
	•	Severe chest pain, shortness of breath, sweating, nausea, or radiating pain.
	•	Coronary Artery Disease (CAD):
	•	Reduced blood flow to the heart muscle causing fatigue and chest discomfort.
	•	Heart Failure:
	•	Shortness of breath, swelling in legs or feet, fatigue, and fluid retention.
	•	Hypertension (High Blood Pressure):
	•	Often “silent” but may contribute to headaches, dizziness, or no symptoms at all.
	•	Irregular Heart Rates (Arrhythmias/Pacemakers):
	•	Palpitations, dizziness, fatigue, or irregular pulse; some residents may have pacemakers to regulate heart rhythm.
	•	Peripheral Vascular Disease (PVD):
	•	Poor circulation in the limbs, pain when walking, cool skin, or slow healing wounds.
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and immediately report circulatory changes, including:
	•	Chest pain or pressure
	•	Shortness of breath
	•	Swelling in legs, feet, or ankles (edema)
	•	Pale, cool, or bluish skin
	•	Weak or irregular pulse
	•	Dizziness or fainting
	•	Sudden fatigue or weakness
	•	Pain in legs when walking or at rest
	•	Changes in blood pressure if measured
	•	Signs of possible heart attack (emergency symptoms)
Prompt reporting is essential for preventing complications and ensuring resident safety.
 
Summary
The circulatory system is vital for sustaining life by delivering oxygen and nutrients throughout the body. CNAs must understand how this system functions, recognize age-related changes, and identify early signs of cardiovascular problems. By observing carefully and reporting changes promptly, nursing assistants play a key role in protecting resident health and preventing serious complications.',
   3),

  (v_mod_id,
   '13.4 — Urinary System',
   'Competency 13.4: Urinary System—Function, Structure, Health Problems, and Aging Changes
The urinary system is responsible for removing waste products and excess fluids from the body, helping maintain fluid balance and overall health. Certified Nursing Assistants (CNAs) must understand how the urinary system functions, recognize normal aging changes, and identify signs of urinary system disorders. This knowledge helps CNAs observe changes in elimination patterns and report concerns promptly to the nurse.
Students will learn the structure and function of the urinary system, common urinary disorders, normal aging changes, and signs and symptoms that must be observed and reported.
 
Learning Goal 13.4
Identify the structure, function, common health problems, and normal aging changes of the urinary system.
 
A. Structure and Function of the Urinary System
The urinary system removes waste products from the blood and regulates fluid, electrolyte, and acid-base balance.
Key components include:
	•	Kidneys: Filter blood to produce urine and remove waste products.
	•	Ureters: Tubes that transport urine from the kidneys to the bladder.
	•	Bladder: Muscular organ that stores urine until elimination.
	•	Urethra: Tube that carries urine from the bladder out of the body.
The primary function of the urinary system is to maintain internal balance by producing and eliminating urine.
 
B. Age-Related Changes in the Urinary System
Normal aging changes may affect urinary function and include:
	•	Decreased kidney function and filtration efficiency.
	•	Reduced bladder capacity.
	•	Weakened bladder muscles.
	•	Decreased ability to concentrate urine.
	•	Increased frequency of urination, especially at night (nocturia).
	•	Increased risk of urinary retention or leakage.
These changes may increase the risk of infection and incontinence in older adults.
 
C. Common Urinary System Health Problems and Signs & Symptoms
CNAs must recognize common urinary disorders and observe for related signs and symptoms.
	•	Kidney (Renal) Failure:
	•	Decreased urine output or no urine
	•	Swelling in legs, feet, or face
	•	Fatigue and confusion
	•	Fluid retention
	•	Urinary Tract Infection (UTI):
	•	Burning or pain during urination
	•	Frequent urination
	•	Cloudy or foul-smelling urine
	•	Confusion (especially in older adults)
	•	Fever or discomfort
	•	Incontinence (Types):
	•	Stress incontinence: Leakage with coughing, sneezing, or activity
	•	Urge incontinence: Sudden, strong need to urinate
	•	Functional incontinence: Inability to reach the bathroom in time due to mobility or cognition issues
	•	Overflow incontinence: Bladder does not empty completely, leading to dribbling
	•	Kidney Stones:
	•	Severe back or side pain
	•	Blood in urine
	•	Nausea or vomiting
	•	Pain during urination
 
D. Signs and Symptoms to Observe and Report
CNAs must observe and promptly report changes in urinary function, including:
	•	Changes in urine amount, color, or odor
	•	Pain or burning during urination
	•	Blood in urine
	•	Decreased or absent urine output
	•	Increased frequency or urgency
	•	Signs of incontinence or new leakage
	•	Swelling in extremities
	•	Confusion or sudden change in mental status
	•	Fever or signs of infection
Early reporting helps prevent complications and supports resident safety.
 
Summary
The urinary system plays a vital role in removing waste and maintaining fluid balance in the body. CNAs must understand how the system works, recognize normal aging changes, and identify signs of urinary disorders. By observing elimination patterns and reporting changes promptly, nursing assistants help ensure timely intervention and promote resident health and comfort.',
   4),

  (v_mod_id,
   '13.5 — Endocrine System',
   'Competency 13.5: Endocrine System—Function, Structure, Health Problems, and Aging Changes
The endocrine system is responsible for producing hormones that regulate many essential body functions, including metabolism, growth, energy levels, and blood sugar control. Certified Nursing Assistants (CNAs) must understand how the endocrine system functions, recognize normal age-related changes, and identify signs and symptoms of endocrine disorders. This knowledge helps CNAs observe important changes in resident condition and report them promptly to the nurse.
Students will learn the structure and function of the endocrine system, common endocrine disorders, normal aging changes, and signs and symptoms that must be observed and reported.
 
Learning Goal 13.5
Identify the structure, function, common health problems, and normal aging changes of the endocrine system.
 
A. Structure and Function of the Endocrine System
The endocrine system is made up of glands that release hormones directly into the bloodstream. These hormones control and coordinate many body processes.
Key components include:
	•	Pituitary gland: Controls other endocrine glands and regulates growth and development.
	•	Thyroid gland: Regulates metabolism, energy use, and body temperature.
	•	Parathyroid glands: Help regulate calcium levels in the blood and bones.
	•	Adrenal glands: Produce hormones that help the body respond to stress and regulate blood pressure.
	•	Pancreas: Produces insulin and glucagon to regulate blood sugar levels.
	•	Reproductive glands (ovaries/testes): Produce sex hormones that regulate reproduction and secondary sexual characteristics.
The main function of the endocrine system is to maintain balance (homeostasis) in the body through hormone regulation.
 
B. Age-Related Changes in the Endocrine System
As people age, the endocrine system may function less efficiently. Common changes include:
	•	Decreased hormone production.
	•	Slower metabolic rate.
	•	Reduced tolerance to glucose (increased risk of diabetes).
	•	Changes in thyroid function.
	•	Altered stress response.
	•	Decreased regulation of calcium, affecting bone health.
These changes can increase the risk of chronic disease and affect energy levels, mood, and overall health.
 
C. Common Endocrine System Health Problems and Signs & Symptoms
CNAs must recognize common endocrine disorders and observe for related signs and symptoms.
	•	Diabetes Mellitus:
	•	Increased thirst (polydipsia)
	•	Frequent urination (polyuria)
	•	Increased hunger (polyphagia)
	•	Fatigue
	•	Slow wound healing
	•	Blood sugar imbalances (high or low)
	•	Thyroid Disease:
	•	Hypothyroidism (low thyroid):
	•	Fatigue
	•	Weight gain
	•	Cold intolerance
	•	Slow heart rate
	•	Hyperthyroidism (high thyroid):
	•	Weight loss
	•	Heat intolerance
	•	Nervousness or irritability
	•	Rapid heart rate
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and report any changes that may indicate endocrine imbalance, including:
	•	Changes in appetite, thirst, or weight
	•	Unusual fatigue or weakness
	•	Confusion or changes in mental status
	•	Excessive urination or fluid intake
	•	Signs of high or low blood sugar (sweating, shakiness, dizziness)
	•	Slow or rapid heart rate
	•	Changes in skin condition or wound healing
	•	Behavioral or mood changes
Prompt reporting allows the healthcare team to intervene quickly and prevent complications.
 
Summary
The endocrine system plays a critical role in regulating essential body functions through hormone production. CNAs must understand how this system works, recognize normal aging changes, and identify signs of endocrine disorders such as diabetes and thyroid disease. By observing carefully and reporting changes promptly, nursing assistants help maintain resident stability, safety, and overall health.',
   5),

  (v_mod_id,
   '13.6 — Integumentary System',
   'Competency 13.6: Integumentary System—Function, Structure, Health Problems, and Aging Changes
The integumentary system includes the skin, hair, and nails, and serves as the body’s first line of protection against injury, infection, and environmental hazards. Certified Nursing Assistants (CNAs) must understand the structure and function of the integumentary system, recognize normal aging changes, and identify signs of skin problems. Careful observation of skin condition is essential for preventing complications and promoting resident comfort and safety.
Students will learn the structure and function of the integumentary system, common skin-related health problems, normal aging changes, and signs and symptoms that must be reported to the nurse.
 
Learning Goal 13.6
Identify the structure, function, common health problems, and normal aging changes of the integumentary system.
 
A. Structure and Function of the Integumentary System
The integumentary system is made up of the skin and mucous membranes, along with associated structures such as hair and nails.
Key components include:
	•	Skin: The body’s largest organ, providing protection, temperature regulation, sensation, and fluid balance.
	•	Epidermis: The outer protective layer of skin.
	•	Dermis: The middle layer containing blood vessels, nerves, and glands.
	•	Subcutaneous tissue: The deepest layer that provides cushioning and insulation.
	•	Mucous membranes: Line body openings and help protect against infection.
The primary functions of the integumentary system include protection from injury and infection, temperature regulation, sensation, and maintaining hydration.
 
B. Age-Related Changes in the Integumentary System
Normal aging changes affect the skin and increase vulnerability to injury and infection. These changes include:
	•	Thinning of the skin and loss of elasticity.
	•	Decreased oil and sweat gland activity, leading to dry skin.
	•	Reduced blood flow to the skin.
	•	Slower wound healing.
	•	Increased bruising due to fragile blood vessels.
	•	Decreased sensation, increasing risk of injury.
	•	Thinning hair and brittle nails.
These changes make older adults more susceptible to skin breakdown and injury.
 
C. Common Integumentary System Health Problems and Signs & Symptoms
CNAs must recognize common skin conditions and observe for related signs and symptoms.
	•	Bruises:
	•	Discoloration of skin due to injury or fragile blood vessels.
	•	Skin Tears:
	•	Tearing of fragile skin, often from friction or trauma.
	•	Rashes:
	•	Red, irritated, or inflamed areas of skin caused by allergies, infection, or irritation.
	•	Decubitus Ulcers (Pressure Injuries):
	•	Skin breakdown caused by prolonged pressure, often over bony areas.
	•	Redness, open wounds, or drainage.
	•	Shingles:
	•	Painful, blistering rash caused by reactivation of the chickenpox virus.
	•	Lice and Scabies:
	•	Parasitic infestations causing itching, redness, and skin irritation.
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and promptly report any changes in skin condition, including:
	•	Redness, swelling, or warmth of the skin
	•	Open areas, wounds, or pressure injuries
	•	Bruising without known cause
	•	Rashes or skin irritation
	•	Signs of infection (drainage, odor, increased pain)
	•	Complaints of itching or discomfort
	•	Dry, cracked, or fragile skin
	•	Changes in skin color or temperature
Early reporting is essential for preventing complications and promoting healing.
 
Summary
The integumentary system plays a vital role in protecting the body and maintaining overall health. CNAs must understand how the skin functions, recognize normal aging changes, and identify early signs of skin problems. By observing carefully, providing appropriate skin care, and reporting changes promptly, nursing assistants help prevent injury, promote healing, and ensure resident comfort and safety.',
   6),

  (v_mod_id,
   '13.7 — Nervous System',
   'Competency 13.7: Nervous System—Function, Structure, Health Problems, and Aging Changes
The nervous system controls and coordinates all body functions, including movement, sensation, thinking, memory, and communication. Certified Nursing Assistants (CNAs) must understand how the nervous system works, recognize normal aging changes, and identify signs of neurological disorders. This knowledge is essential for observing changes in resident condition and reporting them promptly to the nurse.
Students will learn the structure and function of the nervous system, common neurological conditions, normal aging changes, and signs and symptoms that must be observed and reported.
 
Learning Goal 13.7
Identify the structure, function, common health problems, and normal aging changes of the nervous system.
 
A. Structure and Function of the Nervous System
The nervous system is responsible for receiving, processing, and responding to information from both inside and outside the body.
Key components include:
	•	Brain: Controls thoughts, memory, emotions, and voluntary and involuntary body functions.
	•	Spinal cord: Transmits messages between the brain and the rest of the body.
	•	Peripheral nerves: Carry messages to and from the brain and spinal cord to muscles and organs.
	•	Sensory receptors: Detect stimuli such as touch, pain, temperature, and position.
The primary function of the nervous system is to coordinate body activities and maintain communication throughout the body.
 
B. Age-Related Changes in the Nervous System
Normal aging can affect the nervous system in several ways, including:
	•	Slower reflexes and response time.
	•	Decreased memory and processing speed.
	•	Reduced balance and coordination.
	•	Increased risk of falls.
	•	Changes in sleep patterns.
	•	Decreased sensation, such as touch or pain perception.
These changes may increase vulnerability to injury and confusion in older adults.
 
C. Common Nervous System Health Problems and Signs & Symptoms
CNAs must recognize common neurological conditions and observe for related signs and symptoms.
	•	Cerebrovascular Accident (Stroke/CVA):
	•	Sudden weakness or numbness (often one side of the body)
	•	Slurred speech or difficulty speaking
	•	Facial drooping
	•	Confusion or loss of coordination
	•	Medical emergency requiring immediate reporting
	•	Parkinson’s Disease:
	•	Tremors (shaking)
	•	Muscle stiffness
	•	Slow movement (bradykinesia)
	•	Shuffling gait and balance problems
	•	Delirium:
	•	Sudden confusion
	•	Disorientation
	•	Fluctuating alertness
	•	Changes in behavior or attention
	•	Spinal Cord Injuries/Head Injuries:
	•	Loss of movement or sensation below injury site
	•	Weakness or paralysis
	•	Changes in consciousness or responsiveness
	•	Seizures:
	•	Sudden uncontrolled body movements
	•	Loss of consciousness
	•	Staring spells or unresponsiveness
	•	Post-seizure confusion or fatigue
	•	Multiple Sclerosis (MS):
	•	Muscle weakness
	•	Coordination problems
	•	Fatigue
	•	Vision changes
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and promptly report any neurological changes, including:
	•	Sudden weakness or paralysis
	•	Changes in speech or communication ability
	•	Confusion or disorientation
	•	Loss of balance or frequent falls
	•	Seizure activity
	•	Changes in memory or alertness
	•	Difficulty swallowing
	•	Changes in vision or coordination
	•	Sudden behavioral changes
Immediate reporting is critical, especially for signs of stroke or seizure activity.
 
Summary
The nervous system is essential for controlling all body functions, including movement, communication, and cognition. CNAs must understand how this system works, recognize normal aging changes, and identify signs of neurological disorders. By observing carefully and reporting changes promptly, nursing assistants help ensure timely intervention, resident safety, and improved health outcomes.',
   7),

  (v_mod_id,
   '13.8 — Sensory System',
   'Competency 13.8: Sensory System—Function, Structure, Health Problems, and Aging Changes
The sensory system allows individuals to see, hear, smell, taste, and feel sensations such as touch, pain, and temperature. These functions are essential for safety, communication, independence, and quality of life. Certified Nursing Assistants (CNAs) must understand how the sensory system works, recognize normal aging changes, and identify common sensory impairments. This knowledge helps CNAs provide safe care and promptly report changes in a resident’s condition.
Students will learn the structure and function of sensory organs, common sensory disorders, normal aging changes, and signs and symptoms that must be observed and reported.
 
Learning Goal 13.8
Identify the structure, function, common health problems, and normal aging changes of the sensory system.
 
A. Structure and Function of Sensory Organs
The sensory system includes specialized organs that allow the body to receive and interpret information from the environment.
Key sensory organs include:
	•	Eyes: Responsible for vision, including detecting light, color, and movement.
	•	Ears: Responsible for hearing and balance.
	•	Nose: Responsible for the sense of smell.
	•	Tongue: Responsible for taste perception.
	•	Skin and peripheral nerves: Responsible for touch, temperature, pain, and pressure sensations.
Each organ works with the nervous system to help the body respond appropriately to its environment.
 
B. Age-Related Changes in the Sensory System
As individuals age, normal changes occur that may affect sensory function, including:
	•	Decreased vision clarity and difficulty focusing.
	•	Reduced ability to see in low light conditions.
	•	Decreased hearing ability, especially high-pitched sounds.
	•	Reduced sense of smell and taste.
	•	Slower response to touch, pain, and temperature.
	•	Increased difficulty with balance and spatial awareness.
These changes may impact safety, communication, and independence.
 
C. Common Sensory System Health Problems and Signs & Symptoms
CNAs must recognize common sensory impairments and observe for related signs and symptoms.
	•	Cataracts:
	•	Cloudy or blurred vision
	•	Difficulty seeing at night
	•	Glaucoma:
	•	Gradual loss of peripheral vision
	•	Eye pain or pressure (in some cases)
	•	Macular Degeneration:
	•	Loss of central vision
	•	Difficulty reading or recognizing faces
	•	Loss of Depth Perception:
	•	Difficulty judging distances
	•	Increased risk of falls
	•	Inability to Differentiate Color:
	•	Difficulty distinguishing between colors
	•	Hearing Loss:
	•	Difficulty hearing conversations
	•	Asking others to repeat frequently
	•	Loss of Smell:
	•	Reduced ability to detect odors, including smoke or spoiled food
	•	Reduction in Sense of Taste:
	•	Decreased enjoyment of food
	•	Reduced appetite
	•	Neuropathy:
	•	Numbness, tingling, or burning sensations
	•	Decreased sensation in hands or feet
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and promptly report sensory changes, including:
	•	Sudden or gradual vision changes
	•	Difficulty hearing or responding to speech
	•	Complaints of eye pain or pressure
	•	Increased falls or balance problems
	•	Changes in appetite due to taste or smell loss
	•	Numbness, tingling, or pain in extremities
	•	Difficulty performing ADLs due to sensory loss
	•	Changes in behavior related to sensory impairment
Early reporting helps prevent injuries and supports timely intervention and treatment.
 
Summary
The sensory system is essential for helping individuals interact safely and effectively with their environment. CNAs must understand how each sensory organ functions, recognize normal aging changes, and identify common sensory disorders. By observing carefully and reporting changes promptly, nursing assistants help promote safety, independence, and quality of life for residents.',
   8),

  (v_mod_id,
   '13.9 — Gastrointestinal System',
   'Competency 13.9: Gastrointestinal System—Function, Structure, Health Problems, and Aging Changes
The gastrointestinal (GI) system is responsible for the digestion of food, absorption of nutrients, and elimination of waste. Certified Nursing Assistants (CNAs) must understand how the GI system functions, recognize normal aging changes, and identify signs of gastrointestinal disorders. This knowledge is essential for observing changes in bowel patterns, nutrition status, and overall resident health, and for reporting concerns promptly to the nurse.
Students will learn the structure and function of the gastrointestinal system, common GI disorders, normal aging changes, and signs and symptoms that must be observed and reported.
 
Learning Goal 13.9
Identify the structure, function, common health problems, and normal aging changes of the gastrointestinal system.
 
A. Structure and Function of the Gastrointestinal System
The gastrointestinal system works together to break down food, absorb nutrients, and eliminate waste from the body.
Key components include:
	•	Mouth: Begins digestion through chewing and saliva.
	•	Esophagus: Moves food from the mouth to the stomach.
	•	Stomach: Breaks down food using acids and enzymes.
	•	Small intestine: Absorbs nutrients into the bloodstream.
	•	Large intestine (colon): Absorbs water and forms stool.
	•	Rectum and anus: Store and eliminate waste from the body.
	•	Accessory organs (liver, gallbladder, pancreas): Aid in digestion by producing bile and enzymes.
The primary function of the GI system is to digest food, absorb nutrients, and eliminate waste efficiently.
 
B. Age-Related Changes in the Gastrointestinal System
Normal aging may affect digestion and elimination, including:
	•	Slower metabolism and digestion.
	•	Decreased muscle tone in the digestive tract.
	•	Reduced appetite and thirst sensation.
	•	Decreased saliva production.
	•	Increased risk of constipation.
	•	Slower movement of food through the intestines.
These changes may lead to discomfort, altered nutrition, and bowel irregularities.
 
C. Common Gastrointestinal System Health Problems and Signs & Symptoms
CNAs must recognize common GI disorders and observe for related signs and symptoms.
	•	Constipation / Fecal Impaction:
	•	Hard, infrequent stools
	•	Abdominal discomfort or bloating
	•	Straining during bowel movements
	•	No bowel movement for several days
	•	Gastroesophageal Reflux Disease (GERD):
	•	Heartburn or chest discomfort
	•	Sour taste in mouth
	•	Regurgitation of food or acid
	•	Ulcers:
	•	Burning stomach pain
	•	Nausea or vomiting
	•	Possible bleeding (dark stools)
	•	Hernias:
	•	Bulging in abdominal or groin area
	•	Pain or discomfort, especially with movement or coughing
	•	Gallbladder Disease:
	•	Pain in upper right abdomen
	•	Nausea after eating fatty foods
	•	Indigestion
	•	Diverticulitis:
	•	Abdominal pain (often lower left side)
	•	Fever
	•	Changes in bowel habits
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and promptly report changes in gastrointestinal function, including:
	•	Changes in bowel habits (constipation or diarrhea)
	•	Abdominal pain, bloating, or tenderness
	•	Nausea or vomiting
	•	Blood in stool or dark, tarry stools
	•	Loss of appetite or sudden weight changes
	•	Signs of fecal impaction
	•	Difficulty swallowing or eating
	•	Signs of dehydration related to poor intake
Early reporting helps prevent complications and supports proper treatment and comfort.
 
Summary
The gastrointestinal system plays a vital role in digestion, nutrient absorption, and waste elimination. CNAs must understand how this system works, recognize normal aging changes, and identify common gastrointestinal disorders. By observing carefully and reporting changes promptly, nursing assistants help maintain resident comfort, nutrition, and overall health.',
   9),

  (v_mod_id,
   '13.10 — Musculoskeletal System',
   'Competency 13.10: Musculoskeletal System—Function, Structure, Health Problems, and Aging Changes
The musculoskeletal system provides the body with structure, movement, and support. It includes bones, muscles, joints, ligaments, and tendons, all working together to allow mobility and maintain posture. Certified Nursing Assistants (CNAs) must understand how this system functions, recognize normal aging changes, and identify common musculoskeletal disorders. This knowledge is essential for promoting mobility, preventing injury, and reporting changes in resident condition.
Students will learn the structure and function of the musculoskeletal system, age-related changes, common disorders, and signs and symptoms that must be observed and reported.
 
Learning Goal 13.10
Identify the structure, function, common health problems, and normal aging changes of the musculoskeletal system.
 
A. Structure and Function of the Musculoskeletal System
The musculoskeletal system is responsible for movement, support, and protection of the body.
Key components include:
	•	Bones: Provide structure, protect organs, and store minerals.
	•	Muscles: Enable movement by contracting and relaxing.
	•	Joints: Where two bones meet, allowing movement.
	•	Ligaments: Connect bones to other bones and stabilize joints.
	•	Tendons: Connect muscles to bones and assist in movement.
The primary function of the musculoskeletal system is to support body structure and enable movement.
 
B. Age-Related Changes in the Musculoskeletal System
Normal aging can affect bones, muscles, and joints, leading to:
	•	Decreased bone density and increased fragility.
	•	Loss of muscle mass and strength.
	•	Reduced flexibility and joint mobility.
	•	Slower movement and decreased coordination.
	•	Increased risk of falls and fractures.
	•	Joint stiffness and discomfort.
These changes may impact independence and mobility in older adults.
 
C. Common Musculoskeletal System Health Problems and Signs & Symptoms
CNAs must recognize common musculoskeletal conditions and observe for related signs and symptoms.
	•	Arthritis:
	•	Joint pain, swelling, and stiffness
	•	Limited range of motion
	•	Osteoporosis:
	•	Brittle, fragile bones
	•	Increased risk of fractures, especially in hips, spine, and wrists
	•	Fractures:
	•	Pain, swelling, and deformity
	•	Loss of movement or function in affected area
	•	Amputations:
	•	Loss of a limb due to injury or disease
	•	Need for adaptive equipment and support with mobility
	•	Complications of Bed Rest:
	•	Muscle weakness and atrophy
	•	Joint stiffness and contractures
	•	Pressure injuries
	•	Decreased circulation
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and promptly report musculoskeletal changes, including:
	•	Pain in joints, muscles, or bones
	•	Swelling, redness, or deformity
	•	Decreased ability to move or perform ADLs
	•	Difficulty walking or increased risk of falls
	•	Loss of balance or coordination
	•	Signs of fractures or injury
	•	Muscle weakness or stiffness
	•	Changes in mobility or tolerance to activity
Early reporting helps prevent further injury and supports effective treatment and rehabilitation.
 
Summary
The musculoskeletal system is essential for movement, stability, and independence. CNAs must understand how bones, muscles, and joints function, recognize normal aging changes, and identify common musculoskeletal disorders. By observing carefully and reporting changes promptly, nursing assistants help promote mobility, prevent complications, and maintain resident safety and quality of life.',
   10),

  (v_mod_id,
   '13.11 — Reproductive System',
   'Competency 13.11: Reproductive System—Function, Structure, Health Problems, and Aging Changes
The reproductive system is responsible for reproduction and the production of hormones that influence sexual development and overall health. Although CNAs do not provide diagnostic or specialized reproductive care, they must understand the basic structure and function of this system, recognize normal age-related changes, and identify common health concerns. This knowledge supports respectful, dignified care and helps ensure that changes in a resident’s condition are reported promptly.
Students will learn the structure and function of the reproductive system, normal aging changes, common health problems, and signs and symptoms that must be observed and reported.
 
Learning Goal 13.11
Identify the structure, function, common health problems, and normal aging changes of the reproductive system.
 
A. Structure and Function of the Reproductive System
The reproductive system includes organs that support reproduction and hormone production.
Male reproductive system components include:
	•	Testes: Produce sperm and testosterone.
	•	Scrotum: Holds and protects the testes.
	•	Prostate gland: Produces fluid that supports sperm.
	•	Penis: Delivers sperm during reproduction.
Female reproductive system components include:
	•	Ovaries: Produce eggs and hormones (estrogen and progesterone).
	•	Fallopian tubes: Carry eggs to the uterus.
	•	Uterus: Supports pregnancy.
	•	Vagina: Passage for childbirth and menstrual flow.
The primary functions of the reproductive system include reproduction, hormone regulation, and sexual health.
 
B. Age-Related Changes in the Reproductive System
Normal aging affects reproductive function in both males and females:
	•	Females:
	•	Menopause (end of menstrual cycles)
	•	Decreased estrogen levels
	•	Vaginal dryness and thinning of tissues
	•	Increased risk of infection
	•	Males:
	•	Decreased testosterone levels
	•	Enlarged prostate gland
	•	Reduced sexual function
	•	Changes in urinary function
These changes are natural but may contribute to discomfort or health concerns.
 
C. Common Reproductive System Health Problems and Signs & Symptoms
CNAs must be aware of common reproductive conditions and observe for related signs and symptoms.
	•	Benign Prostatic Hyperplasia (BPH):
	•	Enlarged prostate gland in males
	•	Difficulty starting or stopping urination
	•	Frequent urination, especially at night
	•	Weak urine stream
	•	Prolapsed Uterus:
	•	Uterus drops into the vaginal canal
	•	Feeling of pelvic pressure or fullness
	•	Difficulty with urination or bowel movements
	•	Vaginitis:
	•	Inflammation or infection of the vagina
	•	Itching, burning, or discomfort
	•	Abnormal discharge or odor
 
D. Signs and Symptoms to Observe and Report
CNAs must carefully observe and promptly report any changes related to reproductive health, including:
	•	Pain or discomfort in pelvic or genital areas
	•	Abnormal discharge or odor
	•	Difficulty urinating or changes in urinary patterns
	•	Swelling, redness, or irritation
	•	Complaints of pressure or fullness in pelvic region
	•	Signs of infection (fever, pain, or inflammation)
	•	Changes in skin integrity in genital or perineal area
All observations must be reported to the nurse using appropriate facility procedures while maintaining resident dignity and privacy.
 
Summary
The reproductive system plays an important role in hormone regulation and overall health. CNAs must understand its structure and function, recognize normal aging changes, and identify common health problems. By observing carefully, respecting privacy, and reporting changes promptly, nursing assistants support resident dignity, comfort, and safety.',
   11);

  RAISE NOTICE 'Module 13 updated with 11 lessons.';
END $$;
