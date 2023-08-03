//
//  ContentView.swift
//  AsianLan
//
//  Created by Sachin Khanna on 12/2/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var words = [String]()
    @State private var selectedWord = ""
    @State private var isSpeaking = false
    
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        VStack {
            TextField("Enter a word", text: $selectedWord)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(5.0)
            
            Button(action: {
                self.words.append(self.selectedWord)
                self.selectedWord = ""
            }) {
                Text("Add Word")
            }
            
            Button(action: {
                guard !self.words.isEmpty else {
                    return
                }
                
                self.selectedWord = self.words.randomElement()!
                self.speak()
            }) {
                Text("Pick a Word")
            }
        }
    }
    
    func speak() {
        guard !selectedWord.isEmpty else {
            return
        }
        
        if isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
            return
        }
        
        let utterance = AVSpeechUtterance(string: selectedWord)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        synthesizer.speak(utterance)
        isSpeaking = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
