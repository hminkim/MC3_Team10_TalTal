//
//  MissionQuestView.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//

import UIKit

enum MissionQuest{
    case daily
    case weekly
}

@IBDesignable
final class MissionQuestView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var questLabel: UILabel!
    
    @IBOutlet weak var questBtn: UIButton!
    
    
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
        questBtnSetting(type: type)
        titleLabelSetting(type: type)
        questLabelSetting()
    }
}

//MARK: 기본셋팅에 관련된 함수
extension MissionQuestView{
    
    func questBtnSetting(type: MissionQuest){
        self.questBtn.setTitle("미션완료", for: .normal)
        self.questBtn.setTitleColor(.white, for: .normal)
        self.questBtn.backgroundColor = setBtnColor(type: type)
        self.questBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        self.questBtn.layer.cornerRadius = 14
    }
    
    func titleLabelSetting(type: MissionQuest){
        self.titleLabel.text = setTitleLabelText(type: type)
        self.titleLabel.textColor = setTitleLabeTextlColor(type: type)
    }
    
    func questLabelSetting(){
        self.questLabel.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    
}


//MARK: 재사용 관련된 함수모음
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
