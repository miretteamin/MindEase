# MindEase
As part of the Consumer AI Edge Hackathon, organized by Meta, Hugging Face, Entrepreneur First, Scaleway, and PyTorch, our team developed MindEase, a meditation assistant combining real-time EEG signal processing and Large Language Models (LLMs) to deliver a personalized and adaptive experience.

## Key Features

1. Real-Time EEG Signal Processing
Using the NeuroSky MindWave Mobile 2, we captured EEG signals focusing on Delta, Theta, Alpha, and Beta brainwave frequencies.



A Composite Meditation Index (CMI) was calculated in real-time using Fast Fourier Transform (FFT) to assess focus and relaxation levels.

Adaptive algorithms used the CMI to dynamically adjust meditation sessions, ensuring user engagement.


2. AI-Powered Personalized Feedback
MindEase integrated LLaMA, a pre-trained LLM, to analyze EEG session metrics and deliver actionable insights tailored to user performance.

The model ran locally on an iPhone 13 (4 GB RAM), ensuring privacy and low latency.

Techniques like quantization and model pruning reduced the model’s memory footprint while maintaining performance.


3. Real-Time Adaptive Guidance
The CMI guided session adjustments in real time. EEG data influenced AI-generated voice prompts, helping users achieve deeper focus during meditation.


4. Swift-Based iOS Development
The app was built natively in Swift, leveraging CoreML to integrate the quantized LLaMA model.



All computations were performed on-device, prioritizing privacy and responsiveness.

The user interface visualized brainwave activity and tracked progress across sessions.


## Outcomes

- Real-time EEG processing with adaptive meditation features.

- A quantized LLaMA model optimized for mobile devices.

- A privacy-first, AI-driven meditation experience combining neurotechnology and edge AI.
