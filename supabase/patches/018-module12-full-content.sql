-- ============================================================
-- Nurse Rocky — Patch 018: Module 12 Full Content
-- "Cares for Cognitively Impaired Residents"
-- Source: 12.0 Competency Cares for Cognitively Impaired Residents.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 12;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 12 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Cares for Cognitively Impaired Residents',
    description = 'Dementia and delirium, cognitive effects on ADLs, communication strategies, behavioral interventions, and reporting changes in cognitively impaired residents.',
    is_published = true,
    lessons_count = 3
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '12.1 — Unique Needs of Cognitively Impaired Residents',
   'Competency 12.0: Cares for Cognitively Impaired Residents
Caring for residents with cognitive impairment requires patience, understanding, and specialized communication skills. Certified Nursing Assistants (CNAs) play a vital role in supporting individuals with dementia, Alzheimer’s disease, and delirium by providing safe, structured, and respectful care. Cognitive impairment can affect memory, judgment, communication, and the ability to perform daily activities, making consistent, person-centered care essential.
Students will learn how to identify types and causes of cognitive impairment, understand how these conditions affect daily functioning, and apply effective communication and care strategies to meet the unique needs of cognitively impaired residents.
 
Learning Goal 12.1
Address the unique needs and behaviors of individuals with dementia (Alzheimer’s and other forms) and delirium.
 
A. Types of Cognitive Impairment
Cognitive impairment refers to conditions that affect thinking, memory, awareness, and behavior.
Common types include:
	•	Dementia: A chronic, progressive decline in memory, thinking, and reasoning.
	•	Delirium: A sudden, often reversible change in mental status caused by an underlying medical condition.
	•	Varying levels of consciousness: Changes in alertness that may affect awareness and responsiveness.
 
B. Effects of Cognitive Impairment on Activities of Daily Living (ADLs)
Cognitive impairment can significantly impact a resident’s ability to perform ADLs, including:
	•	Difficulty remembering how to complete tasks (bathing, dressing, eating)
	•	Poor judgment or unsafe decision-making
	•	Loss of problem-solving ability
	•	Communication challenges, including word-finding difficulty
	•	Reduced attention span and concentration
	•	Increased dependence on caregivers for basic needs
CNAs must provide guidance and assistance while encouraging independence whenever possible.
 
C. Common Diseases That Cause Dementia (Non-Reversible)
Several progressive conditions can lead to dementia, including:
	•	Alzheimer’s disease
	•	Lewy body dementia
	•	Parkinson’s disease
	•	Vascular dementia
	•	Frontotemporal dementia
These conditions are generally irreversible and progressively affect memory, behavior, and cognitive function.
 
D. Illness and Health Issues That Cause Delirium (Reversible Causes)
Delirium often has sudden onset and may improve when the underlying cause is treated. Common causes include:
	•	Medication side effects or interactions
	•	Poor nutrition or dehydration (including alcohol misuse or withdrawal)
	•	Fever, infections, or anemia
	•	Emotional stress, depression, grief, or fatigue
	•	Injury, surgery, or hospitalization
Early identification and reporting of delirium symptoms are critical for resident recovery.
 
E. Environmental Factors That Contribute to Cognitive Changes
The environment can significantly affect cognition and behavior. Contributing factors include:
	•	Unfamiliar or overly large environments
	•	Cluttered or disorganized spaces
	•	Lack of environmental cues (clocks, calendars, signage)
	•	Overstimulation (noise, crowds, activity)
	•	Understimulation (isolation, boredom)
	•	Disruption of routine
	•	Excessive or constant television noise
CNAs should help create calm, structured, and familiar environments to support cognitive stability.
 
F. Unique Needs of Residents with Cognitive Impairment
Residents with cognitive impairment require individualized care that addresses physical, emotional, social, and safety needs.
Key needs include:
	•	Communication support: Simple, clear, and calm communication
	•	ADL assistance: Step-by-step guidance and encouragement
	•	Social interaction: Opportunities to reduce isolation
	•	Meaningful activities: Activities tailored to abilities and interests
	•	Diversions and reassurance: Redirection during confusion or agitation
	•	Safety measures: Prevention of wandering, falls, and injury
 
