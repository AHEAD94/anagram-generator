//
//  AnagramGenerator.swift
//  AnagramGenerator
//
//  Created by Ryu Dae-ha on 9/20/24.
//

import Foundation
import UIKit

class Generator {
    // 순열을 구하는 heap 함수
    func getPermutations(_ str: String) -> [String] {
        var chars = Array(str)
        var result: [String] = []

        func generate(_ n: Int) {
            if n == 1 {
                result.append(String(chars))
                return
            }

            for i in 0..<n {
                generate(n - 1)

                if n % 2 == 0 {
                    chars.swapAt(i, n - 1)
                } else {
                    chars.swapAt(0, n - 1)
                }
            }
        }

        generate(chars.count)
        return Array(Set(result))
    }

    // UITextChecker를 이용해 실제 존재하는 단어인지 확인하는 함수
    func isRealWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

    // 문자열의 순열 중 실제 존재하는 단어들을 반환하는 함수
    func generateAnagrams(_ input: String) -> [String] {
        let permutations = getPermutations(input)
        var anagrams: [String] = []
        
        for word in permutations {
            if isRealWord(word) && word != input {
                anagrams.append(word)
            }
        }
        
        anagrams.sort()
        
        return anagrams
    }
}
