////
////  HeadsetDemo.swift
////  MeditationAppDemo
////
////  Created by Patrick Tourniaire on 23/11/2024.
////
//
//import SwiftUI
//import AVFoundation
//import Charts
//
//struct HeadsetDemo: View {
//    @ObservedObject var viewModel = MindWaveViewModel()
//    @State private var showMeditationView = false
//    @StateObject private var meditationMusicViewModel = MeditationMusicViewModel(mindWaveViewModel: <#T##MindWaveViewModel#>)
//    
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("MindWave Connection Status: \(viewModel.connectionStatus)")
//                .font(.headline)
//                .padding()
//                .multilineTextAlignment(.center)
//            
//            Text("Signal Strength: \(viewModel.signalStrength)")
//                .font(.subheadline)
//                .padding()
//            
//            Text("Attention Level: \(viewModel.attentionLevel)")
//                .font(.subheadline)
//                .padding()
//            
//            Text("Delta Power: \(viewModel.deltaPower)")
//                .font(.subheadline)
//                .padding()
//            
//            Text("Low Beta Power: \(viewModel.lowBetaPower)")
//                .font(.subheadline)
//                .padding()
//            
//            Chart {
//                ForEach(Array(viewModel.deltaPowerValues.enumerated()), id: \ .0) { index, value in
//                    LineMark(
//                        x: .value("Time", index),
//                        y: .value("Delta Power", value)
//                    )
//                    .foregroundStyle(Color.blue)
//                }
//                ForEach(Array(viewModel.lowBetaPowerValues.enumerated()), id: \ .0) { index, value in
//                    LineMark(
//                        x: .value("Time", index),
//                        y: .value("Low Beta Power", value)
//                    )
//                    .foregroundStyle(Color.red)
//                }
//            }
//            .frame(height: 200)
//            .padding()
//            
//            HStack(spacing: 20) {
//                Button(action: {
//                    viewModel.setupMindWaveDevice()
//                    viewModel.connectToMindWave()
//                }) {
//                    Text("Connect to MindWave")
//                        .font(.body)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                
//                Button(action: {
//                    viewModel.disconnectFromMindWave()
//                }) {
//                    Text("Disconnect")
//                        .font(.body)
//                        .padding()
//                        .background(Color.red)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                
//                Button(action: {
//                    viewModel.saveDataToJSON()
//                }) {
//                    Text("Save Data")
//                        .font(.body)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//            Button(action: {
//                            showMeditationView = true
//                        }) {
//                            Text("Start Meditation")
//                                .font(.title2)
//                                .padding()
//                                .background(Color.orange)
//                                .foregroundColor(.white)
//                                .cornerRadius(15)
//                        }
//                        .padding()
//                        .sheet(isPresented: $showMeditationView) {
//                            MeditationView(viewModel: viewModel, meditationMusicViewModel: meditationMusicViewModel)
//                        }
//                    }
//                    .padding()
//    }
//}
//
//struct MeditationView: View {
//    @ObservedObject var viewModel: MindWaveViewModel
//    @ObservedObject var meditationMusicViewModel: MeditationMusicViewModel
//    
//    var body: some View {
//        ZStack {
//            Image("tree")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//                .onAppear {
//                    meditationMusicViewModel.playIntroMusic()
//                }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct MeditationView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = MindWaveViewModel()
//        MeditationView(viewModel: MindWaveViewModel(), meditationMusicViewModel: MeditationMusicViewModel(mindWaveViewModel: MindWaveViewModel))
//    }
//}
//