G. Communication Techniques with Cognitively Impaired Residents
Effective communication is essential for providing safe and respectful care. CNAs should:
	•	Use simple, short sentences and speak slowly.
	•	Maintain eye contact and a calm tone.
	•	Use the resident’s name and introduce themselves.
	•	Ask one question at a time.
	•	Allow extra time for responses.
	•	Avoid arguing or correcting the resident unnecessarily.
	•	Use visual cues, gestures, and demonstration when helpful.
	•	Redirect rather than confront confusion or agitation.
	•	Reassure the resident frequently to reduce anxiety.
 
Summary
Caring for cognitively impaired residents requires specialized knowledge, patience, and compassionate communication. CNAs must understand the differences between dementia and delirium, recognize contributing causes, and adapt care to meet individual needs. By providing structured routines, supportive communication, and a safe environment, nursing assistants promote dignity, reduce confusion, and improve quality of life for residents with cognitive impairment.',
   1),

  (v_mod_id,
   '12.2 — Responding to Behavior of Cognitively Impaired Residents',
   'Competency 12.2: Respond Appropriately to the Behavior of Cognitively Impaired Residents
Cognitively impaired residents may display a wide range of behaviors due to changes in memory, perception, judgment, and communication. Certified Nursing Assistants (CNAs) must understand that these behaviors are often expressions of unmet needs rather than intentional actions. Responding appropriately helps reduce distress, maintain safety, and support dignity for residents with dementia, Alzheimer’s disease, and other cognitive conditions.
Students will learn how to identify common behaviors associated with cognitive impairment and apply safe, respectful interventions that support resident well-being and reduce behavioral symptoms.
 
Learning Goal 12.2
Respond appropriately to behaviors of cognitively impaired residents using safe and therapeutic interventions.
 
A. Behaviors Demonstrated by Individuals with Cognitive Impairment
Cognitively impaired residents may exhibit a variety of behaviors that can change throughout the day or over time. These behaviors may include:
	•	Resistance to care: Refusing bathing, dressing, or assistance due to fear or confusion.
	•	Forgetfulness and confusion: Difficulty remembering people, places, or daily routines.
	•	Agitation: Restlessness, anxiety, or emotional distress.
	•	Hoarding/Rummaging: Collecting or hiding items, often driven by insecurity or memory loss.
	•	Shadowing: Following staff closely due to fear of being alone.
	•	Wandering and pacing: Moving aimlessly, often seeking something familiar.
	•	Hallucinations, delusions, and paranoia: Seeing or believing things that are not real.
	•	Sundowning: Increased confusion or agitation during late afternoon or evening hours.
	•	Perseveration: Repeating words, questions, or actions.
	•	Aggression (physical or verbal): Hitting, yelling, or threatening behavior.
	•	Sexual behavior (disinhibition): Inappropriate sexual comments or actions due to cognitive decline.
CNAs must remain calm, nonjudgmental, and focused on resident safety when these behaviors occur.
 
B. Interventions to Reduce the Effects of Cognitive Impairment
CNAs use therapeutic communication and structured care strategies to reduce confusion, anxiety, and unsafe behaviors.
Effective interventions include:
	•	Approach strategies: Approach slowly, calmly, and from the front using the resident’s name.
	•	Knowing the resident: Understand personal history, preferences, and triggers.
	•	Following the care plan: Provide consistent care and encourage independence whenever possible.
	•	Set routine and consistency: Maintain regular schedules for toileting, meals, and hygiene.
	•	Verbal cueing with praise/reward: Give simple instructions and positive reinforcement.
	•	Manual cueing with praise/reward: Gently guide movements when needed.
	•	Joining their reality: Do not argue; instead, enter the resident’s perception.
	•	Validation therapy: Acknowledge feelings rather than correcting false beliefs.
	•	Reminiscence therapy: Encourage discussion of past memories and familiar experiences.
	•	Activities: Provide meaningful, structured activities to reduce boredom and anxiety.
	•	Music therapy: Use calming or familiar music to reduce agitation.
	•	Sensory stimulation: Use appropriate touch, objects, or environmental cues.
	•	Safety measures: Ensure a safe environment free from hazards.
	•	Simple, time-appropriate environment: Reduce clutter and confusion with clear cues.
	•	Understanding behaviors as unmet needs: Recognize that behaviors often signal hunger, pain, fear, or discomfort.
	•	Ignoring safely inappropriate behaviors: Redirect attention when behavior is non-harmful.
	•	Offering choices: Provide limited, simple choices to promote control.
	•	Avoiding restraints: Use alternative interventions whenever possible.
	•	Mobility alarms: Use safety devices to prevent wandering or falls when appropriate.
	•	Responding to sexual behaviors: Redirect calmly, maintain professionalism, and report concerns as needed.
 
Summary
Cognitively impaired behaviors are often a form of communication that reflects unmet physical, emotional, or environmental needs. CNAs must respond with patience, understanding, and appropriate interventions that prioritize safety and dignity. By using structured routines, therapeutic communication, and individualized care approaches, nursing assistants can reduce distress and improve quality of life for residents with cognitive impairment.',
   2),

  (v_mod_id,
   '12.3 — Reporting Behaviors and Resident Responses',
   'Competency 12.3: Reports Behaviors and Resident Responses
Certified Nursing Assistants (CNAs) play a critical role in observing and reporting changes in the behavior and condition of cognitively impaired residents. Accurate and timely reporting helps the healthcare team identify changes in health status, adjust care plans, and ensure resident safety and well-being. CNAs do not diagnose or interpret conditions, but they are responsible for reporting what they observe.
Students will learn when and how to report behavioral changes, declines in function, and responses to behavioral interventions in cognitively impaired residents.
 
Learning Goal 12.3
Report behaviors and resident responses accurately and promptly to the appropriate healthcare team members.
 
A. New or Increased Changes in Behavior
CNAs must report any new behaviors or noticeable increases in existing behaviors, as these may indicate changes in a resident’s physical or mental condition.
Examples include:
	•	Sudden onset of confusion or disorientation
	•	Increased agitation or aggression
	•	New wandering or pacing behaviors
	•	Increased resistance to care
	•	New hallucinations, delusions, or paranoia
	•	Sudden withdrawal or social isolation
These changes may signal illness, pain, medication effects, or progression of cognitive impairment and must be reported promptly to the nurse.
 
B. Further Deterioration in Physical or Mental Abilities
Any decline in a resident’s physical or cognitive functioning must be reported immediately. CNAs are often the first to notice subtle changes.
Examples include:
	•	Decreased ability to perform activities of daily living (ADLs)
	•	Worsening memory loss or confusion
	•	Increased difficulty communicating or understanding instructions
	•	Loss of mobility or coordination
	•	Changes in eating, drinking, or swallowing
	•	Increased incontinence or inability to recognize toileting needs
Early reporting allows the healthcare team to intervene and adjust care plans as needed.
 
C. Effectiveness of Current Behavioral Management
CNAs must also observe and report whether current interventions and behavioral strategies are effective or ineffective.
Examples include:
	•	Whether calming techniques reduce agitation
	•	Response to structured routines or scheduled activities
	•	Effectiveness of redirection or reassurance strategies
	•	Changes in behavior following medication or environmental adjustments
	•	Continued or worsening behaviors despite interventions
Reporting this information helps the healthcare team evaluate and modify the resident’s care plan to improve outcomes.
 
Guidelines for Reporting
When reporting resident behaviors, CNAs should:
	•	Report observations promptly to the supervising nurse.
	•	Provide clear, factual, and objective information (avoid opinions or assumptions).
	•	Include what was observed, when it occurred, and how the resident responded.
	•	Follow facility policies and documentation procedures.
 
Summary
Timely and accurate reporting of behavioral changes, functional decline, and response to interventions is essential in caring for cognitively impaired residents. CNAs are vital members of the healthcare team and help ensure resident safety and appropriate care by observing carefully and communicating changes promptly to licensed staff.',
   3);

  RAISE NOTICE 'Module 12 updated with 3 lessons.';
END $$;
