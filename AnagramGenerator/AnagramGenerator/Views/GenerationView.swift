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
    
    // 1~12 숫자를 월 이름으로 변환하는 딕셔너리
    let monthDic: [Int: String] = [
        1: "jan", 2: "feb", 3: "mar", 4: "apr",
        5: "may", 6: "jun", 7: "jul", 8: "aug",
        9: "sep", 10: "oct", 11: "nov", 12: "dec"
    ]
    
    let maxInputLen: Int = 9
    let monthLen: Int = 3
    
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
                    if name != "" {
                        anagrams.removeAll()
                        anagrams = generator.generateAnagrams(name, anagrams)
                        
                        if name.count + monthLen <= maxInputLen {
                            let calendar: Calendar = .current
                            let component = calendar.dateComponents([.month], from: selectedDate)
                            
                            if let monthNumber = component.month { // optional binding으로 month를 안전하게 언래핑
                                let monthName = monthDic[monthNumber] ?? "" // nil인 경우 빈 문자열 사용
                                let withMonth = name + monthName
                                anagrams = generator.generateAnagrams(withMonth, anagrams)
                            }
                        }
                    }
                } label: {
                    Text("Generate Anagrams")
                }
                .disabled(name.count > maxInputLen)
                
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
