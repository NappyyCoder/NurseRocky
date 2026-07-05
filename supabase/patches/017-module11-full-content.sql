-- ============================================================
-- Nurse Rocky — Patch 017: Module 11 Full Content
-- "Demonstrates Safe Transfers, Positioning, and Turning of Residents Using Effective Body Mechanics"
-- Source: 11.0 Competency Demonstrates Safe Transfers, Positioning, and Turning.docx
-- Run in: Supabase Dashboard → SQL Editor
-- ============================================================

DO $$
DECLARE
  v_mod_id INT;
BEGIN

  SELECT id INTO v_mod_id FROM modules WHERE order_num = 11;

  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module 11 not found. Run seed-modules.sql first.';
  END IF;

  UPDATE modules SET
    title = 'Demonstrates Safe Transfers, Positioning, and Turning',
    description = 'Safe body mechanics, effects of limited mobility, positioning and turning, transfers, ambulation, range of motion, and oxygen device handling during transfers.',
    is_published = true,
    lessons_count = 7
  WHERE id = v_mod_id;

  DELETE FROM lessons WHERE module_id = v_mod_id;

  INSERT INTO lessons (module_id, title, content, order_num) VALUES

  (v_mod_id,
   '11.1 — Demonstrates Safe Body Mechanics',
   '11.0 Competency: Demonstrates Safe Transfers, Positioning, and Turning of Residents Using Effective Body Mechanics
Certified Nursing Assistant (CNA) students must understand and demonstrate safe body mechanics when providing resident care. Proper body mechanics are essential for preventing injury to both the resident and the CNA, maintaining safety during transfers, positioning, lifting, and turning activities. CNAs must apply these principles consistently in all care situations to ensure safe, effective, and professional practice.
 
11.1 Demonstrates Safe Body Mechanics
 
A. Principles of Body Mechanics
CNA students must understand the basic principles of proper body mechanics, including:
	•	Maintain a wide base of support with feet shoulder-width apart.
	•	Keep the center of gravity low by bending at the knees, not the waist.
	•	Keep the back straight and aligned while performing care.
	•	Lift using leg muscles rather than back muscles.
	•	Keep objects and residents close to the body when lifting or moving.
	•	Avoid twisting the body; instead, pivot with the feet.
	•	Face the direction of movement when possible.
	•	Use assistive devices and ask for help when needed.
 
B. Techniques of Body Mechanics
CNA students must apply safe techniques when performing procedures such as transfers, repositioning, and lifting:
	•	Adjust bed height to a comfortable working level before beginning care.
	•	Lock wheels on beds, wheelchairs, and stretchers before transfers.
	•	Use proper hand placement and secure grips when assisting residents.
	•	Coordinate movements with the resident and other caregivers when performing team lifts.
	•	Encourage resident participation to the greatest extent possible.
	•	Use gait belts and mechanical lifts according to facility policy.
	•	Maintain proper posture throughout the procedure to prevent strain or injury.
Proper body mechanics help reduce fatigue, prevent musculoskeletal injury, and ensure resident safety.
 
C. Improper Body Mechanics
CNA students must be able to recognize and avoid unsafe body mechanics, including:
	•	Bending at the waist instead of the knees.
	•	Twisting the back while lifting or moving a resident.
	•	Reaching too far without moving the feet.
	•	Lifting heavy objects or residents without assistance.
	•	Failing to lock wheels before transfers.
	•	Holding residents away from the body while lifting.
	•	Poor posture that increases risk of strain or injury.
Improper body mechanics can result in injury to the CNA, discomfort or harm to the resident, and unsafe care outcomes.
 
Key Concepts for CNA Students
	•	Safe body mechanics protect both the CNA and the resident from injury.
	•	Proper posture, lifting techniques, and use of assistive devices are essential.
	•	Residents should be encouraged to assist in transfers whenever possible.
	•	Teamwork and communication improve safety during mobility tasks.
	•	Unsafe body mechanics increase risk of injury and must be avoided at all times.
By applying correct body mechanics, CNA students ensure safe transfers, positioning, and resident care while promoting comfort, dignity, and professional safety standards.',
   1),

  (v_mod_id,
   '11.2 — Identifies the Effects of Limited Mobility',
   '11.2 Competency: Identifies the Effects of Limited Mobility
Certified Nursing Assistant (CNA) students must understand the effects of limited mobility and prolonged bedrest on a resident’s physical, emotional, and psychological well-being. Limited mobility can significantly impact multiple body systems and increase the risk of complications if preventive care is not provided consistently. CNAs play a key role in maintaining resident comfort, promoting movement, and preventing avoidable decline.
 
Limited Mobility / Bedrest
 
A. Effects of Limited Mobility
CNA students must recognize that limited mobility can affect the body in several ways, including:
	•	Decreased muscle strength and muscle wasting (atrophy)
	•	Joint stiffness and reduced range of motion
	•	Decreased circulation, increasing risk of blood clots
	•	Reduced lung expansion, increasing risk of pneumonia
	•	Decreased appetite and digestive function
	•	Increased risk of pressure injuries (bedsores)
	•	Loss of independence and decreased ability to perform ADLs
	•	Emotional effects such as depression, anxiety, or social isolation
Early identification and prevention of these effects are essential to resident health.
 
B. Complications of Bedrest
CNA students must understand that prolonged bedrest can lead to serious complications, including:
	•	Pressure injuries due to constant pressure on the skin
	•	Contractures (permanent tightening of muscles and joints)
	•	Deep vein thrombosis (DVT)
	•	Respiratory infections such as pneumonia
	•	Constipation and decreased bowel motility
	•	Urinary stasis and increased risk of urinary tract infections
	•	Deconditioning and overall physical decline
CNAs must observe residents closely and report any signs of complication promptly.
 
C. CNA Tasks That Help Prevent Complications
CNA students play an essential role in preventing complications of limited mobility through the following care measures:
 
1. Movement
	•	Encourage safe movement as tolerated.
	•	Assist with ambulation or transfers according to care plan.
	•	Promote activity to maintain strength and circulation.
 
2. Positioning
	•	Reposition residents regularly according to facility policy.
	•	Ensure comfort and safety during all positions.
	•	Use pillows and supports to maintain proper alignment.
 
3. Alignment
	•	Maintain correct body alignment in bed or chair.
	•	Prevent contractures by supporting limbs in proper position.
	•	Use pillows and positioning devices to maintain neutral alignment.
	•	Ensure head, neck, and spine are supported appropriately.',
   2),

  (v_mod_id,
   '11.3 — Assists Residents in Positioning and Turning',
   '11.3 Competency: Assists Residents in Positioning and Turning
Certified Nursing Assistant (CNA) students must demonstrate the ability to safely assist residents in positioning and turning while maintaining proper body mechanics, resident comfort, and skin integrity. Proper positioning is essential for preventing complications related to immobility, promoting circulation, and supporting overall resident well-being. CNAs must follow the resident’s care plan and use assistive devices appropriately to ensure safety and comfort.
 
A. Body Positions Used for Positioning Residents
CNA students must be able to demonstrate and understand the purpose of various resident positions, including:
	•	Side-lying (Lateral Position)
	•	Resident lies on either side with body aligned.
	•	Used to relieve pressure and promote comfort.
	•	Supine Position
	•	Resident lies flat on the back.
	•	Common resting position but requires repositioning for pressure relief.
	•	Prone Position
	•	Resident lies on the abdomen.
	•	Used less frequently; may improve oxygenation in some cases.
	•	Sim’s Position
	•	Semi-prone position between side-lying and prone.
	•	Used for certain procedures or comfort.
	•	High Fowler’s Position
	•	Head of bed elevated 60–90 degrees.
	•	Promotes breathing and eating.
	•	Low Fowler’s Position
	•	Head of bed elevated 15–30 degrees.
	•	Used for comfort and reduced pressure.
	•	Trendelenburg Position
	•	Head lowered below feet.
	•	Used in specific medical situations per provider order.
	•	Lithotomy Position
	•	Supine with legs elevated and supported.
	•	Used for examinations or procedures.
	•	Orthopneic Position
	•	Sitting upright, often leaning forward with support.
	•	Helps ease breathing difficulty.
	•	Log Rolling
	•	Moving the body as one unit without twisting.
	•	Used for spinal precautions or injury prevention.
	•	Moving Up in Bed
	•	Assisting resident to reposition higher in bed safely.
	•	Dangling
	•	Sitting on the side of the bed with feet supported.
	•	Helps prepare for standing or ambulation.
 
B. Turning Techniques
CNA students must demonstrate safe turning methods, including:
	•	Draw Sheet Method
	•	Using a draw sheet to lift and turn the resident safely.
	•	Requires proper body mechanics and teamwork.
	•	Mechanical Lifts
	•	Equipment used to safely transfer or reposition residents who cannot assist.
	•	Must be used according to facility policy and training.
	•	Log Roll Technique
	•	Used for residents requiring spinal alignment.
	•	Requires coordinated movement of the body as a single unit.
 
C. Use of Assistive Devices
CNA students must understand and properly use assistive devices to support positioning and prevent complications:
	•	Trochanter Rolls
	•	Prevent external rotation of the hips and legs.
	•	Foot Boards
	•	Maintain proper foot alignment and prevent foot drop.
	•	Hand Rolls
	•	Maintain natural hand position and prevent contractures.
	•	Bed Cradles
	•	Keep linens off sensitive areas of the body.
	•	Abdominal Pillows
	•	Support abdominal comfort and positioning.
	•	Abductor Pillows
	•	Keep legs properly aligned and separated after hip surgery.
 
Key Concepts for CNA Students
	•	Proper positioning prevents complications of immobility and promotes comfort.
	•	Residents must be repositioned safely using correct body mechanics.
	•	Assistive devices are essential tools for maintaining alignment and preventing injury.
	•	Turning techniques must protect skin integrity and reduce pressure injury risk.
	•	Teamwork and communication are critical during all positioning and turning procedures.
	•	Resident safety, dignity, and comfort must always be prioritized.
By accurately performing positioning and turning techniques, CNA students help ensure resident safety, comfort, skin integrity, and prevention of complications related to immobility.',
   3),

  (v_mod_id,
   '11.4 — Assists Transfers from Bed to Chair, Gurney, or Geri Chair',
   'Competency 11.4: Assists the Resident to Transfer from Bed to Chair, Gurney, Stretcher, or Geri Chair
Safe resident transfer is a fundamental skill for Certified Nursing Assistants (CNAs). Proper transfer techniques protect both the resident and the caregiver by reducing the risk of injury, promoting comfort, and maintaining dignity. CNAs must follow safety principles, use correct body mechanics, and apply assistive devices appropriately based on the resident’s condition and care plan.
Students will learn how to assist residents with transfers using safe techniques and appropriate equipment while maintaining safety, comfort, and respect.
 
Learning Goal 11.4
Assist the resident to transfer from bed to chair, gurney, stretcher, or geri chair.
 
A. Transfer Techniques
CNAs must demonstrate safe and appropriate transfer techniques based on the resident’s level of mobility and care plan:
	•	Bed to chair transfer: Assisting a resident to move safely from bed to a chair while maintaining stability and alignment.
	•	Bed to gurney transfer: Supporting safe movement for residents who require transport lying down, often using coordinated team lifting techniques.
	•	Bed to stretcher transfer: Carefully transferring residents who need full support and positioning during transport.
	•	Bed to geri chair transfer: Assisting residents into a specialized reclining chair designed for comfort, safety, and mobility support.
In all transfer situations, CNAs must:
	•	Explain the procedure to the resident.
	•	Provide privacy and emotional reassurance.
	•	Use proper body mechanics.
	•	Follow facility policy and care plan instructions.
 
B. Assistive Devices Used in Transfers
CNAs must use assistive devices correctly to ensure safe and effective transfers:
1. Gait Belt
	•	Used to provide stability and support during standing and walking transfers.
	•	Placed securely around the resident’s waist for controlled assistance.
2. Mechanical Lift
	•	Used for residents who are unable to bear weight or require full assistance.
	•	Requires proper setup and operation according to facility training.
3. Slide Board
	•	Used to assist with lateral transfers between surfaces (e.g., bed to stretcher or wheelchair).
	•	Helps reduce friction and injury risk during movement.
4. Lift Sheet
	•	Used for repositioning or transferring residents with multiple caregivers.
	•	Ensures even distribution of weight and reduces strain on staff and resident.
 
C. Principles and Guidelines for Safe Transfers
CNAs must follow key safety principles, including:
	•	Always follow the resident’s care plan and mobility status.
	•	Use proper body mechanics to prevent injury.
	•	Ask for assistance when needed; never transfer a resident alone if unsafe.
	•	Lock wheels on beds, chairs, and equipment before transferring.
	•	Maintain resident dignity and privacy throughout the process.
	•	Ensure assistive devices are used correctly and safely.
 
Summary
Safe transfers are essential to resident safety and caregiver protection. CNAs must demonstrate proper transfer techniques and use assistive devices such as gait belts, mechanical lifts, slide boards, and lift sheets appropriately. By following safety guidelines, communicating clearly, and maintaining professionalism, nursing assistants help ensure smooth, safe, and dignified resident transfers.',
   4),

  (v_mod_id,
   '11.5 — Assists Residents to Ambulate',
   'Competency 11.5: Assists Residents to Ambulate
Ambulation is an essential part of resident care that promotes independence, circulation, strength, and overall well-being. Certified Nursing Assistants (CNAs) play a key role in assisting residents to walk safely while preventing falls and injuries. Proper assessment of functional limitations, awareness of safety risks, and correct use of assistive devices are essential to effective ambulation.
Students will learn how to identify limitations affecting mobility, apply safety principles, respond appropriately to falls, and use assistive devices correctly during ambulation.
 
Learning Goal 11.5
Assist residents to ambulate safely and effectively.
 
A. Functional Limitations Affecting Ambulation
CNAs must recognize conditions that may limit a resident’s ability to walk safely, including:
	•	Muscle weakness or fatigue
	•	Joint stiffness or pain (e.g., arthritis)
	•	Neurological conditions (e.g., stroke, Parkinson’s disease)
	•	Balance or coordination problems
	•	Post-surgical restrictions
	•	Dizziness or low blood pressure
	•	Use of assistive devices or mobility aids
Understanding these limitations helps prevent injury and supports individualized care.
 
B. Safety Considerations for Ambulation
Safety is a top priority when assisting residents to walk. CNAs must:
	•	Review the resident’s care plan before ambulation.
	•	Ensure proper footwear is worn (non-slip shoes).
	•	Use a gait belt when appropriate.
	•	Remove obstacles and ensure a clear walking path.
	•	Encourage slow, steady movement and proper pacing.
	•	Stay close to the resident at all times during ambulation.
	•	Lock wheels on beds and chairs before assisting the resident to stand.
	•	Stop immediately if the resident becomes weak, dizzy, or unstable.
 
C. Care of the Resident Who Has Fallen
If a resident falls, CNAs must respond appropriately and safely:
	•	Do not move the resident until assessed, unless there is immediate danger.
	•	Assess for signs of pain, injury, or distress without manipulating the body.
	•	Report all falls immediately to the nurse.
	•	Observe and report pain behaviors, such as grimacing, guarding, or verbal complaints.
	•	Follow all facility protocols for fall documentation and incident reporting.
	•	Remain with the resident to provide reassurance and support.
 
D. Use of Assistive Devices in Ambulation
CNAs must demonstrate safe use of mobility aids based on resident needs and care plans:
1. Gait Belt
	•	Used to provide secure support during walking and transfers.
2. Canes
	•	Used for residents with mild balance issues.
	•	Types include standard cane, quad cane, and hemi cane.
3. Walkers
	•	Provide stability and support for residents with moderate weakness or balance concerns.
4. Crutches
	•	Used for residents who must keep weight off one or both legs.
	•	Requires proper instruction and supervision.
5. Wheelchairs
	•	Used for residents who cannot safely ambulate.
	•	Must be locked during transfers and positioned safely during transport.
 
Summary
Assisting residents with ambulation requires skill, awareness, and careful attention to safety. CNAs must identify mobility limitations, apply fall prevention strategies, respond appropriately to falls, and use assistive devices correctly. By following safety guidelines and maintaining close supervision, nursing assistants help promote independence while ensuring resident safety and well-being.',
   5),

  (v_mod_id,
   '11.6 — Demonstrates Passive and Active Range of Motion',
   'Competency 11.6: Demonstrates Passive and Active Range of Motion
Range of Motion (ROM) exercises are an important part of maintaining joint flexibility, circulation, muscle strength, and overall mobility in residents who may have limited movement. Certified Nursing Assistants (CNAs) must understand how to safely perform both active and passive range of motion exercises to support resident independence and prevent complications such as contractures, stiffness, and decreased circulation.
Students will learn the principles and rationale of ROM exercises, identify key joint movements, and safely perform ROM procedures on major joints while maintaining resident comfort and safety.
 
Learning Goal 11.6
Demonstrate safe and effective active and passive range of motion techniques for residents.
 
A. Principles and Rationale for Passive and Active Range of Motion
Range of motion exercises are designed to maintain or improve joint function and prevent complications caused by immobility.
Active Range of Motion (AROM):
	•	The resident moves their own joints independently.
	•	Promotes muscle strength, coordination, and endurance.
Passive Range of Motion (PROM):
	•	The CNA moves the resident’s joints when the resident is unable to do so independently.
	•	Helps maintain joint flexibility and circulation.
Key principles include:
	•	Always support and protect joints during movement.
	•	Move joints slowly, smoothly, and gently.
	•	Stop if the resident experiences pain.
	•	Perform exercises according to care plan instructions.
	•	Maintain resident privacy and comfort throughout the procedure.
 
B. Joint Movements (Key Terms)
Understanding joint movements is essential for safely performing ROM exercises:
	•	Adduction: Moving a body part toward the midline of the body.
	•	Abduction: Moving a body part away from the midline of the body.
	•	Flexion: Bending a joint, decreasing the angle.
	•	Extension: Straightening a joint, increasing the angle.
	•	Hyperextension: Extending a joint beyond its normal range.
	•	Internal Rotation: Turning a body part inward toward the body.
	•	External Rotation: Turning a body part outward away from the body.
	•	Supination: Turning the palm upward.
	•	Pronation: Turning the palm downward.
 
C. Performing Range of Motion on Major Joints
CNAs must safely perform ROM exercises according to care plan instructions for the following joints:
	•	Shoulder
	•	Elbow
	•	Wrist
	•	Hands
	•	Fingers
	•	Thumb
	•	Hip
	•	Knee
	•	Ankle
	•	Foot
	•	Toes
Safe performance includes:
	•	Supporting joints above and below the area being moved.
	•	Performing movements within the resident’s pain-free range.
	•	Repeating each movement as directed by facility policy or care plan.
	•	Observing for signs of discomfort, fatigue, or resistance.
	•	Stopping immediately if pain occurs and reporting concerns.
 
D. Caring for Residents Using Continuous Passive Motion (CPM) Devices
Continuous Passive Motion (CPM) devices are mechanical machines that move a joint slowly and continuously, usually after surgery, to prevent stiffness and improve healing.
CNAs must:
	•	Ensure the CPM device is properly positioned and functioning.
	•	Check alignment of the affected limb.
	•	Monitor the resident for pain, discomfort, or swelling.
	•	Ensure the device is used for the prescribed amount of time.
	•	Observe skin condition and circulation regularly.
	•	Report any concerns immediately to the nurse.
CPM devices must be used according to physician orders and facility protocols.
 
Summary
Range of motion exercises are essential for maintaining joint health, preventing complications of immobility, and promoting resident mobility and independence. CNAs must understand joint movements, apply safe techniques, and provide proper care when assisting with both active and passive ROM exercises, including the use of CPM devices. By following correct procedures, nursing assistants help support resident comfort, safety, and overall physical well-being.',
   6),

  (v_mod_id,
   '11.7 — Oxygen Devices During Transfers (Without Changing Settings)',
   'Competency 11.7: Removes and Applies Oxygen Devices During Transfers with Supervision Without Changing Oxygen Settings
Oxygen therapy is a critical intervention used to support residents who have difficulty maintaining adequate oxygen levels. Certified Nursing Assistants (CNAs) may assist with the removal and application of oxygen delivery devices during transfers only under supervision and according to the care plan. CNAs must never adjust oxygen flow rates or settings, as this is a licensed nursing function.
Students will learn how to identify oxygen sources and delivery systems, apply safety measures, and correctly assist residents who require oxygen during transfers while maintaining safety and following facility protocols.
 
Learning Goal 11.7
Safely assist in the removal and application of oxygen devices during resident transfers under supervision without altering oxygen settings.
 
A. Oxygen Sources and Methods of Delivery
Oxygen may be supplied through different sources depending on the resident’s needs and care setting.
Common oxygen sources include:
	•	Wall outlet oxygen systems: Centralized oxygen supply in healthcare facilities.
	•	Oxygen tanks (cylinders): Portable or stationary compressed oxygen tanks used during transport or emergencies.
	•	Oxygen concentrators: Devices that extract oxygen from the surrounding air for continuous delivery.
Common oxygen delivery methods include:
	•	Nasal cannula (prongs): Small tubing placed in the nostrils for low-flow oxygen delivery.
	•	Oxygen masks: Devices that cover the nose and mouth to deliver higher oxygen concentrations.
CNAs must be familiar with these devices to assist safely during patient care activities.
 
B. Oxygen Safety Measures and Precautions
Oxygen is considered a medication and must be handled with strict safety precautions due to its ability to accelerate combustion.
Safety measures include:
	•	No smoking or open flames near oxygen equipment.
	•	Keeping oxygen tanks upright and secured at all times.
	•	Ensuring tubing is not kinked or obstructed.
	•	Avoiding petroleum-based products near oxygen equipment (use water-based products only).
	•	Ensuring proper storage of oxygen tanks according to facility policy.
	•	Checking that equipment is functioning properly before and after transfers.
	•	Keeping oxygen flow settings unchanged unless directed by licensed personnel.
CNAs must always prioritize resident safety when working with oxygen equipment.
 
C. Techniques for Application and Removal of Oxygen Devices
CNAs may assist with oxygen device application and removal during transfers only under supervision and according to care instructions.
Safe techniques include:
	•	Ensuring the resident remains calm and supported during the transfer process.
	•	Keeping oxygen tubing connected whenever possible during movement.
	•	If removal is necessary for transfer, ensuring the oxygen source is safely placed and secured.
	•	Reapplying the oxygen device immediately after transfer completion.
	•	Verifying that the device is positioned correctly (e.g., cannula in nostrils, mask properly fitted).
	•	Observing the resident for signs of respiratory distress such as shortness of breath, anxiety, or cyanosis.
	•	Reporting any changes in condition to the supervising nurse immediately.
CNAs must never adjust oxygen flow rates, pressure settings, or delivery amounts.
 
Summary
Assisting residents who require oxygen during transfers requires careful attention to safety, proper technique, and adherence to supervision guidelines. CNAs must understand oxygen sources, follow strict safety precautions, and correctly apply or remove oxygen devices without altering settings. By following these principles, nursing assistants help ensure safe mobility while supporting respiratory needs and protecting resident well-being.
 
 
 
 
 
>',
   7);

  RAISE NOTICE 'Module 11 updated with 7 lessons.';
END $$;
