//
//  GenerationView.swift
//  AnagramGenerator
//
//  Created by Ryu Dae-ha on 9/20/24.
//

import SwiftUI

struct GenerationView: View {
    @State private var result: String = ""
    @State private var keyword: String = ""
    @State private var name: String = ""
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Keyword")) {
                    TextField("Enter your keyword", text: $keyword)
                        .textInputAutocapitalization(.characters)
                }
                Section(header: Text("Private info")) {
                    TextField("Enter your name", text: $name)
                        .textInputAutocapitalization(.characters)
                    DatePicker("Birthday", selection: $selectedDate, displayedComponents: .date)
                        .foregroundStyle(.secondary)
                }
                Button {
                    result = "TEST TEXT"
                } label: {
                    Text("Generate Anagrams")
                }
                
                Section(header: Text("Result anagrams")) {
                    Text(result)
                }
            }
            .navigationBarTitle(Text("Anagrams"))
        }
    }
}

#Preview {
    GenerationView()
}
