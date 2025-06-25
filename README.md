# MindEase

**MindEase** is an AI-powered meditation assistant that delivers a personalized, adaptive experience by combining real-time EEG signal processing with Large Language Models (LLMs). Developed for the Consumer AI Edge Hackathon—organized by Meta, Hugging Face, Entrepreneur First, Scaleway, and PyTorch—MindEase brings together neurotechnology and edge AI for a privacy-first, on-device meditation experience.

---

## Key Features

### 1. Real-Time EEG Signal Processing

- **Device:** NeuroSky MindWave Mobile 2
- **Brainwaves Monitored:** Delta, Theta, Alpha, Beta
- **Composite Meditation Index (CMI):**
  - Calculated in real time using Fast Fourier Transform (FFT)
  - Assesses user focus and relaxation levels
- **Adaptive Algorithms:**
  - Dynamically adjust meditation sessions based on CMI
  - Ensure continuous user engagement

### 2. AI-Powered Personalized Feedback

- **LLM Integration:**
  - Uses a quantized LLaMA model for EEG session analysis and feedback
  - Delivers actionable, personalized insights
- **On-Device Processing:**
  - Runs locally on iPhone 13 (4 GB RAM) for privacy and low latency
- **Model Optimization:**
  - Quantization and pruning reduce memory footprint while maintaining performance

### 3. Real-Time Adaptive Guidance

- **Dynamic Session Adjustment:**
  - CMI-driven, real-time adaptation of meditation guidance
  - EEG data influences AI-generated voice prompts for deeper focus

### 4. Swift-Based iOS Development

- **Native App:** Built in Swift
- **CoreML Integration:** Embeds the quantized LLaMA model for on-device inference
- **Data Privacy:** All computations and data processing are performed locally
- **User Interface:**
  - Visualizes brainwave activity
  - Tracks progress across meditation sessions

---

## Outcomes

- Real-time EEG processing with adaptive meditation features
- Quantized LLaMA model optimized for mobile deployment
- Privacy-first, AI-driven meditation experience at the edge

---

## Getting Started

### Prerequisites

- iPhone 13 (or newer) with iOS 15+
- NeuroSky MindWave Mobile 2 EEG headset

### Installation

1. Clone this repository:
    ```
    git clone https://github.com/your-org/mindease.git
    ```
2. Open the project in Xcode.
3. Connect your NeuroSky MindWave Mobile 2 device.
4. Build and run the app on your iPhone.

### Usage

- Launch the MindEase app.
- Pair your EEG headset.
- Start a meditation session and receive real-time, adaptive guidance.
- Review your brainwave activity and personalized feedback after each session.

---

## Tech Stack

- **Swift** (iOS native)
- **CoreML** (on-device ML integration)
- **LLaMA** (quantized and pruned for mobile)
- **NeuroSky MindWave Mobile 2** (EEG hardware)

---

## Acknowledgments

Developed for the Consumer AI Edge Hackathon, organized by:

- Meta
- Hugging Face
- Entrepreneur First
- Scaleway
- PyTorch

---
