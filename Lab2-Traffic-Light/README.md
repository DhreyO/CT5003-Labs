Arduino Traffic Light Control System
📌 Overview
This project implements a complete traffic‑light control system using an Arduino, two vehicle signal sets, and a pedestrian crossing. The system operates in a default green‑light state and transitions through a full UK‑standard light sequence when the pedestrian button is pressed. The design ensures safe, realistic, and event‑driven control suitable for real‑world junction behaviour.

The system includes:

Vehicle lights: Green → Amber → Red → Red+Amber → Green

Pedestrian lights: Red → Green → Blinking Green → Red

A physical pedestrian push button

Accurate timing to simulate real traffic flow
Hardware Used
Arduino Uno

2× Vehicle LED sets (Red, Amber, Green)

Pedestrian LED set (Red, Green)

Push button for pedestrian request

Resistors and wiring

Breadboard / prototyping board

5V power supply

All hardware images are stored in the hardware/ folder.
System Behaviour
Default State
Vehicle lights stay green

Pedestrian light stays red

Pedestrian Button Press
Triggers the full UK sequence:

Vehicle Green → Amber

Amber → Red

Red → Red+Amber

Pedestrian Green ON

Pedestrian Green BLINKING (warning phase)
Safety Features
Button press is only accepted once per cycle

No overlapping states

Timing ensures safe crossing intervals

Blinking pedestrian green gives a final warning before traffic resumes
Firmware
The full Arduino code is located in:
src/TrafficLight.asm
The code includes:

Modular helper functions for each light state

Debounced button input

Accurate delay‑based timing

Pedestrian blinking logic

Clear sequencing for readability and safety
Lab2-Traffic-Light/
│
├── src/
│   └── TrafficLight.asm
│
├── hardware/
│   └── (wiring diagrams, LED layout, photos)
│
├── docs/
│   └── (lab report PDF / Word document)
│
└── README.md
Lab Conclusion (Summary)
In this lab, we implemented a complete traffic‑light control system using an Arduino, two vehicle signal sets, and a pedestrian crossing. The system responds to a pedestrian button press by executing a full UK‑standard transition sequence, ensuring safe and realistic operation of the junction. The modular design and timing logic demonstrate effective event‑driven control suitable for real‑world traffic management.

As hardware lead, I designed the LED and button interface and refined the firmware to ensure the physical system operated safely. My main contribution was implementing the blinking pedestrian‑green phase, which provides a clear visual warning and gives anyone already crossing extra time to finish before traffic resumes.
👤 Author
Created by: Dhrey
Pedestrian Red ON

Vehicle Green resumes
