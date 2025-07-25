
# Audio Signal Filtering in MATLAB

This project implements an audio signal filtering pipeline using MATLAB. It reads an input `.wav` file and applies low-pass, band-pass, and high-pass filtering, then combines the filtered signals and plays back the original and processed versions. It also visualizes the time and frequency domain characteristics of the signals.

## Features

- **Low-Pass Filter:** Isolates frequencies below a specified cutoff.
- **High-Pass Filter:** Isolates frequencies above a specified cutoff.
- **Band-Pass Filter:** Allows frequencies within a certain range.
- **Custom Gain Control:** Applies adjustable gains to different frequency bands.
- **Normalization:** Ensures the final output signal is scaled appropriately.
- **Visualization:** Plots time-domain and frequency-domain representations.
- **Playback:** Plays both the original and processed audio.

## Files

- `analog_converted.m` — Main MATLAB script containing all filter functions and processing logic.
- `WhatsApp Audio 2025-04-01 at 11.33.37_7c47a7b8.wav` — Input audio file used in the script (you need to provide this in the same directory).

## How to Use

1. Open `analog_converted.m` in MATLAB.
2. Make sure the audio file is in the same directory as the script.
3. Run the script.
4. Observe the plots and listen to the audio playback.

## Requirements

- MATLAB (R2016b or later recommended)
- Signal Processing Toolbox (for functions like `audioread`, `fft`, `conv`, etc.)

## Notes

- If you wish to use a different audio file, change the path in the `audioread` line.
- Playback pauses are automatically handled to allow full listening.

---

© 2025 Audio Signal Filtering Project
