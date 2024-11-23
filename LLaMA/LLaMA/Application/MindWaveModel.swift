//
//  NeuroSkyDeviceManager.swift
//  MeditationAppDemo
//
//  Created by Ivan Kozlov on 22/11/2024.
//

import Foundation
import Combine
import ExternalAccessory
import UniformTypeIdentifiers
import UIKit

class MindWaveViewModel: NSObject, ObservableObject, MWMDelegate {
    @Published var compositeMeditationIndexValues: [Double] = [] // Track Composite Meditation Index values
    @Published var normCompositeMeditationIndexValues: [Double] = []
    // MARK: - Published Properties for UI Updates
    @Published var connectionStatus: String = "Not Connected"
    @Published var signalStrength: String = "N/A"
    @Published var attentionLevel: String = "N/A"
    @Published var isConnected: Bool = false // Track the connection state
    @Published var deltaPower: String = "N/A" // To show Delta power level
    @Published var lowBetaPower: String = "N/A" // To show Low Beta power level
    
    @Published var attentionValues: [Int32] = [] // Storing attention values
    @Published var meditationValues: [Int32] = [] // Storing meditation values
    
    @Published var deltaPowerValues: [Int32] = [] // Track Delta power values for chart
    @Published var thetaValues: [Int32] = [] // Storing thetaValues
    @Published var lowAlpha: [Int32] = [] // Storing lowAlpha
    @Published var highAlpha: [Int32] = [] // Storing highAlpha
    
    @Published var lowBetaPowerValues: [Int32] = [] // Track Low Beta power values for chart
    @Published var highBetaValues: [Int32] = [] // Storing highBetaValues
    @Published var lowGammaValues: [Int32] = [] // Storing lowGammaValues
    @Published var midGammaValues: [Int32] = [] // Storing midGammaValues
    
    @Published var currentAudio: String = ""
    
    @Published var rawPoints: [Int32] = []
    private var newPointsCounter: Int = 0
    
    private var state2Audio: [Int: String] = [
            1: "intro",
            2: "low_focus",
            3: "medium_focus",
            4: "high_focus",
            5: "body",
            6: "low_focus_2",
            7: "medium_focus_2",
            8: "high_focus_2",
            9: "closing"
        ]
    
    // Add states and their transitions
    private let responseStates: [Int] = [2, 3, 4, 6, 7, 8]
    
    private var stateTransitions: [Int: [Int]] = [
        1: [2, 3, 4],
        2: [5],
        3: [5],
        4: [5],
        5: [6, 7, 8],
        6: [9],
        7: [9],
        8: [9]
    ]
    
    private var currentState = 1;

    private var mwmDevice: MWMDevice?
    
    override init() {
        super.init()
    }
    
    // MARK: - Setup Device
    func setupMindWaveDevice() {
        // Ensure ExternalAccessory framework is properly added and Info.plist has correct entries
        mwmDevice = MWMDevice.sharedInstance() // Get the shared instance of MWMDevice
        mwmDevice?.delegate = self // Set the delegate to handle data callbacks
    }
    
    // MARK: - Connect to MindWave
    func connectToMindWave() {
        guard let mwmDevice = mwmDevice else {
            connectionStatus = "MWM Device not initialized"
            return
        }
        
        // Start scanning for MindWave devices
        mwmDevice.scanDevice()
        connectionStatus = "Scanning for devices..."
    }
    
    func disconnectFromMindWave() {
        mwmDevice?.disconnectDevice() // Disconnect the device
        connectionStatus = "Disconnected"
        isConnected = false
    }
    
