//
//  AnagramGenerator.swift
//  AnagramGenerator
//
//  Created by Ryu Dae-ha on 9/20/24.
//

import Foundation
import UIKit

class Generator {
    // 순열을 구하는 재귀 함수
    func getPermutations(_ str: String) -> [String] {
        var result = [String]()
        let chars = Array(str) // 문자열을 문자 배열로 변환
        
        // 재귀적으로 순열을 찾는 함수
        func permute(_ current: [Character], _ remaining: [Character]) {
            if remaining.isEmpty {
                result.append(String(current)) // 남은 문자가 없으면 순열 완성
            } else {
                for i in 0..<remaining.count {
                    var newCurrent = current
                    newCurrent.append(remaining[i]) // 현재 문자 추가
                    var newRemaining = remaining
                    newRemaining.remove(at: i) // 추가한 문자 제거
                    permute(newCurrent, newRemaining) // 재귀 호출
                }
            }
        }
        
        permute([], chars) // 초기 호출
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
