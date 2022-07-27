//
//  MissionQuestView.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//

import UIKit

//MARK: 열거형을 사용하면 코드를 조금더 안전하게 사용이 가능합니다.
enum MissionQuest{
    case daily
    case weekly
}

// MARK: @IBDesignable을 사용하면 코드로 구현한 것을 스토리보드에서 확인가능하다고 합니다.
@IBDesignable
final class MissionQuestView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var questButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "MissionQuestView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    
    func configureView(type: MissionQuest, quest: String){
        self.questLabel.text = quest
        self.backgroundColor = setBackgroundColor(type: type)
        questButtonSetting(type: type)
        titleLabelSetting(type: type)
    }
    // 제가 제작한 코드가 아니라 출처는 하단에 작성하였습니다.
}

//MARK: 기본셋팅에 관련된 함수
extension MissionQuestView{
    
    // questButton을 설정하기위한 코드들입니다.
    //  보라색 글씨를 검색하면 어떻게 사용하는건지 구글신이 알려주실겁니다.
    func questButtonSetting(type: MissionQuest){
        self.questButton.setTitle("미션완료", for: .normal)
        self.questButton.setTitleColor(.white, for: .normal)
        self.questButton.backgroundColor = setBtnColor(type: type)
        self.questButton.layer.cornerRadius = 14
    }
    
    func titleLabelSetting(type: MissionQuest){
        self.titleLabel.text = setTitleLabelText(type: type)
        self.titleLabel.textColor = setTitleLabeTextlColor(type: type)
    }
}


// MARK: 재사용 관련된 함수모음
// 추후 월간 미션이 생길 수도 있으니... 확장성을 고려해서 이런 방식으로 구현 하였습니다.
// 깔끔하고 보기가 좋습니다.
extension MissionQuestView{
    
    func setTitleLabelText(type: MissionQuest) -> String{
        switch type{
        case.daily:
            return "오늘 해봐요"
        case.weekly:
            return "이번주에 해봐요"
        }
    }
    
    func setTitleLabeTextlColor(type: MissionQuest) -> UIColor{
        switch type{
        case.daily:
            return UIColor(hex: "FF8166")
        case.weekly:
            return UIColor(hex: "6261F8")
        }
    }
    
    
    func setBackgroundColor(type: MissionQuest) -> UIColor{
        switch type{
        case.daily:
            return UIColor(hex: "FFF6F4")
        case.weekly:
            return UIColor(hex: "F4F4FF")
        }
    }
    
    func setBtnColor(type: MissionQuest) -> UIColor{
        switch type{
        case.daily:
            return UIColor(hex: "FF8166")
        case.weekly:
            return UIColor(hex: "6261F8")
        }
    }
}

/*  MARK: 코드출처
 https://www.youtube.com/watch?v=-KTAgaX13s8
 xib 파일을 추가해서 디자인해보자...
 */