    // MARK: - Save Data to JSON
    func saveDataToJSON() {
            let dataToSave: [String: [Int32]] = [
                "attentionValues": attentionValues,
                "meditationValues": meditationValues,
                "deltaPowerValues": deltaPowerValues,
                "thetaValues": thetaValues,
                "lowAlpha": lowAlpha,
                "highAlpha": highAlpha,
                "lowBetaPowerValues": lowBetaPowerValues,
                "highBetaValues": highBetaValues,
                "lowGammaValues": lowGammaValues,
                "midGammaValues": midGammaValues
            ]
            
            do {
                let jsonData = try JSONEncoder().encode(dataToSave)
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("mindwave_data_concentrated.json")
                try jsonData.write(to: tempURL)
                
                let documentPicker = UIDocumentPickerViewController(forExporting: [tempURL], asCopy: true)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(documentPicker, animated: true, completion: nil)
                }
            } catch {
                print("Failed to save data: \(error)")
            }
        }
    
    // MARK: - MWMDelegate Methods
    
    // Device found callback
    func deviceFound(_ devName: String, mfgID: String, deviceID: String) {
        DispatchQueue.main.async {
            self.connectionStatus = "Device Found: \(devName), connecting..."
        }
        mwmDevice?.connect(deviceID)
    }
    
    // Device connected callback
    func didConnect() {
        DispatchQueue.main.async {
            self.connectionStatus = "Connected"
            self.isConnected = true
        }
    }
    
    // Device disconnected callback
    func didDisconnect() {
        DispatchQueue.main.async {
            self.connectionStatus = "Disconnected"
            self.isConnected = false
        }
    }
    
    // Callback for raw EEG data - Correct signature according to documentation
    func eegSample(_ sample: Int32) {
        // Ensure the method matches the type required by the SDK (in this case, Int32)
        DispatchQueue.main.async {
            //print("EEG Sample: \(sample)")
            self.rawPoints.append(sample)
        }
    }
    
    // Callback for eSense data (attention and meditation) - Correct signature
    func eSense(_ poorSignal: Int32, attention: Int32, meditation: Int32) {
        DispatchQueue.main.async {
            self.signalStrength = poorSignal == 0 ? "Good" : "Weak (\(poorSignal))"
            self.attentionLevel = "\(attention)"
            self.attentionValues.append(attention)
            self.meditationValues.append(meditation)
        }
    }
    
    // Callback for EEG power bands - Correct signature
    func eegPowerDelta(_ delta: Int32, theta: Int32, lowAlpha: Int32, highAlpha: Int32) {
        DispatchQueue.main.async {
            self.deltaPower = "Delta: \(delta)"
            self.deltaPowerValues.append(delta)
            self.thetaValues.append(theta)
            self.lowAlpha.append(lowAlpha)
            self.highAlpha.append(highAlpha)
            self.newPointsCounter += 1
                        // Check if we have collected 15 new points after the last calculation
                        if self.newPointsCounter >= 15 &&
                           self.deltaPowerValues.count >= 15 && self.thetaValues.count >= 15 &&
                           self.lowAlpha.count >= 15 && self.highAlpha.count >= 15 &&
                           self.lowBetaPowerValues.count >= 15 && self.highBetaValues.count >= 15 {
                            // Compute averages of the latest 15 values for each parameter
                            let avgDelta = self.deltaPowerValues.suffix(15).map { Double($0) }.reduce(0, +) / 15.0
                            let avgTheta = self.thetaValues.suffix(15).map { Double($0) }.reduce(0, +) / 15.0
                            let avgLowAlpha = self.lowAlpha.suffix(15).map { Double($0) }.reduce(0, +) / 15.0
                            let avgHighAlpha = self.highAlpha.suffix(15).map { Double($0) }.reduce(0, +) / 15.0
                            let avgLowBeta = self.lowBetaPowerValues.suffix(15).map { Double($0) }.reduce(0, +) / 15.0
                            let avgHighBeta = self.highBetaValues.suffix(15).map { Double($0) }.reduce(0, +) / 15.0
                            // Calculate the composite meditation index
                            var compositeIndex = self.computeCompositeMeditationIndex(
                                delta: avgDelta, theta: avgTheta,
                                lowAlpha: avgLowAlpha, highAlpha: avgHighAlpha,
                                lowBeta: avgLowBeta, highBeta: avgHighBeta
                            )
                            var mean: Double = 39651.79
                            var std: Double = 19597.91
                            
                            self.normCompositeMeditationIndexValues.append((compositeIndex - mean) / std)
                            // Store the computed composite index
                            self.compositeMeditationIndexValues.append(compositeIndex)
                            print(compositeIndex)
                            // Reset the counter to start accumulating a new batch of 15 points
                            self.newPointsCounter = 14
                        }
        }
    }
    
    private func computeCompositeMeditationIndex(delta: Double, theta: Double, lowAlpha: Double, highAlpha: Double, lowBeta: Double, highBeta: Double) -> Double {
                let w1 = 0.4 // Weight for Theta-to-Beta Ratio
                let w2 = 0.4 // Weight for Alpha-Theta Composite
                let w3 = 0.2 // Weight for Delta Power
                let epsilon = 1e-6 // Small constant to avoid division by zero
                
                let thetaToBeta = theta / (lowBeta + highBeta + epsilon)
                let alphaThetaComposite = (theta + (lowAlpha + highAlpha) / 2) / 2
                let deltaComponent = delta
                
                return w1 * thetaToBeta + w2 * alphaThetaComposite + w3 * deltaComponent
            }
    
    func eegPowerLowBeta(_ lowBeta: Int32, highBeta: Int32, lowGamma: Int32, midGamma: Int32) {
        DispatchQueue.main.async {
            self.lowBetaPower = "Low Beta: \(lowBeta)"
            self.lowBetaPowerValues.append(lowBeta)
            self.highBetaValues.append(highBeta)
            self.lowGammaValues.append(lowGamma)
            self.midGammaValues.append(midGamma)
            //print("EEG Power Bands - Low Beta: \(lowBeta), High Beta: \(highBeta), Low Gamma: \(lowGamma), Mid Gamma: \(midGamma)")
        }
    }
    
    // BLE Exception Event callback - Correct signature
    func exceptionMessage(_ eventType: TGBleExceptionEvent) {
        DispatchQueue.main.async {
            self.connectionStatus = "Exception: \(eventType)"
        }
    }
    
    func updateAudioState() {
            // Ensure there are at least 3 values in normCompositeMeditationIndexValues
            guard normCompositeMeditationIndexValues.count >= 3 else {
                return
            }
            
            currentAudio = "intro"
            
            if currentState == 9 {
                currentState = 1
                currentAudio = state2Audio[currentState] ?? "intro"
            }
                
            if currentState == 1 || currentState == 5 {
                if let lastValue = normCompositeMeditationIndexValues.last {
                    if lastValue < -1.0 {
                        currentState = currentState == 1 ? 2 : 6
                        currentAudio = state2Audio[currentState] ?? "intro"
                    } else if lastValue > -1.0 && lastValue < 1.0 {
                        currentState = currentState == 1 ? 3 : 7
                        currentAudio = state2Audio[currentState] ?? "intro"
                    } else if lastValue > 1.0 {
                        currentState = currentState == 1 ? 4 : 8
                        currentAudio = state2Audio[currentState] ?? "intro"
                    }
                }
            } else {
                currentState = stateTransitions[currentState]?.first ?? 1
                currentAudio = state2Audio[currentState] ?? "intro"
            }
        }
}
