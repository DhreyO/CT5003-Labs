Car Indicator System (8051 Microcontroller)
📌 Overview
This project implements a car indicator system using an 8051‑based microcontroller.
The system controls an external LED strip to simulate:

Left indicator (sequential sweep)

Right indicator (sequential sweep)

Hazard mode (both sides flashing together)

Three external switches are used to activate each mode.
The firmware is written entirely in 8051 Assembly.
Hardware Used
C8051F120 / 8051 Microcontroller

External LED strip (active‑low)

3 input switches (Left, Right, Hazard)

Resistors and wiring

Breadboard / prototyping board

Power supply (5V)

All hardware images are stored in the hardware/ folder.
How It Works
Left Indicator
LEDs sweep from left to right in sequence, creating a flowing turn signal effect.

Right Indicator
LEDs sweep from right to left, mirroring the left indicator pattern.

Hazard Mode
Both sides flash simultaneously at a fixed interval.

Switch Logic
Each switch is read from a dedicated input pin.

A software toggle flag stored at RAM address 20H prevents mode overlap.

Only one mode runs at a time.
Firmware
The full assembly code is located in:
src/indicator.asm
The code includes:

LED sweep routines

Delay subroutines
Lab1-Car-Indicator/
│
├── src/
│   └── indicator.asm
│
├── hardware/
│   └── (wiring diagrams, pin maps, photos)
│
├── docs/
│   └── (lab report PDF / Word document)
│
└── README.md

Switch reading logic
Lab Report
The full academic report for this lab is stored in the docs/ folder.
Hazard toggle

Active‑low LED control
Learning Outcomes
Understanding 8051 I/O ports

Writing assembly for real hardware

Implementing sequential LED patterns

Handling switch inputs and mode control

Designing embedded systems with safety in mind

## Author
This project was designed and implemented by **Dhrey** as part of the CT5003 Embedded Systems module.
