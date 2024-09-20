//
//  AnagramGenerator.swift
//  AnagramGenerator
//
//  Created by Ryu Dae-ha on 9/20/24.
//

import Foundation

class Generator {
    func permutations(_ str: String) -> [String] {
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
        return result
    }
}
