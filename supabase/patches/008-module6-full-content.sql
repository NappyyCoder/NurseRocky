-- ============================================================
-- Nurse Rocky — Patch 008: Module 6 Full Content
-- "Demonstrates General Principles of Infection Control"
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 6;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 6 not found. Run patch 005 first.';
  END IF;

  UPDATE modules SET
    title = 'Demonstrates General Principles of Infection Control',
    description = 'Master infection prevention concepts, the chain of infection, standard and transmission-based precautions, CDC guidelines, OSHA bloodborne pathogen standards, PPE use, and aseptic practices.',
    is_published = true
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  -- ── Lesson 1 ──────────────────────────────────────────────────
  (v_mod_id,
   '6.1 — Describes Measures That Promote Infection Prevention and Control',
   '6.0 Competency: Demonstrates General Principles of Infection Control

Certified Nursing Assistant (CNA) students must understand and consistently apply infection control principles to protect residents, staff, and themselves from the spread of disease. Infection prevention and control are essential responsibilities in all healthcare settings and require knowledge of microorganisms, transmission methods, and proper aseptic practices.

CNAs play a key role in breaking the chain of infection by following standard precautions, recognizing signs of infection, and maintaining a clean and safe environment.

6.1 Describes Measures That Promote Infection Prevention and Control

A. Key Infection Control Concepts and Terms
CNA students must understand the following infection control concepts:
• Types of microbes: Bacteria, viruses, fungi, and parasites that can cause infection.
• Infectious process: The progression of infection from exposure to illness in the body.
• Infection control: Practices used to prevent the spread of microorganisms.
• Body substances: Blood, urine, feces, saliva, mucus, vomit, and other bodily fluids that may carry infection.
• Biohazard waste: Any waste contaminated with infectious materials that must be handled and disposed of safely.
• Exposure report: Documentation completed when a staff member or resident may have been exposed to infectious material.

B. Chain of Infection
CNA students must understand how infection spreads through a chain process. Breaking any link in this chain helps prevent infection.
• Source: Where the microorganism originates (infected person or object).
• Reservoir: Where microorganisms live and multiply (humans, surfaces, equipment).
• Portal of Exit: How microorganisms leave the reservoir (coughing, blood, bodily fluids).
• Method of Transmission: How infection spreads (direct contact, indirect contact, airborne, droplet, vector).
• Portal of Entry: How microorganisms enter a new host (mouth, nose, broken skin, eyes).
• Susceptible Host: A person who is at risk for infection due to weakened immunity or health conditions.

C. Infective Process and Modes of Transmission
CNA students should understand that infection occurs when microorganisms enter the body, multiply, and overcome the immune system''s defenses.

Modes of transmission include:
• Direct contact (person-to-person touch)
• Indirect contact (contaminated surfaces or equipment)
• Droplet transmission (coughing, sneezing, talking)
• Airborne transmission (particles suspended in air)
• Contact with contaminated fluids or objects

The immune response is the body''s natural defense against infection, working to identify and eliminate harmful microorganisms.

D. Signs and Symptoms of Infection
CNA students must recognize both objective and subjective signs of infection.

1. Objective Signs
• Fever or elevated temperature
• Redness, swelling, or warmth at a site
• Drainage or pus from wounds
• Foul odor from body fluids or wounds
• Increased heart rate or respiratory rate

2. Subjective Signs and Symptoms
• Pain or tenderness
• Fatigue or weakness
• General feeling of illness
• Changes in behavior or appetite
• Confusion, especially in older adults

Behavior changes, confusion, and pain are especially important indicators of possible infection in elderly residents.

E. Aseptic Measures
CNA students must apply aseptic practices to reduce the spread of microorganisms.

Medical (Clean) Asepsis
• Practices that reduce the number of microorganisms.
• Includes hand hygiene, PPE use, and cleaning procedures.

Disinfection
• The process of killing most microorganisms on surfaces and equipment.
• Used for non-living objects and environments.

Surgical (Sterile) Asepsis
• Practices that eliminate all microorganisms.
• Used in sterile procedures and surgical settings.

F. Nosocomial Infections
Nosocomial infections are infections acquired in a healthcare facility that were not present at the time of admission. These infections can spread quickly if proper infection control measures are not followed.

Individuals at higher risk include:
• Older adults
• Residents with weakened immune systems
• Residents with chronic illnesses
• Post-surgical patients
• Residents with open wounds or invasive devices (catheters, IV lines)

Key Concepts for CNA Students
• Infection control is essential to resident and staff safety.
• The chain of infection must be broken to prevent disease spread.
• CNAs must recognize signs and symptoms of infection and report them promptly.
• Standard precautions and aseptic techniques must always be followed.
• Nosocomial infections are preventable through proper hygiene and safety practices.
• Timely reporting and proper documentation are critical in infection control.

By applying infection prevention principles consistently, CNA students help maintain a safe, clean, and healthy healthcare environment for all residents and staff.',
   1),

  -- ── Lesson 2 ──────────────────────────────────────────────────
  (v_mod_id,
   '6.2 — CDC Guidelines for Standard and Transmission-Based Precautions',
   '6.2 Competency: Describes and Adheres to CDC Guidelines for Standard Precautions and Transmission-Based Precautions

Certified Nursing Assistant (CNA) students must understand and consistently follow the Centers for Disease Control and Prevention (CDC) guidelines to prevent the spread of infection and protect residents, staff, and visitors. Infection control practices are a critical part of safe, high-quality care and must be applied in every healthcare interaction.

CNAs are responsible for using Standard Precautions with all residents and applying Transmission-Based Precautions when indicated. These practices help reduce the spread of infectious diseases and maintain a safe healthcare environment.

Centers for Disease Control and Prevention (CDC) Guidelines

A. Standard Precautions
Standard Precautions are infection control practices used with all residents regardless of diagnosis or infection status. CNA students must assume that all body fluids, blood, and potentially infectious materials may carry disease.

Standard Precautions include:
• Hand hygiene before and after resident contact.
• Use of Personal Protective Equipment (PPE) when exposure to body fluids is possible.
• Safe handling and disposal of contaminated materials.
• Cleaning and disinfecting equipment and surfaces.
• Avoiding contact with blood, body fluids, and contaminated items when possible.

B. Personal Protective Equipment (PPE)
CNA students must know when and how to use PPE to reduce exposure to infectious materials. PPE includes:
• Gloves: Used when touching blood, body fluids, or contaminated surfaces.
• Gowns: Used to protect clothing during procedures with risk of contamination.
• Masks: Used to prevent inhalation or spread of infectious droplets.
• Goggles/Face Shields: Protect eyes from splashes or sprays of infectious material.
• Boots/Shoe Covers: Used in situations where contamination of footwear may occur.

PPE must be worn correctly, removed safely, and disposed of or cleaned according to facility policy.

C. Hand Washing
Hand hygiene is the most important infection control practice. CNA students must:
• Wash hands with soap and water when visibly soiled.
• Use alcohol-based hand sanitizer when appropriate.
• Perform hand hygiene before and after resident contact.
• Wash hands after removing gloves.
• Avoid touching face, eyes, or mouth with unclean hands.

Proper handwashing significantly reduces the spread of infection.

D. Isolation Precautions
Isolation precautions are additional infection control measures used when residents have known or suspected infections. CNA students must follow all posted instructions and signage for isolation rooms.

Types of isolation may include:
• Contact precautions
• Droplet precautions
• Airborne precautions

E. Transmission-Based Precautions
Transmission-Based Precautions are used in addition to Standard Precautions to prevent the spread of specific infectious diseases.

These precautions are based on how the infection spreads:
• Direct contact
• Indirect contact
• Droplet transmission
• Airborne transmission

CNAs must strictly follow assigned precautions and use appropriate PPE at all times.

F. Droplet Precautions
Droplet precautions are used for infections spread through respiratory droplets produced by coughing, sneezing, or talking.

CNA students must:
• Wear a surgical mask when within close proximity to the resident.
• Encourage the resident to wear a mask when leaving the room if appropriate.
• Maintain proper distance when possible.
• Perform frequent hand hygiene.

G. Respiratory Hygiene / Cough Etiquette
CNA students must promote respiratory hygiene to reduce the spread of infection. This includes:
• Covering mouth and nose with a tissue or elbow when coughing or sneezing.
• Disposing of tissues immediately after use.
• Performing hand hygiene after coughing or sneezing.
• Wearing a mask if experiencing respiratory symptoms.
• Encouraging residents and visitors to follow the same practices.

H. Exposure Control Plan
The exposure control plan is a facility policy designed to reduce the risk of infection exposure for staff and residents. CNA students must:
• Follow all infection control policies and procedures.
• Use PPE appropriately.
• Participate in required training on infection prevention.
• Understand procedures for reporting exposure incidents.

I. Exposure Incidents and Reports
An exposure incident occurs when a CNA may have come into contact with blood or potentially infectious materials. CNA students must:
• Report all exposure incidents immediately to the supervisor.
• Follow facility procedures for post-exposure care.
• Complete required incident or exposure reports.
• Seek medical evaluation if required by policy.
• Never ignore or delay reporting exposure.

Key Concepts for CNA Students
• Standard Precautions must be used with every resident at all times.
• PPE is essential for protecting against infection transmission.
• Hand hygiene is the most effective method of preventing infection spread.
• Transmission-Based Precautions are used for specific infectious conditions.
• Respiratory hygiene helps reduce airborne and droplet spread of disease.
• Exposure incidents must always be reported immediately.
• Following CDC guidelines ensures safety for residents, staff, and visitors.

By consistently applying CDC infection control guidelines, CNA students help maintain a safe, healthy, and infection-free healthcare environment.',
   2),

  -- ── Lesson 3 ──────────────────────────────────────────────────
  (v_mod_id,
   '6.3 — Describes and Adheres to OSHA Guidelines',
   '6.3 Competency: Describes and Adheres to OSHA Guidelines

Certified Nursing Assistant (CNA) students must understand and follow the Occupational Safety and Health Administration (OSHA) guidelines to ensure a safe workplace and reduce the risk of exposure to infectious diseases and hazardous materials. OSHA standards are designed to protect healthcare workers, residents, and visitors from injury, illness, and exposure to bloodborne pathogens and other workplace hazards.

CNAs play an important role in preventing infection and maintaining workplace safety by following established policies, using protective equipment, and practicing safe work habits at all times.

Occupational Safety and Health Administration (OSHA) Guidelines

A. Bloodborne Pathogen Standard
The Bloodborne Pathogen Standard is an OSHA regulation designed to protect healthcare workers from exposure to infectious materials such as blood and other potentially infectious body fluids.

CNA students must:
• Treat all blood and body fluids as potentially infectious.
• Use Standard Precautions at all times.
• Wear appropriate Personal Protective Equipment (PPE) when exposure is possible.
• Properly dispose of contaminated sharps and biohazard waste.
• Follow facility protocols for cleaning and disinfecting contaminated areas.

B. Hepatitis
Hepatitis refers to inflammation of the liver and can be caused by viral infections such as Hepatitis B and Hepatitis C, which may be transmitted through blood and body fluids.

CNA students must:
• Understand how Hepatitis is transmitted.
• Follow infection control precautions to prevent exposure.
• Use PPE when handling blood or bodily fluids.
• Participate in recommended vaccinations when available.

C. HIV (Human Immunodeficiency Virus)
HIV is a virus that attacks the immune system and is transmitted through contact with infected blood or certain body fluids.

CNA students must:
• Follow Standard Precautions with all residents.
• Use gloves and PPE when exposure to body fluids is possible.
• Avoid direct contact with blood or contaminated sharp objects.
• Report all exposure incidents immediately.

D. Other Ways of Reducing Infection
CNA students must use multiple strategies to reduce the spread of infection, including:
• Frequent and proper hand hygiene.
• Cleaning and disinfecting equipment and surfaces.
• Safe handling of contaminated materials.
• Proper use and disposal of PPE.
• Following isolation and infection control procedures.

E. Vaccination
Vaccination is an important preventive measure that protects healthcare workers and residents from infectious diseases.

CNA students should:
• Stay up to date with required immunizations.
• Understand that vaccines help reduce the risk of infection spread.
• Follow facility requirements for immunization compliance.

F. Work Practice Controls
Work practice controls are procedures that reduce the risk of exposure to bloodborne pathogens and infectious materials.

CNA students must:
• Avoid recapping needles or handling sharps unnecessarily.
• Wash hands before and after resident contact.
• Avoid eating or drinking in contaminated areas.
• Follow proper procedures for handling contaminated items.
• Use safe techniques when performing resident care.

G. Engineering Controls
Engineering controls are devices or equipment designed to reduce exposure to hazards.

Examples include:
• Sharps disposal containers.
• Safety-engineered needles.
• Handwashing stations and hand sanitizer dispensers.
• Protective barriers and isolation room setups.

CNA students must use these controls correctly and report damaged or missing equipment immediately.

H. Education
Ongoing education is essential for maintaining safety in healthcare settings. CNA students must:
• Participate in required OSHA and infection control training.
• Stay informed about updated safety guidelines and procedures.
• Apply learned skills consistently in the workplace.
• Ask questions and seek clarification when needed.

Key Concepts for CNA Students
• OSHA guidelines protect healthcare workers and residents from infection and injury.
• Bloodborne pathogens such as Hepatitis and HIV require strict safety precautions.
• Standard Precautions must be followed at all times.
• Vaccination and education are essential components of infection prevention.
• Work practice and engineering controls help reduce exposure risks.
• All exposure incidents must be reported immediately according to facility policy.

By following OSHA guidelines and maintaining safe work practices, CNA students help create a safe, compliant, and professional healthcare environment that protects everyone in the care setting.',
   3);

  UPDATE modules SET lessons_count = 3 WHERE id = v_mod_id;

  RAISE NOTICE 'Patch 008 complete: Module 6 updated with 3 full lessons.';
END $$;
