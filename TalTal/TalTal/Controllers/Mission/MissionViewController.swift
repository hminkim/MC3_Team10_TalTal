//
//  MissionViewController.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//

import UIKit

class MissionViewController: UIViewController {
    let missionAessts = MissionAessts()
    // MissionAessts()를 사용하기위해 선언
    
    //스토리보드에 있는 객체들을 연결
    @IBOutlet weak var dailyView: MissionQuestView!
    @IBOutlet weak var weeklyView: MissionQuestView!
    @IBOutlet weak var questTextLabel: UILabel!
    
    //더미 데이터입니다.
    var dailyClearQuest = 5
    var dailyQuestStirng = "햇빛이 선명하게 나뭇잎을 핥고 있었다.햇빛이 선명하게 나뭇잎을 핥고 있었다"
    
    //더미 데이터입니다.
    var weeklyClearQuest = 1
    var weeklyQuestStirng = "햇빛이 선명하게 나뭇잎을 핥고 있었다.햇빛이 선명하게 나뭇잎을 핥고 있었다"

    override func viewDidLoad() {
        super.viewDidLoad()
        questTextLabel.textColor = UIColor(hex: "8A8A8E")
        settingQuestView()
        settingTextLabel()
    }
    
}

//MARK: view의 생명주기 함수에 들어가는 부분들을 함수화 및 extension으로 빼서 사용하면 깔끔해집니다.
extension MissionViewController{
    
    //하단 주석1 참고
    private func settingTextLabel(){
        let questText1 = "지금까지\n\(dailyClearQuest)개의 일일 미션과\n"
        let questText2 = "\(weeklyClearQuest)개의 주간 미션을 완료했어요!"

        let questTextLabelString = missionAessts.changeTextColor(fullText: questText1, color: UIColor(hex: "FF8166"),changeWords: ["\(dailyClearQuest)","일일 미션"])
        
        let questTextLabelStringPart2 =  missionAessts.changeTextColor(fullText: questText2, color: UIColor(hex: "6261F8"),changeWords: ["\(weeklyClearQuest)","주간 미션"])
        
        questTextLabelString.append(questTextLabelStringPart2)
        questTextLabel.attributedText = questTextLabelString
    }
    //하단 주석2 참고
    private func settingQuestView(){
        self.dailyView.configureView(type: .daily, quest: dailyQuestStirng)
        self.weeklyView.configureView(type: .weekly, quest: weeklyQuestStirng)
        dailyView.layer.cornerRadius = missionAessts.viewCornerRadius
        weeklyView.layer.cornerRadius = missionAessts.viewCornerRadius
    }
}

/*
 하단주석 1
 changeTextColor함수의 한계점을 해결하기위해 두가지 파트로 나눠서 작성하였습니다.
 for문을 사용하면 조금더 짧게 제작 할 수 있지만 굳이 두번밖에 반복이 안되기에 이렇게 사용했으며
 추후 여러군데서 사용하게 된다면 Assets로 제작 하겠습니다.
 코드를 간단히 설명하면
 하단주석 2 questText1과 questText2의 문자열의 특정 부분을 원하는 색상으로 변경후
 questText1에 questText2를 추가해서 해당 label에 추가 하는 코드입니다.
 
 하단 주석2
 dailyView와 weekilyView는 제작한 xib파일입니다. (같은 파일)
 해당 view를 사용하기위해서 설정 하는 함수를 불러와 사용했으며
 view의 cornerRadius를 추가하기위해 값을 주었습니다.
 */
