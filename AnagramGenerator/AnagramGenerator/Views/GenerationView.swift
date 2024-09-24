//
//  GenerationView.swift
//  AnagramGenerator
//
//  Created by Ryu Dae-ha on 9/20/24.
//

import SwiftUI

struct GenerationView: View {
    @State private var generator = Generator()
    
    @State private var anagrams: [String] = [""]
    @State private var keyword: String = ""
    @State private var name: String = ""
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Keyword")) {
                    TextField("Enter your keyword", text: $keyword)
                }
                Section(header: Text("Private info")) {
                    TextField("Enter your name", text: $name)
                        .onChange(of: name) {
                            name = name.lowercased()  // 입력값을 소문자로 변환
                        }
                    DatePicker("Birthday", selection: $selectedDate, displayedComponents: .date)
                        .foregroundStyle(.secondary)
                }
                Button {
                    if keyword != "" && name != "" {
                        anagrams = generator.generateAnagrams(name)
                    }
                } label: {
                    Text("Generate Anagrams")
                }
                
                Section(header: Text("Result anagrams")) {
                    List {
                        ForEach(anagrams, id: \.self) { anagram in
                            Text(anagram)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Anagrams"))
        }
    }
}

#Preview {
    GenerationView()
}
