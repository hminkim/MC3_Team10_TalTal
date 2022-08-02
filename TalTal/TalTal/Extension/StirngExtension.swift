//
//  StirngExtension.swift
//  TalTal
//
//  Created by Ruyha on 2022/08/02.
//

import Foundation

/*
 사용법
 기존       : var testTxt = NSLocalizedString("테스트문구입니다.",comment: "")
 extension : var testTxt = "테스트 문구입니다."localizable
 출처: https://zeddios.tistory.com/368 [ZeddiOS:티스토리]
 */

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
