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
    
    var missionData: CompleteMission?
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    
    // MARK: - UI 생성
    private func configureUI() {
        
        view.backgroundColor = #colorLiteral(red: 0.9725491405, green: 0.9725491405, blue: 0.9725491405, alpha: 1)
        
        // daily, weekly 구분
        switch missionData?.type {
        case .daily:
            missionTypeLabel.text = "일일 미션"
            missionTypeLabel.backgroundColor = UIColor(named: "PointPink")
        case .weekly:
            missionTypeLabel.text = "주간 미션"
            missionTypeLabel.backgroundColor = UIColor(named: "PointBlue")
        default:
            print("Error Occurred on Switch in Reflection View!")
            break
        }
        
        let now = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd."
        
        // 각 UILabel의 텍스트 설정
        missionLabel.text = missionData?.content
        dateLabel.text = dateFormatter.string(from: missionData?.clearDate ?? Date.now)
        reflectionLabel.text = missionData?.reflection
        missionInformationLabel.text = missionData?.intention
        
        // 행간격 조절
        reflectionLabel.setLineSpacing(lineSpacing: 4)
        missionInformationLabel.setLineSpacing(lineSpacing: 4)
        
    }

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
