//
//  GenerationView.swift
//  AnagramGenerator
//
//  Created by Ryu Dae-ha on 9/20/24.
//

import SwiftUI

struct GenerationView: View {
    // AnagramGenerator는 9개의 문자까지만 애너그램을 생성해야 함
    // 문자 10개가 넘는 문자열에 대해 애너그램 생성 시, 순열을 계산하는 시간이 매우 길기 때문
    // 순열을 생성하는 알고리즘은 O(n!)의 시간 복잡도를 보유
    @State private var generator = Generator()
    
    @State private var anagrams: [String] = [""]
    @State private var keyword: String = ""
    @State private var name: String = ""
    @State private var selectedDate = Date()
    
    let maxNameLen: Int = 9
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Keyword")) {
                    TextField("Enter your keyword", text: $keyword)
                }
                Section(header: Text("Private info")) {
                    TextField("Enter your name", text: $name)
                        .onChange(of: name) {
                            name = name.lowercased() // 입력값을 소문자로 변환
                        }
                    DatePicker("Birthday", selection: $selectedDate, displayedComponents: .date)
                        .foregroundStyle(.secondary)
                }
                Button {
                    if keyword != "" && name != "" {
                        anagrams.removeAll()
                        anagrams = generator.generateAnagrams(name, anagrams)
                    }
                } label: {
                    Text("Generate Anagrams")
                }
                .disabled(name.count > maxNameLen)
                
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
