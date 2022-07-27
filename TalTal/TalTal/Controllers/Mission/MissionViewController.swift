//
//  MissionViewController.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//  Ruyha를 작업자 이름으로 변경후 이 주석은 삭제 바람
//

import UIKit


class MissionViewController: UIViewController {

    @IBOutlet weak var dailyView: MissionQuestView!
    @IBOutlet weak var weeklyView: MissionQuestView!
    @IBOutlet weak var textLabel: UILabel!
    
    let viewCornerRadius = 20.0
    var dailyClearQuest = 0
    var weeklyClearQuest = 0
    var questText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingQuestView()
        questText = "지금까지\n\(dailyClearQuest)개의 일일 미션과\n\(weeklyClearQuest)주간 미션을 완료했어요!"
        var p1 = ppap(text: String(dailyClearQuest), color: UIColor(hex: "FF8166"))
        var p2 = ppap(text: "일일 미션과", color: UIColor(hex: "FF8166"))
        var p3 = ppap(text: String(weeklyClearQuest), color: UIColor(hex: "6261F8"))
        var p4 = ppap(text: "주간 미션", color: UIColor(hex: "6261F8"))
//        questText = "지금까지\n\(p1)개의 \(p2)\n\(p3)개의 주간 미션을 완료했어요!"
        textLabel.text = questText
        

        // Do any additional setup after loading the view.
    }
    

    

}

extension MissionViewController{
    func settingQuestView(){
        self.dailyView.configureView(type: .daily, quest: "깔깔깔갈갈갈갈ㅇㅇㅇㅇ갈갉깔깔깔갈ㅇㅇㅇㅇㅇ갈갈갈갈")
        self.weeklyView
            .configureView(type: .weekly, quest: "가나다라마바사아자차카타바파하아카카ㅏ캌")
        dailyView.layer.cornerRadius = viewCornerRadius
        weeklyView.layer.cornerRadius = viewCornerRadius

    }
    
//
//    func partialColorString(allString: String,allStringColor: UIColor ,partialString: String, partialStringColor: UIColor ) -> AttributedString {
//        var string = AttributedString(allString)
//        string.foregroundColor = allStringColor
//
//        if let range = string.range(of: partialString) {
//            string[range].foregroundColor = partialStringColor
//        }
//        return string
//    }
    
    func ppap(text: String, color: UIColor)->AttributedString{
    var string = AttributedString(text)
    string.foregroundColor = color
    return string
    }
}
