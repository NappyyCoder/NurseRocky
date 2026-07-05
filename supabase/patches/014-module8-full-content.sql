-- ============================================================
-- Nurse Rocky — Patch 014: Module 8 Full Content
-- "Applies the Principles of Basic Nutrition to Resident Care"
-- Source: 8.0 Competency Applies the Principles of Basic Nutrition to Resident Care.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 8;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 8 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Applies the Principles of Basic Nutrition to Resident Care',
    description = 'Essential nutrients, dietary variations, age-related nutrition challenges, hydration and I&O, feeding assistance, and therapeutic diets.',
    is_published = true,
    lessons_count = 6
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '8.1 — Principles of Nutrition and Essential Nutrients',
   '8.0 Competency: Applies the Principles of Basic Nutrition to Resident Care
Certified Nursing Assistant (CNA) students must understand the basic principles of nutrition and how proper dietary intake supports health, healing, and overall well-being. Nutrition plays a critical role in maintaining energy, supporting body functions, preventing illness, and promoting recovery in residents across all age groups.
CNAs assist residents in meeting nutritional needs by providing support with meals, monitoring intake, and reporting concerns related to appetite, weight changes, or dietary tolerance. Understanding basic nutrition helps CNAs contribute to safe, effective, and person-centered care.
 
8.1 Identifies Principles of Nutrition
 
A. Six Basic Essential Nutrient Groups and Their Use in the Body
CNA students must understand the six essential nutrient groups and their basic functions:
	•	Carbohydrates
	•	Main source of energy for the body and brain.
	•	Found in grains, fruits, vegetables, and sugars.
	•	Fats
	•	Provide long-term energy storage and support cell function.
	•	Help the body absorb certain vitamins.
	•	Proteins
	•	Build and repair body tissues.
	•	Support muscle growth, healing, and immune function.
	•	Vitamins
	•	Support metabolism and body processes.
	•	Help maintain healthy skin, bones, and immune system.
	•	Minerals
	•	Support bone health, fluid balance, and nerve function.
	•	Examples include calcium, iron, and potassium.
	•	Water
	•	Essential for hydration, circulation, digestion, and temperature regulation.
	•	Helps transport nutrients and remove waste from the body.
 
B. Basic Food Groups (Food Pyramid)
CNA students must understand that a balanced diet includes all food groups in appropriate proportions. The traditional food pyramid (or MyPlate model) includes:
	•	Grains: Bread, rice, pasta, cereals (energy source)
	•	Vegetables: Leafy greens, carrots, broccoli (vitamins and minerals)
	•	Fruits: Apples, bananas, berries (vitamins, fiber, hydration)
	•	Protein foods: Meat, poultry, fish, beans, eggs, nuts (body building and repair)
	•	Dairy: Milk, cheese, yogurt (calcium and bone health)
	•	Fats and oils: Used in small amounts for energy and nutrient absorption
 
C. Physiologic Need for Nutrients
CNA students must understand why the body needs nutrients:
	•	To provide energy for daily activities.
	•	To support growth and tissue repair.
	•	To maintain immune system function.
	•	To regulate body processes such as digestion and temperature.
	•	To support brain function and emotional well-being.
	•	To prevent malnutrition and disease.
Older adults may have increased nutritional needs due to illness, decreased appetite, or difficulty eating, making CNA support especially important.
 
D. Examples of Serving Sizes
CNA students should understand that serving sizes refer to standard portions used to guide healthy eating. Examples include:
	•	1 slice of bread or ½ cup cooked rice or pasta (grain serving)
	•	1 cup raw vegetables or ½ cup cooked vegetables (vegetable serving)
	•	1 medium fruit (such as an apple or banana)
	•	3 ounces of meat, poultry, or fish (protein serving)
	•	1 cup of milk or yogurt (dairy serving)
	•	1–2 teaspoons of oil or butter (fat serving)
Serving sizes help ensure residents receive balanced nutrition without overeating or undernourishing.
 
