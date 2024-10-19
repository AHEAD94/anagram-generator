//
//  AnagramGenerator.swift
//  AnagramGenerator
//
//  Created by Ryu Dae-ha on 9/20/24.
//

import Foundation
import UIKit

class Generator {
    // 순열을 구하는 backtracking 함수
    func getPermutations(_ str: String) -> [String] {
        var result = Set<String>()
        var chars = Array(str)
        chars.sort()
        
        func backtrack(_ path: String, _ visited: inout [Bool]) {
            if path.count == chars.count {
                result.insert(path)
                return
            }
            
            for i in 0..<chars.count {
                // 이미 방문한 문자이거나, 이전 문자와 같고 이전 문자가 방문된 경우 스킵
                if visited[i] || (i > 0 && chars[i] == chars[i - 1] && !visited[i - 1]) {
                    continue
                }
                
                visited[i] = true
                backtrack(path + String(chars[i]), &visited)
                visited[i] = false
            }
        }
        
        var visited = [Bool](repeating: false, count: chars.count)
        backtrack("", &visited)
        
        return Array(result)
    }

    // UITextChecker를 이용해 실제 존재하는 단어인지 확인하는 함수
    func isRealWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

    // 문자열의 순열 중 실제 존재하는 단어들을 반환하는 함수
    func generateAnagrams(_ input: String, _ prevAnagrams: [String]) -> [String] {
        let permutations = getPermutations(input)
        var anagrams = prevAnagrams
        
        for word in permutations {
            if isRealWord(word) {
                anagrams.append(word)
            }
        }
        
        anagrams.sort()
        
        return anagrams
    }
}
