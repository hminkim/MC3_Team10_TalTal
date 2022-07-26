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
    
    @IBAction func questBtn(_ sender: Any) {
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
        self.titleLabel.text = setTitle(type: type)
        self.questLabel.text = quest
        self.backgroundColor = setBackgroundColor(type: type)
    }
}

extension MissionQuestView{
    
    func setTitle(type: MissionQuest) -> String{
        switch type{
        case.daily:
            return "오늘 해봐요"
        case.weekly:
            return "이번주에 해봐요."
        }
    }
    
     func setBackgroundColor(type: MissionQuest) -> UIColor{
        switch type{
        case.daily:
            return .red
        case.weekly:
            return .blue
        }
    }
}
