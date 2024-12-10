//
//  TestingView.swift
//  Skedul
//
//  Created by skedul on 12/11/24.
//

import SwiftUI
import AVFoundation

class AudioPlayer: ObservableObject {
    var player: AVAudioPlayer?

    func playSound(soundName: String, fileType: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: fileType) {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error: Could not find and play the sound file.")
            }
        }
    }
}

struct TestingView: View {

    @StateObject private var audioPlayer = AudioPlayer()

    var body: some View {
        VStack {
            Button(action: {
                audioPlayer.playSound(soundName: "ID Short", fileType: "wav")
            }) {
                Text("Play Sound")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    TestingView()
}
