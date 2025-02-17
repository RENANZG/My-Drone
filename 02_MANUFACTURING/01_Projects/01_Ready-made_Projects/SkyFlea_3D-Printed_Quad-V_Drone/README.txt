                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


http://www.thingiverse.com/thing:2238691
"SkyFlea" 3D-Printed Quad-V Drone by tombkk is licensed under the Creative Commons - Attribution - Non-Commercial license.
http://creativecommons.org/licenses/by-nc/3.0/

# Summary

"SkyFlea" is a complete 3D-Printed drone based on discontinued 3DR's IRIS+. Together with a Pixhawk flight controller, it is a fully autonomous medium-sized drone.

Maiden flight test : https://www.youtube.com/watch?v=RZMS9qAsDP8

Plastic parts comprise 3  categories :

(A) Frame.
(B) 2-Axis Gimbal.
(C) Parts printed by using files from other design sources.

(A) Frame
(1) Battery Compartment
(2) Bottom Plate
(3) Top Plate
(4) Top Shell
(5) Front Plate
(6) Rear Plate
(7) LED Lens
(8) LED PCB Retainer
(9) GPS Module Cover
(10) Landing Foot 

(B) 2-Axis Gimbal
(11) Bottom Vibration Damping Plate
(12) Top Vibration Damping Plate
(13) Bottom IMU Cover
(14) Top IMU Cover
(15) Roll Arm

(C) Parts printed by using files from other design sources.

Obtained from https://www.myminifactory.com/object/3drobotics-iris-19615 (credit to 3DRobotics IRIS+ by 3DR Robotics)
(16) Arm (iris-Iris-Arm.STL)
(17) Wiring Clip (iris-Iris-Clip.STL)

Obtained from http://www.thingiverse.com/thing:163472/#files (credit to Omnimac 3DR Pixhawk Anti Vibration Mount by GuyMcCaldin)
(18) Top Pixhawk Vibration Damping Plate (Omnimac_Pixhawk_Mount_v1.1_top_plate.stl)
(19) Bottom Pixhawk Vibration Damping Plate (Omnimac_Pixhawk_Mount_v1.1_bottom_plate.stl)


Tips :

The design intended for drone equipped with components listed below. Different components with similar dimensions and specifications may be used. 

Battery compartment can easily house a 3s 40C 6200mAh battery,

Landing foot is taller than original IRIS+'s to clear newly designed battery compartment from ground.

Four micro ESC's, a 50x50mm 2-axis GBC board,  an APM/Pixhawk power module, 50x50mm power distribution PCB installed on the Bottom Plate.

Pixhawk flight controller (on vibration damping plate), telemetry radio, FPV transmitter, a piezo buzzer, I2C extender module installed on Top Plate.

GPS module, a receiver with two antennas, an APM/Pixhawk safety switch installed underneath/on the Top Shell.

ฺTo minimize EMF interference, bottom of GPS module should be covered by an EMI-shield cup, made from thin (0.1mm., or less) copper sheet, soldered and wired to battery negative (ground).

Print density : 50%. Reduce print density for lighter weight.

Printer : Delta, 210x210x320mm print volume.
 
Parts 1-3, 5-6, 8, 10 (2 off), 11-15, 16 (2 off), 17 (12 off), 18-19 printed from black ABS plastic.
Parts  4, 9, 10 (2 off), 16 (2 off) printed from blue ABS plastic.
Part 7 printed from clear PLA plastic.

Part 4 sanded and spray-painted blue for a glossy finish.

Use small rubber balls similar to this : https://hobbyking.com/en_us/vibration-damping-ball-65g-bag-of-8.html  for gimbal and flight controller (Pixhawk) vibration damping plates. 

Use M3 hex screws for assembly (except for LED/USB port PCB retainer, GPS module cover, and Gimbal IMU cover which are secured in place by small 1.5mm self-tapping screws) .

Use (original, replacement, or printed)  Mobius mounting base for mounting the camera onto gimbal top vibration damping plate.

Install M3 brass inserts, 4mm (OD), 3mm (H), in all mounting holes for M3 mounting screws.

Components and Specifications

Frame Type: V-config Quad Copter, 3D Printed with ABS Plastic
MTM lenght : 510mm (diagonal), 260mm (front-rear), 444mm (front-front), 413mm (rear-rear)
Height : 142mm (ground-top)
Flight controller: 1 x Pixhawk Px4 (clone)
GPS: 1 x Rctimer u-blox LEA-6H GPS & MAG V2
Radio: FrSky Taranis Plus X9D transmitter + FrSky D4R-II receiver with TTL-RS232 converter (FrSky FUL-1)
Motor : 4 x MT2212 920Kv
ESC: 4 x Hobbywing XRotor Micro BLHeli 20A 2-4S F396 E
Props: 2 x APC 10x4.7SFP (CW) + 2 x 10x4.7SF (CCW)
Camera : Mobius with C2 Lens and 3D-printed vibration damping plate
Gimbal : 1 x 2-axis Martinez GBC (clone)
Gimbal Motor: 2 x Turnigy 2208
Battery: 1 x 3s 40C 6200mAH 
AUW : 1600gm.
Hovering Flight Time : 15 minutes