Key Concepts for CNA Students
	•	Nutrition is essential for energy, healing, and overall health.
	•	The six nutrient groups each serve specific functions in the body.
	•	Balanced intake from all food groups supports optimal health.
	•	Proper portion sizes help maintain nutritional balance.
	•	CNAs play a key role in supporting residents’ dietary needs and monitoring intake.
	•	Changes in appetite, weight, or eating habits must be reported promptly.
By applying basic nutrition principles, CNA students help promote health, prevent malnutrition, and support residents in achieving optimal physical and emotional well-being.',
   1),

  (v_mod_id,
   '8.2 — Personal, Cultural, Religious, and Medical Diet Variations',
   '8.2 Competency: Recognizes Personal, Cultural, Religious, and Medical Conditions Leading to Variations in the Diet
Certified Nursing Assistant (CNA) students must understand that each resident has unique dietary needs and preferences influenced by personal choices, cultural traditions, religious beliefs, and medical conditions. Respecting these variations is essential to providing dignified, person-centered care and ensuring residents receive nutrition in a way that supports both their health and personal identity.
CNAs play an important role in honoring dietary preferences, assisting with meal support, and reporting concerns related to food intake, allergies, or restrictions to the supervising nurse or dietary staff.
 
A. Personal Choices
CNA students must recognize that residents have the right to make individual choices about their food intake. These may include:
	•	Preferences for certain foods or refusal of others.
	•	Choices related to portion sizes or meal timing.
	•	Decisions about eating habits based on lifestyle or comfort.
Residents should be supported in making safe food choices whenever possible.
 
B. Cultural Choices
CNA students must respect cultural traditions that influence dietary habits. These may include:
	•	Traditional foods specific to cultural backgrounds.
	•	Dietary patterns such as vegetarianism or avoidance of certain ingredients.
	•	Customs related to meal preparation or eating practices.
Cultural sensitivity helps promote dignity and trust in care.
 
C. Religious Teachings
CNA students must be aware that religious beliefs may influence diet, including:
	•	Fasting periods or dietary restrictions.
	•	Avoidance of certain foods (such as pork or beef).
	•	Requirements for specific food preparation methods (such as halal or kosher diets).
CNAs must respect and support these practices while ensuring residents’ nutritional needs are met.
 
D. Personal Preferences for Food Preparation
CNA students should understand that residents may have preferences regarding how food is prepared or served, such as:
	•	Preference for soft, pureed, or chopped foods.
	•	Temperature preferences (hot, cold, room temperature).
	•	Preference for seasoning, texture, or presentation.
Accommodating these preferences when possible helps improve appetite and nutritional intake.
 
E. Food Allergies and Intolerances
CNA students must recognize that some residents have medical conditions requiring strict dietary precautions, including:
	•	Food allergies that may cause severe reactions (e.g., peanuts, shellfish, dairy).
	•	Food intolerances that cause discomfort or digestive issues (e.g., lactose intolerance).
	•	Medically ordered diets for conditions such as diabetes, heart disease, or swallowing disorders.
CNAs must:
	•	Follow dietary orders carefully.
	•	Never offer foods outside of prescribed diets.
	•	Report any signs of allergic reaction or intolerance immediately to the nurse.
 
Key Concepts for CNA Students
	•	Each resident has unique dietary needs based on personal, cultural, religious, and medical factors.
	•	Respect for dietary preferences supports dignity and person-centered care.
	•	Food allergies and medical restrictions must always be taken seriously.
	•	CNAs must follow dietary care plans and report concerns promptly.
	•	Communication with dietary staff and nurses is essential for safe nutrition care.
By recognizing and respecting dietary variations, CNA students help ensure safe, individualized, and culturally competent nutrition care for every resident.',
   2),

  (v_mod_id,
   '8.3 — Age-Related Dietary Problems and Remedies',
   '8.3 Competency: Describes Contributory Factors and Remedies to Address Age-Related Dietary Problems
Certified Nursing Assistant (CNA) students must understand that aging can significantly affect a resident’s ability to maintain adequate nutrition and hydration. Age-related physical, emotional, cognitive, and medical changes can influence appetite, food intake, and overall nutritional status. CNAs play an essential role in recognizing these challenges, supporting residents during meals, and reporting concerns to the supervising nurse.
 
A. Age-Related Factors That Influence Adequate Dietary Intake
CNA students must recognize common age-related dietary problems, including:
	•	Loss of appetite: Reduced desire to eat, often leading to decreased calorie intake.
	•	Reduced sense of taste: Food may seem less appealing, leading to decreased eating.
	•	Loss of dentation (teeth): Difficulty chewing certain foods.
	•	Denture problems: Ill-fitting dentures causing discomfort or difficulty eating.
	•	Dehydration: Inadequate fluid intake due to reduced thirst sensation or forgetfulness.
	•	Malnutrition: Lack of essential nutrients due to poor intake or absorption.
	•	Severe weight loss: Often linked to chronic illness, depression, or poor intake.
	•	Severe weight gain: May result from medication effects, inactivity, or poor dietary balance.
CNAs must observe and report changes in eating patterns, weight, and fluid intake promptly.
 
B. Situational Factors That Influence or Interfere with Adequate Intake
CNA students must also understand situational and medical conditions that can affect nutrition, including:
	•	Ileostomies: May affect digestion and food tolerance.
	•	Dysphagia (difficulty swallowing): Increases risk of choking and aspiration.
	•	Confusion or cognitive impairment: May lead to forgetting to eat or difficulty recognizing food.
	•	Medications: Can reduce appetite, alter taste, or cause nausea.
	•	Depression: Often results in decreased interest in eating.
	•	Grief: Emotional distress can reduce appetite and intake.
	•	Immobility: May limit ability to access or consume food independently.
These conditions require careful observation and support from the CNA.
 
C. Nursing Assistant Care to Support Dietary Needs
CNA students must provide supportive care that promotes safe and adequate nutrition, including:
	•	Socialization: Encouraging residents to eat in dining areas when appropriate to improve appetite.
	•	Atmosphere: Creating a calm, pleasant, and distraction-free eating environment.
	•	Presentation of food: Making meals visually appealing to encourage intake.
	•	Variety of seasonings: Enhancing flavor to improve appetite when allowed.
	•	Oral inspection and hygiene: Ensuring the mouth is clean and comfortable before meals.
	•	Denture care: Assisting with proper cleaning and fitting of dentures.
	•	Adequate fluid intake: Offering a variety of fluids throughout the day to prevent dehydration.
	•	Comfort foods: Providing familiar foods when permitted to encourage eating.
	•	Thickened liquids: Using ordered consistencies for residents with swallowing difficulties.
	•	Liberalized diets: Supporting less restrictive diets when medically approved to improve intake and quality of life.
 
Key Concepts for CNA Students
	•	Aging can significantly impact nutrition, appetite, and hydration.
	•	CNAs must recognize both physical and emotional factors affecting dietary intake.
	•	Early identification of dietary problems helps prevent serious complications.
	•	Supportive care includes environment, presentation, and emotional encouragement.
	•	Special diets and swallowing precautions must always be followed exactly as ordered.
	•	Changes in weight, appetite, or fluid intake must be reported promptly.
By understanding age-related dietary challenges and providing supportive interventions, CNA students help ensure residents receive adequate nutrition, maintain health, and experience improved quality of life.',
   3),

  (v_mod_id,
   '8.4 — Providing and Restricting Fluids as Ordered',
   '8.4 Competency: Provides and Restricts Fluids as Ordered
Certified Nursing Assistant (CNA) students must understand the importance of maintaining proper hydration and following fluid orders as prescribed by the healthcare team. Fluids are essential for maintaining normal body function, supporting circulation, regulating temperature, and preventing complications such as dehydration or fluid overload. CNAs play a key role in encouraging adequate fluid intake, accurately measuring intake and output, and following any prescribed fluid restrictions.
 
A. Identifies Need for Adequate Hydration
CNA students must recognize that adequate hydration is essential for health and survival. Proper fluid balance helps:
	•	Maintain blood circulation and blood pressure
	•	Support kidney function and waste removal
	•	Regulate body temperature
	•	Aid digestion and nutrient absorption
	•	Prevent confusion, weakness, and urinary tract infections
The body signals thirst as a natural response to dehydration; however, older adults may have a decreased thirst sensation, increasing their risk for dehydration. CNAs must encourage regular fluid intake even when residents do not feel thirsty.
 
B. Lists Sources of Fluid Intake
CNA students must understand that fluids come from multiple sources, including:
	•	Oral fluids
	•	Water, juice, milk, soups, and other beverages
	•	Food
	•	Fruits and vegetables with high water content (e.g., watermelon, oranges, cucumbers)
	•	Soups, gelatin, and other moist foods
	•	Intravenous (IV) fluids
	•	Fluids administered directly into the bloodstream under medical supervision
CNAs are responsible for encouraging oral intake and monitoring all sources of fluid consumption.
 
C. Importance of Measuring Intake and Output (I&O)
CNA students must understand that accurate measurement of intake and output is essential for monitoring a resident’s fluid balance and overall health status.
Importance of I&O includes:
	•	Detecting dehydration or fluid overload early
	•	Monitoring kidney function and urinary output
	•	Assisting in treatment planning by the healthcare team
	•	Ensuring safe recovery in medically fragile residents
Components of Intake and Output:
	•	Intake: All fluids taken in orally, including liquids in foods such as soups, ice cream, and gelatin
	•	Output: All fluids eliminated from the body, primarily urine and other measurable excretions
Measurement Skills:
CNA students must be able to:
	•	Use standard measurement tools (graduated containers, measuring cups)
	•	Convert measurements accurately (e.g., ounces, milliliters, liters)
	•	Record intake and output precisely according to facility policy
 
D. Lists Sources of Fluid Output
CNA students must understand that fluid is eliminated from the body through several routes, including:
	•	Lungs
	•	Water vapor lost through breathing
	•	Skin
	•	Sweat and insensible fluid loss through the skin
	•	Kidneys
	•	Urine production (primary route of fluid excretion)
	•	Intestines
	•	Fluid loss through stool
Monitoring output helps the healthcare team assess hydration status and detect possible health concerns.
 
Key Concepts for CNA Students
	•	Adequate hydration is essential for normal body function and health.
	•	CNAs must encourage fluid intake unless restricted by medical orders.
	•	Fluids come from oral intake, food, and IV therapy.
	•	Accurate intake and output measurement is a critical nursing assistant responsibility.
	•	The body loses fluids through the lungs, skin, kidneys, and intestines.
	•	Fluid restrictions must always be followed exactly as ordered.
	•	All changes in hydration status must be reported promptly.
By supporting hydration needs and accurately monitoring fluid balance, CNA students help prevent complications and promote safe, effective, and high-quality resident care.',
   4),

  (v_mod_id,
   '8.5 — Care for Residents Unable to Obtain Nutrition Independently',
   '8.5 Competency: Demonstrates Care for Residents Who Have an Inability to Obtain Adequate Nutrition or Fluids Independently
Certified Nursing Assistant (CNA) students must understand how to safely and effectively assist residents who are unable to obtain adequate nutrition or hydration on their own. Many residents require partial or full assistance with eating and drinking due to physical limitations, cognitive impairment, illness, or age-related changes. CNAs play a vital role in ensuring residents receive proper nourishment and fluids while maintaining dignity, independence, and safety.
 
A. Provides Food and Fluids to Residents
CNA students must be able to safely provide food and fluids by:
	•	Delivering meal trays accurately and in a timely manner.
	•	Ensuring residents receive the correct diet as ordered.
	•	Offering fluids regularly throughout the shift.
	•	Assisting residents who are unable to eat or drink independently.
	•	Respecting resident preferences and encouraging participation in meals when possible.
CNAs must always verify resident identity and diet consistency before providing food or fluids.
 
B. Provides Adequate Nutrition for Cognitively Impaired Residents
CNA students must understand that cognitively impaired residents may require additional support to maintain adequate intake. Care should include:
	•	Providing simple, step-by-step verbal cues during meals.
	•	Offering one food item at a time to reduce confusion.
	•	Using calm, reassuring communication.
	•	Assisting with hand-over-hand feeding techniques when appropriate.
	•	Minimizing distractions in the environment during meals.
	•	Encouraging familiar foods and routines when possible.
These interventions help promote safety, reduce anxiety, and improve nutritional intake.
 
C. Observes and Records Food and Fluid Intake as Ordered
CNA students must accurately observe and document intake as directed by facility policy and nursing instructions. This includes:
	•	Estimating and recording percentage of food consumed (e.g., 25%, 50%, 75%, 100%).
	•	Recording fluid intake from all sources, including beverages and soups.
	•	Reporting refusals or poor intake to the supervising nurse.
	•	Noting changes in appetite or eating patterns.
	•	Ensuring documentation is accurate, timely, and objective.
 
Nursing Assistant Responsibilities to Promote Adequate Fluid and Food Intake
 
A. Tasks That May Be Performed by the CNA
	•	Before meal hygiene
	•	Provide handwashing and oral care before meals to promote comfort and appetite.
	•	Position of resident to prevent aspiration
	•	Ensure the resident is sitting upright before and during meals.
	•	Serving food trays
	•	Deliver correct trays and assist with setup as needed.
	•	Feeding a resident
	•	Provide assistance safely, using proper technique and pacing.
	•	Use of assistive devices
	•	Provide adaptive utensils, cups, and feeding tools as needed.
	•	Adequate fluid intake or restriction compliance
	•	Encourage fluids or follow prescribed fluid restrictions carefully.
	•	Encouraging independence
	•	Allow residents to feed themselves whenever possible while offering support.
	•	Post-meal hygiene
	•	Provide oral care and clean residents after meals as needed.
	•	Returning trays
	•	Remove and return meal trays according to facility policy.
 
B. Additional Feeding Support Techniques
CNA students should also use:
	•	Verbal cueing and encouragement during meals.
	•	Hand-over-hand assistance when appropriate.
	•	Setting up trays for easy access and visibility.
	•	Removing unnecessary utensils to reduce confusion.
	•	Offering finger foods for residents with difficulty using utensils.
	•	Creating a calm, comfortable dining environment.
	•	Respecting resident food preferences when possible.
 
C. Observations, Reporting, and Intake Estimation
CNA students must:
	•	Observe and record the percentage of food and fluids consumed.
	•	Report poor intake, refusal to eat, or difficulty swallowing immediately.
	•	Monitor for signs of dehydration or malnutrition.
	•	Document changes in appetite or eating behavior accurately.
	•	Communicate concerns promptly to the supervising nurse.
 
Key Concepts for CNA Students
	•	Proper nutrition and hydration are essential for resident health and recovery.
	•	CNAs must provide safe, respectful assistance with meals and fluids.
	•	Residents should be encouraged to maintain independence whenever possible.
	•	Accurate documentation of intake is a critical responsibility.
	•	Special techniques may be needed for cognitively impaired residents.
	•	Changes in eating or drinking patterns must be reported immediately.
By providing compassionate feeding assistance and monitoring intake carefully, CNA students help ensure residents receive the nutrition and hydration needed to maintain health, dignity, and quality of life.',
   5),

  (v_mod_id,
   '8.6 — Therapeutic Diets and Alternate Feeding Methods',
   '8.6 Competency: Identifies Therapeutic Diets
Certified Nursing Assistant (CNA) students must understand the different types of therapeutic diets and food consistencies used in healthcare settings. Therapeutic diets are medically prescribed meal plans designed to meet specific health needs, manage medical conditions, and promote healing. CNAs play an important role in ensuring residents receive the correct diet as ordered and that food is served safely and appropriately.
CNAs must always follow dietary orders exactly and report any concerns related to diet tolerance, intake, or resident safety to the supervising nurse.
 
A. Identifies Types of Food Consistencies
CNA students must understand that food consistency refers to the texture of food provided based on a resident’s ability to chew and swallow safely.
	•	Regular Diet
	•	No restrictions; includes a variety of normal-textured foods.
	•	Soft Mechanical Diet
	•	Foods that are easy to chew and swallow; may be chopped or ground.
	•	Pureed Diet
	•	Foods blended into a smooth consistency for residents with swallowing difficulties.
	•	Liquid Diet
	•	Includes fluids only; may be clear or full liquids depending on order.
 
B. Conditions for Which Therapeutic Diets Are Prescribed
CNA students must recognize that therapeutic diets are ordered based on specific medical conditions, such as:
	•	Difficulty swallowing (dysphagia)
	•	Diabetes mellitus
	•	Heart disease or high blood pressure
	•	Kidney disease
	•	Gastrointestinal disorders
	•	Post-surgical recovery
	•	Nutritional deficiencies or malnutrition
	•	Obesity or weight management needs
 
Common Therapeutic Diets and Their Purpose
	•	Clear Liquid Diet
	•	Used after surgery or during acute illness; includes broth, gelatin, and clear juices.
	•	Full Liquid Diet
	•	Includes all liquids plus foods that become liquid at room temperature.
	•	Soft Diet
	•	Easy-to-chew foods for residents with dental or swallowing issues.
	•	Bland Diet
	•	Non-irritating foods for digestive disorders.
	•	Low Sodium Diet
	•	Limits salt to manage blood pressure and fluid retention.
	•	Cardiac Diet
	•	Designed to support heart health; low in fat, cholesterol, and sodium.
	•	Carbohydrate-Controlled Diet
	•	Used for residents with diabetes to manage blood sugar levels.
	•	Regular Diet
	•	No restrictions; balanced diet for general health.
	•	Renal Diet
	•	Limits sodium, potassium, protein, and fluids for kidney disease.
	•	Special Nutritional Diet
	•	Customized diets based on individual medical or nutritional needs.
	•	High Fiber vs. Low Fiber Diet
	•	High fiber supports digestion; low fiber may be used after surgery or for certain conditions.
	•	Supplementary Nutrition
	•	Nutritional shakes, supplements, or fortified foods used to increase calorie or nutrient intake.
 
C. Identifies Alternate Feeding Methods
CNA students must understand that some residents cannot safely eat by mouth and may require alternative feeding methods.
	•	Feeding Tubes
	•	Tubes inserted into the stomach or small intestine (e.g., NG tube, PEG tube).
	•	Used when residents cannot swallow safely or meet nutritional needs orally.
	•	Care Associated with Feeding Tubes
	•	Keep head of bed elevated during and after feeding.
	•	Observe for signs of discomfort or complications.
	•	Do not alter or disconnect feeding equipment.
	•	Report redness, leakage, or tube displacement immediately.
	•	Care Associated with IV Lines
	•	IV lines provide fluids or nutrition directly into the bloodstream.
	•	Avoid pulling, bending, or disturbing IV lines.
	•	Observe the site for redness, swelling, or leakage.
	•	Report any abnormalities to the nurse immediately.
 
Key Concepts for CNA Students
	•	Therapeutic diets are medically ordered and must be followed exactly.
	•	Food consistency must match the resident’s swallowing ability for safety.
	•	Different medical conditions require specialized diets.
	•	CNAs must ensure correct meal delivery and assist residents appropriately.
	•	Alternative feeding methods require careful observation and reporting.
	•	Safety, accuracy, and communication are essential in dietary care.
By understanding therapeutic diets and feeding methods, CNA students help ensure residents receive safe, appropriate, and individualized nutritional care that supports health and recovery.',
   6);

  RAISE NOTICE 'Module 8 updated with 6 lessons.';
END $$;
