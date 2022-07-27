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

    
    @IBOutlet weak var missionTypeLabel: UILabel!
    
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var reflectionLabel: UILabel!
    @IBOutlet weak var missionInformationLabel: UILabel!
    
    // TODO: 아직 더미데이터를 이용 중이라 테이블 뷰에서 넘겨받을 미션 데이터를 저장할 프로퍼티를 미리 만들어 놓았습니다, 이후 꼬마와 데이터를 어떻게 전달받을 지 상의가 끝나면 주석을 해제할 예정입니다.
//    var type: MissionType?
//    var missionString: String?
//    var dateString: String?
//    var reflectionString: String?
//    var informationString: String?
        
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    
    // MARK: - UI 생성
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9725491405, green: 0.9725491405, blue: 0.9725491405, alpha: 1)
        
        let mission: MissionType = MissionType.weekly
        
        // daily, weekly 구분
        switch mission {
        case .daily:
            missionTypeLabel.text = "일일 미션"
            missionTypeLabel.backgroundColor = UIColor(named: "PointPink")
        case .weekly:
            missionTypeLabel.text = "주간 미션"
            missionTypeLabel.backgroundColor = UIColor(named: "PointBlue")
        }
        
        // 각 UILabel의 텍스트 설정
        missionLabel.text = "잠자리를 정리하기"
        reflectionLabel.text = "졸렸지만 정리하고 나니 개운하게 하루를 시작할 수 있었다"
        missionInformationLabel.text = "매일 아침 “잠자리를 정리했다는 것”은 그날의 첫 번째 과업을 달성했다는 뜻입니다. 이 작은 성취감이 또 다른 일을 해낼 수 있겠다는 용기로 발전할 수 있을 것입니다."
        
        // 행간격 조절
        reflectionLabel.setLineSpacing(lineSpacing: 4)
        missionInformationLabel.setLineSpacing(lineSpacing: 4)
        
    }
    
    
    // MARK: - 최대 텍스트 UI 생성
    private func maxTextConfigureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9725491405, green: 0.9725491405, blue: 0.9725491405, alpha: 1)
        
        let mission: MissionType = MissionType.weekly
        
        // daily, weekly 구분
        switch mission {
        case .daily:
            missionTypeLabel.text = "일일 미션"
            missionTypeLabel.backgroundColor = UIColor(named: "PointPink")
        case .weekly:
            missionTypeLabel.text = "주간 미션"
            missionTypeLabel.backgroundColor = UIColor(named: "PointBlue")
        }
        
        // 각 UILabel의 텍스트 설정
        missionLabel.text = "최대글자최대글자최대글자최대글자최대글자최대글자최대글자최대글자"
        reflectionLabel.text = "최대글자수50자최대글자수50자최대글자수50자최대글자수50자최대글자수50자최대글자수50자최대"
        missionInformationLabel.text = "정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보정보"
        
        // 행간격 조절
        reflectionLabel.setLineSpacing(lineSpacing: 4)
        missionInformationLabel.setLineSpacing(lineSpacing: 4)
    }
    
    
    // TODO: 테이블 뷰에서 데이터를 전달 받아 뷰를 그리는 메소드입니다. 이후 꼬마와 데이터를 어떻게 전달받을 지 상의가 끝나면 이 메소드를 수정하여 configureUI()로 대체할 예정입니다.
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
// 출처: https://stackoverflow.com/questions/39158604/how-to-increase-line-spacing-in-uilabel-in-swift
