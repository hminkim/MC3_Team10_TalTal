//
//  MissionAessts.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/27.
//
//  추후 자주 쓸 것 같은 함수들은 합쳐서 싱들톤으로 디자인하겠습니다.

import UIKit

struct MissionAssets{
    // CornerRadius의 기본값을 설정해두었습니다.
    let viewCornerRadius = 20.0
    
    // TODO: 하단주석 1참고
    func changeTextColor(fullText: String, color: UIColor, changeWords: [String]) -> NSMutableAttributedString {
        let attribtuedString = NSMutableAttributedString(string: fullText)
        for changeWord in changeWords{
            let range = (fullText as NSString).range(of: "\(changeWord)")
            attribtuedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        return attribtuedString
    }
}

/*
 하단주석 1
 Label에 들어갈 텍스트의 일부만 컬러값을 주기위해 추가한 함수입니다.
 출처는 스택 오버플로우 + 제가 조금 변형했습니다.
 사용법은 다음과 같습니다.
 changeTextColor(fullText: 전체문자열, color: 컬러값 ,changeWords: ["변경할String1","변경할String2"])
 changeWords는 Array<String>으로 갯수제한은 없습니다.
 한계점: fullText가 "안녕 나는 안녕이야" 일때 changeWords["안녕"] 이면 앞에 있는 단어만 색상이 변경됩니다.
 
 해당 내용을 검색 할때 찾아봐야할 키워드
 1. NSMutableAttributedString
 */
