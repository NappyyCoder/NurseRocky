-- ============================================================
-- Nurse Rocky — Patch 013: Module 3 Full Content
-- "Assists in Identifying the Mental Health and Social Service Needs of Residents"
-- Source: Competency 3.docx (7 sub-competencies: 3.1–3.7)
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 3;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 3 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Assists in Identifying the Mental Health and Social Service Needs of Residents',
    description = 'Basic human needs across the lifespan, cultural and spiritual influences, stress and coping, mental health care, behavior management, sexuality, and supportive communication.',
    is_published = true,
    lessons_count = 7
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '3.1 — Basic Human Needs and Mental Health/Social Service Needs',
   'Competency 3.0: Assists in Identifying the Mental Health and Social Service Needs of Residents
Certified Nursing Assistants (CNAs) play an important role in recognizing and supporting the mental health and social service needs of residents. While CNAs do not diagnose or provide treatment, they are often the primary caregivers who observe changes in behavior, emotional well-being, and social interaction. These observations are essential for promoting holistic, person-centered care and ensuring residents receive appropriate support services.
Students will learn how to identify basic human needs across the lifespan, recognize developmental and behavioral changes in aging adults, and understand the social and cultural roles of older adults in healthcare settings and the community.
Learning Goal 3.1
Discuss the basic human needs of individuals across the lifespan and identify mental health and social service needs of residents.
 
A. Basic Human Needs Throughout the Lifespan
Basic human needs refer to the essential physical, emotional, social, cultural, and mental health requirements necessary for survival, comfort, and well-being. One of the most widely used frameworks for understanding these needs is Maslow’s Hierarchy of Needs, which includes:
	•	Physiological needs (food, water, rest, shelter)
	•	Safety and security needs
	•	Love and belonging needs
	•	Self-esteem needs
	•	Self-actualization needs
CNAs must also understand Erikson’s stages of psychosocial development, which describe how individuals grow and adapt emotionally and socially throughout life. In older adulthood, key developmental focus includes life review, acceptance, integrity, and coping with loss.
As individuals age, their needs may change and include:
	•	Increased physical support and healthcare needs
	•	Emotional support and companionship
	•	Social interaction and community involvement
	•	Mental health support and cognitive stimulation
	•	Access to community and family resources
Older adults are often categorized into stages:
	•	Young-old (60–74 years): Generally active, independent, and socially engaged.
	•	Middle-old (75–84 years): May experience increased health limitations and require more assistance.
	•	Old-old (85+ years): Often require significant support with physical, cognitive, and social needs.
 
B. Developmental Tasks Associated with Aging
Aging involves important developmental tasks that influence mental health and social well-being. These tasks may include:
	•	Adjusting to retirement and changes in income.
	•	Coping with physical changes and declining health.
	•	Adapting to loss of friends, family members, or spouse.
	•	Maintaining independence while accepting needed assistance.
	•	Finding meaning and purpose in later life.
CNAs must support residents through these transitions with empathy, respect, and encouragement.
 
C. Mental Status and Behavior Changes
Changes in mental status and behavior may occur due to aging, illness, medication effects, or environmental factors. CNAs are often the first to notice these changes and must report them promptly.
Common mental and behavioral changes include:
	•	Confusion or disorientation
	•	Memory loss or difficulty concentrating
	•	Mood changes such as depression, anxiety, or irritability
	•	Withdrawal from social activities
	•	Changes in sleep patterns or appetite
External factors may also impact mental health, including:
	•	Reduced income or financial stress
	•	Limited social interaction or isolation
	•	Chronic illness or pain
	•	Loss of independence or mobility
CNAs must observe, document, and report these changes to ensure residents receive appropriate care and support.
 
D. Role of the Elderly in Home and Community
Older adults continue to play valuable roles within families, communities, and cultural groups. Their experiences, knowledge, and relationships contribute significantly to society.
Key considerations include:
	•	Cultural and religious beliefs: These may influence attitudes toward aging, healthcare decisions, and end-of-life care.
	•	Changing family dynamics: Older adults may transition from caregivers to individuals receiving care from family members.
	•	Housing options: As needs change, residents may move from independent living to assisted living or long-term care settings.
	•	Retirement: Increased free time may provide opportunities for hobbies, volunteering, and community involvement.
