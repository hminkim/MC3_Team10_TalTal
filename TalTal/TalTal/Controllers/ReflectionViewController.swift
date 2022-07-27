//
//  ReflectionViewController.swift
//  TalTal
//
//  Created by June on 2022/07/25.
//

import UIKit

// 일간, 주간 미션 구분할 열거형 타입
enum MissionType {
    case daily
    case weekly
}

final class ReflectionViewController: UIViewController {

    
    @IBOutlet weak var missionType: UILabel!
    
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var reflectionLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    // 데이터 전달 받을 시 저장할 프로퍼티
//    var type: MissionType?
//    var missionString: String?
//    var dateString: String?
//    var reflectionString: String?
//    var informationString: String?
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
//        maxTextConfigureUI()
        
//        testConfigureUI()
        
    }
    
    
    // MARK: - UI 생성
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9725491405, green: 0.9725491405, blue: 0.9725491405, alpha: 1)
        
        let mission: MissionType = MissionType.weekly
        
        // daily, weekly 구분
        switch mission {
        case .daily:
            missionType.text = "일일 미션"
            missionType.backgroundColor = UIColor(named: "PointPink")
        case .weekly:
            missionType.text = "주간 미션"
            missionType.backgroundColor = UIColor(named: "PointBlue")
        }
        
        // 각 UILabel의 텍스트 설정
        missionLabel.text = "잠자리를 정리하기"
        reflectionLabel.text = "졸렸지만 정리하고 나니 개운하게 하루를 시작할 수 있었다"
        informationLabel.text = "매일 아침 “잠자리를 정리했다는 것”은 그날의 첫 번째 과업을 달성했다는 뜻입니다. 이 작은 성취감이 또 다른 일을 해낼 수 있겠다는 용기로 발전할 수 있을 것입니다."
        
        // 행간격 조절
        reflectionLabel.setLineSpacing(lineSpacing: 4)
        informationLabel.setLineSpacing(lineSpacing: 4)
        
    }
    
    
    // MARK: - Test: 최대 텍스트 UI 생성
    private func maxTextConfigureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9725491405, green: 0.9725491405, blue: 0.9725491405, alpha: 1)
        
        let mission: MissionType = MissionType.weekly
        
        // daily, weekly 구분
        switch mission {
        case .daily:
            missionType.text = "일일 미션"
            missionType.backgroundColor = UIColor(named: "PointPink")
        case .weekly:
            missionType.text = "주간 미션"
            missionType.backgroundColor = UIColor(named: "PointBlue")
        }
        
        // 각 UILabel의 텍스트 설정
        missionLabel.text = "최대글자최대글자최대글자최대글자최대글자최대글자최대글자최대글자"
        reflectionLabel.text = "최대글자수50자최대글자수50자최대글자수50자최대글자수50자최대글자수50자최대글자수50자최대"
        informationLabel.text = "정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보"
        
        // 행간격 조절
        reflectionLabel.setLineSpacing(lineSpacing: 4)
        informationLabel.setLineSpacing(lineSpacing: 4)
    }
    
    
    // MARK: - Test: 데이터 전달 받을 시 UI 생성
//    private func testConfigureUI() {
//        view.backgroundColor = #colorLiteral(red: 0.9725491405, green: 0.9725491405, blue: 0.9725491405, alpha: 1)
//
//        // daily, weekly 구분
//        switch type {
//        case .daily:
//            missionType.text = "일일 미션"
//            missionType.backgroundColor = UIColor(named: "PointPink")
//        case .weekly:
//            missionType.text = "주간 미션"
//            missionType.backgroundColor = UIColor(named: "PointBlue")
//        default:
//            print(#function)
//            print("error")
//        }
//
//        // 각 UILabel의 텍스트 설정
//        missionLabel.text = missionString
//        dateLabel.text = dateString
//        reflectionLabel.text = reflectionString
//        informationLabel.text = informationString
//
//        // 행간격 조절
//        reflectionLabel.setLineSpacing(lineSpacing: 4)
//        informationLabel.setLineSpacing(lineSpacing: 4)
//
//    }
    

}

// MARK: - Extension
// UILabel의 행간격 조절 메소드 추가
extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}
