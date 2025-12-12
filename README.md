# FLASHADC
✨ Completed a Flash ADC Thermometric-to-Binary Encoder with Bubble Correction (RTL + Verification)  Excited to share a recent digital design &amp; verification project I completed as part of my learning in RTL design and mixed-signal interfacing.  
🔍 Project Overview

Designed a complete Flash ADC Encoder that converts a 255-bit thermometer code from a Flash ADC into an 8-bit binary output.
The design includes:

Thermometer-to-Binary Priority Encoder (synthesizable, fully combinational)

1-bit Bubble Error Correction logic to remove comparator noise

Pipelined architecture with 1-cycle latency for high-speed operation

Clean, modular RTL written fully in Verilog

🧪 Verification Highlights

Built a Verilog testbench that:

Generates ideal thermometer patterns (0–254 range)

Injects controlled bubble errors (single-bit flips)

Checks output against a golden model

Verifies pipeline timing behavior

Dumps VCD waveforms for analysis

Successfully validated:

✔ Correct thermometer generation
✔ Bubble suppression
✔ Correct highest-1 detection
✔ Stable binary output after 1 clock cycle
