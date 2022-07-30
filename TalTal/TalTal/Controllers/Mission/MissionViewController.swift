//
//  MissionViewController.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//

import UIKit
@IBDesignable
final class MissionViewController: UIViewController {
    let missionAessts = MissionAssets()
    // MissionAessts()를 사용하기위해 선언
    
    //스토리보드에 있는 객체들을 연결
    @IBOutlet weak var dailyView: MissionQuestView!
    @IBOutlet weak var weeklyView: MissionQuestView!
    @IBOutlet weak var questTextLabel: UILabel!
    
    // 유저디폴트
    let defaults = UserDefaults.standard
    
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
        configureMission()
    }
    
}

//MARK: MissionQuestVeiw의 questButton이 클릭 되었때 동작하는 것
//델리게이트 패턴을 사용해 데일리인지 위클리 인지 확인한다.
extension MissionViewController : MissionQuestViewDelegate{
    func didQuestButton(type: MissionQuest) {
        print("이거눌림 \(type)")
        
        //코드로 뷰를 Show하는 부분 입니다.
        let storyboard = UIStoryboard(name: "MissionClear", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "MissionClear") as! MissionClearViewController
        secondVC.missionType = type
        secondVC.delegate = self
        show(secondVC, sender: self)
    }
}

//MARK: 미션 클리어 뷰가 닫힐떄 미션뷰가 소환한 미션퀘스트뷰에 접근해 버튼을 비활성화 시킨다.
extension MissionViewController : MissionClearViewDelegate{
    func confirmButtonClicked(type: MissionQuest) {
        questButtonIsUnabled(type: type)
      }
    
    //굳이 confirmButtonClicked안에 안넣은 이유는
    //뷰가 로드 될때도 사용해야되기 때문
    //버튼 사용불가 만들기
    func questButtonIsUnabled(type:MissionQuest){
        switch type{
        case.daily:
            dailyView.questButtonClose()
        case.weekly:
            weeklyView.questButtonClose()
        }
    }
    
    //버튼 사용 가능 만들기
    //그냥 뷰를 리로드 시키면 될지도..?
    func questButtonIsEnabled(type:MissionQuest){
        switch type{
        case.daily:
            dailyView.questButtonClose()
        case.weekly:
            weeklyView.questButtonClose()
        }
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
        dailyView.delegate = self
        weeklyView.delegate = self
        dailyView.layer.cornerRadius = missionAessts.viewCornerRadius
        weeklyView.layer.cornerRadius = missionAessts.viewCornerRadius
    }
}

extension MissionViewController {
    
    private func configureMission() {
        
        // 앱 첫 실행 검사
        guard let _ = defaults.object(forKey: "refreshDailyMissionDate") else {
            // 앱이 처음으로 켜지면 기본 값을 유저디폴트에 저장
            defaults.set(Date.now.addingTimeInterval(3600 * 24), forKey: "refreshDailyMissionDate")
            defaults.set(Date.now.addingTimeInterval(3600 * 24 * 7), forKey: "refreshWeeklyMissionDate")
            defaults.set(MissionStage.beginner.rawValue, forKey: "userStage")
            defaults.set(MissionDataManager.shared.requestDailyMission(stage: .beginner)!.content, forKey: "currentDailyMission")
            defaults.set(MissionDataManager.shared.requestDailyMission(stage: .beginner)!.content, forKey: "currentWeeklyMission")
            defaults.set(0, forKey: "dailyClearMission")
            defaults.set(0, forKey: "weeklyClearMission")
            return
        }
        
        // 앱에 접속한 날짜와 refresh가 되어야 할 날짜를 비교하기 위해 DateFormatter을 사용했습니다
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd."
        
        guard let currentUserStage = MissionStage(rawValue: defaults.string(forKey: "userStage") ?? "") else { return }
        // TODO: 모든 미션을 깬 경우 처리를 해야합니다(엔딩뷰)
        guard let nextDailyMission = MissionDataManager.shared.requestDailyMission(stage: currentUserStage),
              let nextWeeklyMission = MissionDataManager.shared.requestWeeklyMission(stage: currentUserStage) else { return }
        
        // 필요하면 일일 미션 변경
        if dateFormatter.string(from: Date.now) >= dateFormatter.string(from: defaults.object(forKey: "refreshDailyMissionDate") as? Date ?? Date.now) {
            
            // 유저디폴트 업데이트
            defaults.set(Date.now.addingTimeInterval(3600 * 24), forKey: "refreshDailyMissionDate")
            defaults.set(nextDailyMission.content, forKey: "currentDailyMission")
            defaults.set(defaults.integer(forKey: "dailyClearMission") + 1, forKey: "dailyClearMission")
            
        }
        
        // 필요하면 주간 미션 변경
        if dateFormatter.string(from: Date.now) >= dateFormatter.string(from: defaults.object(forKey: "refreshWeeklyMissionDate") as? Date ?? Date.now) {
            
            // 유저디폴트 업데이트
            defaults.set(Date.now.addingTimeInterval(3600 * 24 * 7), forKey: "refreshWeeklyMissionDate")
            defaults.set(nextWeeklyMission.content, forKey: "currentWeeklyMission")
            defaults.set(defaults.integer(forKey: "weeklyClearMission") + 1, forKey: "weeklyClearMission")
            
        }
        
        // 미션 클리어 갯수를 체크하여 userStage를 변경합니다
        if defaults.integer(forKey: "dailyClearMission") >= 7 {
            defaults.set(MissionStage.intermediate.rawValue, forKey: "userStage")
        } else if defaults.integer(forKey: "dailyClearMission") >= 13 {
            defaults.set(MissionStage.advancded.rawValue, forKey: "userStage")
        }
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
