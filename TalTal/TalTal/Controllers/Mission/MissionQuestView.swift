//
//  MissionQuestView.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//

import UIKit


protocol MissionQuestViewDelegate {
    func didQuestButton(type: MissionQuest)
}

//MARK: 열거형을 사용하면 코드를 조금더 안전하게 사용이 가능합니다.
enum MissionQuest{
    case daily
    case weekly
}

// MARK: @IBDesignable을 사용하면 코드로 구현한 것을 스토리보드에서 확인가능하다고 합니다.
@IBDesignable
final class MissionQuestView: UIView {
    
    //값을 전달하기위해 델리게이트 패턴 사용
    var delegate: MissionQuestViewDelegate?
    
    //데일리 view인지 위클리 view인지 구분하기 위한 변수 기본값은 뭘 주든 상관없다.
    var missionType : MissionQuest = .daily
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questLabel: UILabel!
    
    // questButton의 디자인등을 수정하기 위해 연결된것
    @IBOutlet weak var questButton: UIButton!
    
    // questButton이 클릭되었을때 동작을 실행 시키키 위한 것
    @IBAction func questButton(_ sender: UIButton) {
        print("..?")
        delegate?.didQuestButton(type: missionType)
    }
    

    
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
        missionType = type
        questButtonSetting(type: type)
        titleLabelSetting(type: type)
    }
    // 제가 제작한 코드가 아니라 출처는 하단에 작성하였습니다.
}

//MARK: 기본셋팅에 관련된 함수
extension MissionQuestView{
    
    // questButton을 설정하기위한 코드들입니다.
    //  보라색 글씨를 검색하면 어떻게 사용하는건지 구글신이 알려주실겁니다.
    private func questButtonSetting(type: MissionQuest){
        self.questButton.setTitle("미션완료", for: .normal)
        self.questButton.setTitleColor(.white, for: .normal)
        self.questButton.backgroundColor = setBtnColor(type: type)
        self.questButton.layer.cornerRadius = 14
    }
    
    private func titleLabelSetting(type: MissionQuest){
        self.titleLabel.text = setTitleLabelText(type: type)
        self.titleLabel.textColor = setTitleLabeTextlColor(type: type)
    }
}


// MARK: 재사용 관련된 함수모음
// 추후 월간 미션이 생길 수도 있으니... 확장성을 고려해서 이런 방식으로 구현 하였습니다.
// 깔끔하고 보기가 좋습니다.
extension MissionQuestView{
    
    private func setTitleLabelText(type: MissionQuest) -> String{
        switch type{
        case.daily:
            return "오늘 해봐요"
        case.weekly:
            return "이번주에 해봐요"
        }
    }
    
    private func setTitleLabeTextlColor(type: MissionQuest) -> UIColor{
        switch type{
        case.daily:
            return UIColor(hex: "FF8166")
        case.weekly:
            return UIColor(hex: "6261F8")
        }
    }
    
    
    private func setBackgroundColor(type: MissionQuest) -> UIColor{
        switch type{
        case.daily:
            return UIColor(hex: "FFF6F4")
        case.weekly:
            return UIColor(hex: "F4F4FF")
        }
    }
    
    private func setBtnColor(type: MissionQuest) -> UIColor{
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