CNAs must respect cultural, spiritual, and social values while supporting residents’ continued participation in meaningful activities.
 
Summary
Understanding basic human needs, developmental stages, and psychosocial changes in aging is essential for providing holistic care. CNAs play a critical role in observing mental, emotional, and social changes and supporting residents through life transitions. By recognizing these needs and respecting cultural and individual differences, nursing assistants contribute to improved quality of life, dignity, and well-being for every resident.',
   1),

  (v_mod_id,
   '3.2 — Cultural and Spiritual Attitudes and Psychological Responses',
   '3.2 Competency: Explains How Cultural and Spiritual Attitudes May Influence Psychological Responses
Certified Nursing Assistant (CNA) students must recognize that every resident comes from a unique cultural, spiritual, and personal background that influences how they view health, illness, aging, and healthcare services. Cultural and spiritual beliefs can affect a resident’s emotional responses, coping mechanisms, communication styles, decision-making, and willingness to accept certain treatments or care practices.
CNA students are expected to identify ways to accommodate cultural and spiritual differences by providing individualized, respectful, and person-centered care. This includes listening carefully to residents'' preferences, supporting religious or spiritual practices when possible, respecting dietary restrictions, honoring modesty preferences, and communicating in a culturally sensitive manner.
The nursing assistant plays an important role in respecting cultural and spiritual differences by treating all residents with dignity, compassion, and without judgment. CNAs should report resident preferences to the nursing team, support residents'' rights to practice their beliefs, and ensure that care is provided in a manner that promotes comfort, trust, and emotional well-being.
Examples of cultural and spiritual preferences that may influence the approach to resident care include:
A. Health Care Beliefs
	•	Beliefs about the causes of illness and healing.
	•	Preferences for traditional, holistic, or alternative treatments.
	•	Attitudes toward medications, procedures, and end-of-life care.
B. Sick Care Practices
	•	Religious rituals, prayer, meditation, or spiritual support during illness.
	•	Dietary restrictions or fasting practices.
	•	Preferences regarding personal care, bathing, or physical contact.
C. Family Members'' Roles
	•	Family involvement in healthcare decisions.
	•	Expectations regarding caregiving responsibilities.
	•	Cultural traditions that emphasize family-centered care and support.
By understanding and respecting cultural and spiritual diversity, CNA students contribute to a safe, supportive, and inclusive healthcare environment that promotes the physical, emotional, social, and spiritual well-being of every resident.',
   2),

  (v_mod_id,
   '3.3 — Sources of Stress Common to Residents',
   '3.3 Competency: Identifies Sources of Stress Common to Residents
Certified Nursing Assistant (CNA) students must understand that stress is a normal physical, emotional, and psychological response to change, challenges, or difficult situations. Residents in long-term care facilities, hospitals, and other healthcare settings often experience stress due to illness, loss of independence, changes in living environments, separation from family, chronic health conditions, and the aging process.
CNA students must be able to distinguish between mental health and mental illness. Mental health refers to a person''s emotional, psychological, and social well-being and their ability to cope with daily life, maintain relationships, and make decisions. Mental illness refers to conditions that affect a person''s thinking, mood, behavior, or ability to function effectively in everyday life.
The nursing assistant plays an important role in observing residents for signs and symptoms of stress and reporting concerns to the supervising nurse. CNAs are responsible for recognizing changes in behavior, emotional status, or coping abilities and promptly reporting any signs of distress, inappropriate coping mechanisms, or potential self-harm to ensure resident safety and timely intervention.
Basic Concepts of Mental Health
A. Definition of Stress
Stress is the body''s physical and emotional response to demands, pressures, changes, or challenges that require adjustment or adaptation.
B. Definition of Mental Health
Mental health is a state of emotional, psychological, and social well-being that enables individuals to cope with life''s challenges, work productively, and maintain healthy relationships.
C. Common Causes of Stress Related to Life Stages
	•	Aging and loss of independence
	•	Retirement and financial concerns
	•	Chronic illness or disability
	•	Loss of loved ones and grief
	•	Changes in living arrangements
	•	Hospitalization or long-term care placement
	•	Family conflicts or social isolation
	•	Cognitive decline or memory loss
1. Signs and Symptoms of Stress
	•	Anxiety, worry, or fear
	•	Irritability or mood changes
	•	Withdrawal from social activities
	•	Changes in appetite or sleep patterns
	•	Difficulty concentrating
	•	Restlessness or agitation
	•	Increased complaints of pain or discomfort
	•	Emotional outbursts, crying, or sadness
2. Common Coping Mechanisms
Healthy coping mechanisms may include:
	•	Talking with family, friends, or caregivers
	•	Participating in social activities
	•	Practicing spiritual or religious beliefs
	•	Exercising or engaging in recreational activities
	•	Relaxation techniques and deep breathing
Unhealthy coping mechanisms may include:
	•	Social withdrawal
	•	Refusal of care
	•	Aggressive behavior
	•	Excessive dependence on others
	•	Self-neglect
3. Potential for Self-Harm
Residents experiencing severe stress, depression, grief, or mental illness may be at risk for self-harm. Warning signs may include statements about wanting to die, feelings of hopelessness, giving away personal belongings, sudden behavior changes, or self-injurious actions. CNAs must take all signs seriously and immediately report concerns to the supervising nurse according to facility policy.
By understanding stress, mental health, and coping mechanisms, CNA students can provide compassionate care, promote resident well-being, and contribute to a safe and supportive healthcare environment.',
   3),

  (v_mod_id,
   '3.4 — Appropriate Care for Residents with Mental Health Problems',
   '3.4 Competency: Provides Appropriate Care for Residents with Mental Health Problems
Certified Nursing Assistant (CNA) students must understand that mental health conditions can affect a resident’s thoughts, feelings, behaviors, and ability to perform daily activities. Residents with mental health disorders require compassionate, respectful, and individualized care that promotes dignity, safety, and emotional well-being. The CNA''s role is to provide supportive care, observe changes in behavior, encourage independence when appropriate, and promptly report concerns to the supervising nurse.
CNA students must recognize common mental health conditions and understand how these disorders may influence a resident’s behavior, communication, and response to care. Nursing assistants should maintain a calm and supportive approach, use effective communication techniques, and avoid judgment or confrontation when caring for residents with mental health challenges.
Care for Residents with Common Mental Health Problems
A. Anxiety
Anxiety is characterized by excessive worry, fear, nervousness, or feelings of uneasiness. Residents experiencing anxiety may appear restless, agitated, fearful, or have difficulty concentrating.
CNA Care Considerations:
	•	Speak calmly and reassuringly.
	•	Provide clear explanations before performing care.
	•	Maintain a predictable routine whenever possible.
	•	Encourage relaxation and participation in activities.
	•	Report significant changes in anxiety levels to the nurse.
B. Depression
Depression is a mood disorder that causes persistent sadness, loss of interest, feelings of hopelessness, and decreased energy. Depression is common among older adults experiencing illness, loss, or major life changes.
CNA Care Considerations:
	•	Encourage social interaction and participation in activities.
	•	Listen respectfully and provide emotional support.
	•	Observe for changes in appetite, sleep, or behavior.
	•	Report signs of worsening depression immediately.
	•	Promote independence and self-esteem whenever possible.
C. Affective Disorders
Affective disorders are mental health conditions that primarily affect mood and emotions, including major depression and bipolar disorder. Residents may experience extreme mood changes ranging from sadness to periods of unusually elevated mood.
CNA Care Considerations:
	•	Maintain consistency and structure.
	•	Observe and report mood changes.
	•	Communicate in a calm and respectful manner.
	•	Support participation in prescribed treatment plans.
	•	Ensure resident safety during periods of emotional instability.
D. Schizophrenia
Schizophrenia is a chronic mental illness that may affect thinking, perception, emotions, and behavior. Some residents may experience hallucinations, delusions, or difficulty distinguishing reality from imagination.
CNA Care Considerations:
	•	Remain calm and nonjudgmental.
	•	Do not argue about hallucinations or delusions.
	•	Focus on reality-based communication.
	•	Provide simple instructions and clear explanations.
	•	Report unusual behaviors or changes in mental status to the nurse.
E. Substance Abuse
Substance abuse involves the misuse of alcohol, prescription medications, or other substances that affect physical and mental health. Residents may have a history of substance use disorders or experience withdrawal symptoms.
CNA Care Considerations:
	•	Observe for changes in behavior, mood, or physical condition.
	•	Report signs of withdrawal or substance misuse immediately.
	•	Treat residents with dignity and without judgment.
	•	Follow facility policies regarding medication and safety.
F. Eating Disorders
Eating disorders involve unhealthy eating behaviors that may negatively affect a resident’s nutritional status and overall health. These disorders may include severe food restriction, overeating, or distorted body image concerns.
CNA Care Considerations:
	•	Encourage adequate nutrition and hydration.
	•	Observe eating habits and meal intake.
	•	Report significant weight changes or refusal to eat.
	•	Promote a supportive and respectful dining environment.
	•	Follow dietary instructions provided by the healthcare team.
G. Potential for Self-Harm
Residents experiencing severe depression, mental illness, grief, or emotional distress may be at risk for self-harm or suicide. All statements or behaviors suggesting self-harm must be taken seriously.
CNA Care Considerations:
	•	Recognize warning signs such as hopelessness, withdrawal, giving away possessions, or statements about death.
	•	Stay with the resident if immediate danger is suspected and follow facility policy.
	•	Immediately report concerns to the supervising nurse.
	•	Document observations according to facility procedures.
	•	Maintain resident dignity while ensuring safety.
Nursing Assistant Responsibilities
When caring for residents with mental health conditions, CNAs must:
	•	Respect resident rights, privacy, and dignity.
	•	Use therapeutic communication techniques.
	•	Promote independence and self-worth.
	•	Maintain professional boundaries.
	•	Observe and report changes in behavior, mood, or mental status.
	•	Follow the resident’s care plan and facility policies.
	•	Collaborate with the healthcare team to support resident safety and well-being.
By understanding common mental health disorders and providing compassionate, person-centered care, CNA students help create a safe, supportive, and therapeutic environment that promotes both physical and emotional health.',
   4),

  (v_mod_id,
   '3.5 — Modifying Behavior in Response to Resident Behavior',
   '3.5 Competency: Modifies Own Behavior in Response to Resident Behavior
Certified Nursing Assistant (CNA) students must understand that residents may occasionally display behaviors that are challenging, disruptive, aggressive, withdrawn, confused, or resistant to care. These behaviors often result from illness, pain, cognitive impairment, fear, anxiety, frustration, mental health conditions, or environmental stressors rather than intentional misconduct. Effective CNAs recognize that their own attitude, communication style, and response can significantly influence resident behavior and outcomes.
The nursing assistant''s responsibility is to remain professional, patient, respectful, and compassionate at all times. CNA students must learn to modify their own behavior by remaining calm, avoiding arguments or confrontation, and using person-centered approaches to reduce stress and promote cooperation. Residents should always be treated with dignity, regardless of their behavior or condition.
A. Nursing Assistant''s Role in Maintaining a Respectful Attitude
When interacting with residents who display difficult behaviors, the nursing assistant should:
	•	Remain calm, patient, and professional.
	•	Speak respectfully and use a reassuring tone of voice.
	•	Avoid arguing, criticizing, or becoming defensive.
	•	Recognize that behavior may be a form of communication.
	•	Respect the resident''s rights, dignity, and individuality.
	•	Follow the resident''s care plan and facility policies.
	•	Report significant behavioral changes to the supervising nurse.
	•	Ensure resident safety while preserving independence whenever possible.
B. Effective Approaches to Managing Difficult Behaviors of Residents
CNA students should be familiar with several effective techniques for managing difficult behaviors while promoting comfort and cooperation.
1. Distraction
Redirecting a resident''s attention to another activity or topic can help reduce agitation, frustration, or anxiety.
Examples include:
	•	Engaging the resident in conversation.
	•	Offering a favorite activity.
	•	Looking at photographs or memory books.
	•	Listening to music or participating in recreation.
2. Relaxation Techniques
Helping residents relax may decrease stress and improve cooperation.
Examples include:
	•	Speaking softly and calmly.
	•	Encouraging deep breathing.
	•	Providing reassurance and emotional support.
	•	Offering quiet activities that promote comfort.
3. Calm Environment
A peaceful environment can reduce confusion, overstimulation, and agitation.
Examples include:
	•	Reducing noise and distractions.
	•	Maintaining adequate lighting.
	•	Limiting unnecessary interruptions.
	•	Providing a comfortable and familiar setting.
4. Adjusting the Time of Care
Residents may be more cooperative when care is provided at a time that aligns with their preferences or routines.
Examples include:
	•	Returning later if a resident refuses care.
	•	Scheduling activities during periods when the resident is most alert.
	•	Respecting established routines whenever possible.
5. Encouraging Family Participation
Family members can often provide comfort, reassurance, and valuable information about effective approaches for the resident.
Examples include:
	•	Encouraging family visits when appropriate.
	•	Seeking input about resident preferences and routines.
	•	Including family members in care planning discussions as permitted.
Key Concepts for CNA Students
	•	Difficult behaviors often have an underlying cause that should be identified and reported.
	•	The CNA''s behavior can influence how a resident responds to care.
	•	Maintaining patience, empathy, and professionalism promotes positive interactions.
	•	Safety, dignity, and respect should guide all resident care.
	•	Changes in behavior should always be communicated to the supervising nurse.
By adapting their own behavior and utilizing effective communication and behavior-management techniques, CNA students can build trusting relationships, reduce resident distress, and provide safe, compassionate, person-centered care.',
   5),

  (v_mod_id,
   '3.6 — Normal Sexuality Expression in Residents',
   '3.6 Competency: Describes Ways That Residents May Be Expressing Their Normal Sexuality
Certified Nursing Assistant (CNA) students must understand that sexuality is a normal part of human life and continues throughout the lifespan. Residents in healthcare facilities maintain their need for affection, companionship, intimacy, self-expression, and meaningful relationships regardless of age, disability, or health condition. CNA students must recognize and respect residents'' rights to dignity, privacy, and appropriate expressions of sexuality while maintaining professional boundaries at all times.
Residents may express their sexuality in many normal and healthy ways, including holding hands, showing affection toward a spouse or partner, expressing a desire for companionship, discussing personal relationships, taking pride in their appearance, or maintaining personal grooming habits. CNAs should respond to these expressions respectfully and without judgment.
A. Common Myths Related to Sexuality
CNA students should understand that many misconceptions exist regarding sexuality and aging. Common myths include:
	•	Older adults are no longer interested in relationships or intimacy.
	•	Residents in healthcare facilities do not have sexual feelings or emotional needs.
	•	Physical disabilities eliminate a person''s need for affection or companionship.
	•	Expressions of sexuality are inappropriate simply because a person is elderly.
	•	Residents should not be allowed privacy in personal relationships.
These myths are inaccurate and can lead to disrespectful or discriminatory care. Residents have the right to maintain personal relationships and express their sexuality appropriately within the limits of safety, consent, facility policy, and resident rights.
Appropriate Expressions of Sexuality
Examples of appropriate expressions of sexuality may include:
	•	Holding hands with a spouse or partner.
	•	Hugging, kissing, or showing affection.
	•	Expressing feelings of love, companionship, or attraction.
	•	Discussing personal relationships.
	•	Maintaining personal appearance and grooming.
	•	Requesting privacy with a consenting spouse or partner.
	•	Participating in social activities and relationships.
Inappropriate Expressions of Sexuality
Inappropriate expressions of sexuality may include:
	•	Unwanted touching or physical contact.
	•	Sexual comments that make others uncomfortable.
	•	Public sexual behaviors that violate facility policies.
	•	Sexual behaviors involving residents who cannot provide consent.
	•	Harassment, intimidation, or coercion.
	•	Behaviors that place the resident or others at risk.
When inappropriate behaviors occur, CNAs should remain calm, professional, and respectful while ensuring the safety and dignity of all individuals involved.
B. Reporting Responsibilities Related to Sexuality
The nursing assistant is responsible for observing and reporting concerns related to sexual behaviors and resident safety. CNAs should report:
	•	Inappropriate sexual behaviors.
	•	Behaviors involving lack of consent.
	•	Sexual harassment or abuse.
	•	Sudden changes in sexual behavior.
	•	Behaviors that may indicate confusion, cognitive impairment, or mental health concerns.
	•	Situations that may place residents, staff, or visitors at risk.
CNAs should never ridicule, shame, or judge a resident for expressing sexuality. Instead, concerns should be documented and reported according to facility policy and communicated promptly to the supervising nurse.
Key Concepts for CNA Students
	•	Sexuality is a normal aspect of life at every age.
	•	Residents have the right to dignity, privacy, and appropriate personal relationships.
	•	CNAs must maintain professional boundaries while respecting resident rights.
	•	Appropriate expressions of sexuality should be treated with respect and sensitivity.
	•	Inappropriate or unsafe behaviors must be reported to the supervising nurse.
	•	Resident safety, consent, privacy, and dignity should guide all interactions.
By understanding normal expressions of sexuality and recognizing situations that require intervention, CNA students help create a respectful, safe, and person-centered environment that honors the rights and individuality of every resident.',
   6),

  (v_mod_id,
   '3.7 — Facilitating Expression of Needs and Supportive Communication',
   '3.7 Competency: Facilitates the Resident’s Expression of Needs and Provides Supportive Communication
Certified Nursing Assistant (CNA) students must understand that effective communication is essential for providing safe, respectful, and person-centered care. Residents must be supported in expressing their needs, preferences, concerns, and goals. The CNA plays a key role in encouraging open communication, listening actively, and responding appropriately to both verbal and nonverbal cues.
CNAs should promote resident independence, dignity, and autonomy in all activities of daily living (ADLs). Residents should be encouraged to participate in their own care to the highest level possible, allowing them to make choices and maintain control over their daily routines. Supportive communication helps residents feel valued, respected, and heard.
A. Assists and Encourages Residents to Be Independent in ADLs
CNA students should support resident independence by:
	•	Encouraging residents to do as much for themselves as they are able.
	•	Providing assistance only when needed.
	•	Allowing residents time to complete tasks at their own pace.
	•	Offering choices in daily activities such as bathing, dressing, and eating.
	•	Promoting confidence and self-esteem through positive reinforcement.
B. Modifies Care to Accommodate Resident Values, Customs, Preferences, or Habits
CNA students must recognize that each resident has unique cultural, spiritual, and personal preferences that should be respected. Care should be adjusted whenever possible to honor these preferences, including:
	•	Respecting cultural and religious practices.
	•	Accommodating personal routines and habits.
	•	Supporting dietary, grooming, and privacy preferences.
	•	Communicating respectfully based on individual comfort and needs.
	•	Providing care in a manner that reflects dignity and respect.
C. Utilizes Resident’s Family as a Source of Emotional and/or Spiritual Support
Family members often play an important role in the resident’s emotional well-being, communication, and care planning. CNAs should:
	•	Encourage appropriate family involvement when permitted.
	•	Recognize family members as a support system for emotional and spiritual needs.
	•	Communicate observations and concerns to the supervising nurse so they can be shared appropriately with family.
	•	Respect the resident’s wishes regarding family involvement in care decisions.
	•	Support family participation in helping the resident achieve care goals.
Communication Methods and Enhancing Two-Way Exchange of Ideas
Effective communication involves both speaking and listening. CNA students should use a variety of communication methods to ensure residents are understood and supported.
A. Supporting Choices and Control in ADLs
	•	Offer simple, clear choices during care.
	•	Encourage residents to express preferences.
	•	Respect decisions whenever possible within safety guidelines.
	•	Reinforce the resident’s right to participate in their own care.
B. Adaptation of Personal Care to Accommodate Preferences
	•	Adjust care routines to match resident habits when appropriate.
	•	Be flexible with timing and methods of care delivery.
	•	Respect modesty, privacy, and cultural practices.
	•	Use communication to confirm comfort and understanding.
C. Family Participation in Supporting Resident Goals
	•	Include family members as appropriate in care discussions.
	•	Encourage family involvement in supporting routines and goals.
	•	Use family input to better understand resident preferences and history.
	•	Promote collaboration between staff, residents, and families to improve outcomes.
Key Concepts for CNA Students
	•	Residents must be encouraged to express their needs and preferences.
	•	Independence should be promoted in all activities of daily living.
	•	Communication should always be respectful, clear, and supportive.
	•	Care must be individualized based on cultural, spiritual, and personal preferences.
	•	Family involvement can enhance emotional support and care outcomes.
	•	The CNA role includes listening, observing, reporting, and supporting resident choice.
By using supportive communication and promoting resident independence, CNA students help create a respectful, person-centered environment that strengthens trust, dignity, and quality of care.',
   7);

  RAISE NOTICE 'Module 3 updated with 7 lessons.';
END $$;
