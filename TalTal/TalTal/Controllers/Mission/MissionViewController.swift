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
    
    //MARK: 준아가 여기보세요 <- 확인 🦉
    /*
     유저디폴트에서 주간 미션과 일간 미션을 받아오게 만들어서 아래의 변수에 넣거나
     함수에 값을가져오게 만들어주세요.
     */
    var dailyBtnValue = false //true 클리어함
    var weeklyBtnValue = false //false 아직클리어안함
    
    var dailyClearQuest = 5
    var dailyQuestStirng = "안녕하세요. 탈탈입니다."
    
    var weeklyClearQuest = 1
    var weeklyQuestStirng = "안녕하세요. 탈탈입니다."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMission()
        questTextLabel.textColor = UIColor(hex: "8A8A8E")
        settingQuestView()
        settingTextLabel()
        isMissonClear(daily: dailyBtnValue, weekly: weeklyBtnValue)
    }
    
}

//MARK: MissionQuestVeiw의 questButton이 클릭 되었때 동작하는 것
//델리게이트 패턴을 사용해 데일리인지 위클리 인지 확인한다.
extension MissionViewController : MissionQuestViewDelegate{
    func didQuestButton(type: MissionQuest) {
        //코드로 뷰를 Show하는 부분 입니다.
        let storyboard = UIStoryboard(name: "MissionClear", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "MissionClear") as! MissionClearViewController
        secondVC.missionType = type
        secondVC.delegate = self
        secondVC.questLabelText = setQuestTextReturn(type: type)
        show(secondVC, sender: self)
    }
    
    func setQuestTextReturn(type:MissionQuest) -> String{
        switch type{
        case.daily:
            return dailyQuestStirng
        case.weekly:
            return weeklyQuestStirng
        }
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
            dailyView.questButtonOpen(type: .daily)
        case.weekly:
            weeklyView.questButtonOpen(type: .weekly)
        }
    }
    
    //MARK:  준아가 여기야 여기 <- 확인 🦉
    //뷰디드 로드에 넣음
    //이 함수가 실행되면 dailyBtnValue, weeklyBtnValue에 따라서 해당 버튼이 활성화 비활성화됨
    func isMissonClear(daily:Bool, weekly:Bool){
        if daily {
            questButtonIsUnabled(type: .daily)
        }
        
        if weekly{
            questButtonIsUnabled(type: .weekly)
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

// TODO: 만약 일일 미션은 모두 소진됐는데 주간 미션은 아직 남아 있는 경우 뷰 처리도 필요할 것 같아요
// MARK: 유저디폴트 관련 메소드 모음입니다
extension MissionViewController {
    
    // 앱을 처음으로 켰을 때 유저의 기본 값을 세팅하는 메소드
    private func userInitialSetting() {
        defaults.set(Date.now.addingTimeInterval(3600 * 24), forKey: "refreshDailyMissionDate")
        defaults.set(Date.now.addingTimeInterval(getTimeIntervalForNextMonday(Date.now)), forKey: "refreshWeeklyMissionDate")
        defaults.set(MissionStage.beginner.rawValue, forKey: "userStage")
        defaults.set(MissionDataManager.shared.requestDailyMission(stage: .beginner)!.content, forKey: "currentDailyMission")
        defaults.set(MissionDataManager.shared.requestWeeklyMission(stage: .beginner)!.content, forKey: "currentWeeklyMission")
        defaults.set(0, forKey: "dailyClearMission")
        defaults.set(0, forKey: "weeklyClearMission")
        
        dailyClearQuest = defaults.integer(forKey: "dailyClearMission")
        dailyQuestStirng = defaults.string(forKey: "currentDailyMission")!
        weeklyClearQuest = defaults.integer(forKey: "weeklyClearMission")
        weeklyQuestStirng = defaults.string(forKey: "currentWeeklyMission")!
    }
    
    private func configureMission() {
        
        // 앱 첫 실행 검사
        guard let _ = defaults.object(forKey: "refreshDailyMissionDate") else {
            userInitialSetting()
            return
        }
        
        guard let currentUserStage = MissionStage(rawValue: defaults.string(forKey: "userStage") ?? "") else { return }
        let nextDailyMission = MissionDataManager.shared.requestDailyMission(stage: currentUserStage)
        let nextWeeklyMission = MissionDataManager.shared.requestWeeklyMission(stage: currentUserStage)
        
        // TODO: 모든 미션을 깬 경우 처리를 해야합니다(엔딩뷰)
        if nextDailyMission == nil && nextWeeklyMission == nil {
            return
        }
        
        // 앱에 접속한 날짜와 refresh가 되어야 할 날짜를 비교하기 위해 DateFormatter을 사용했습니다
        let now = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd."
        
        if nextDailyMission != nil {
            // 필요하면 일일 미션 변경
            if dateFormatter.string(from: now) >= dateFormatter.string(from: defaults.object(forKey: "refreshDailyMissionDate") as? Date ?? now) {
                defaults.set(now.addingTimeInterval(3600 * 24), forKey: "refreshDailyMissionDate")
                defaults.set(nextDailyMission!.content, forKey: "currentDailyMission")
                dailyBtnValue = false // 미션 완료 버튼 초기화
            }
        } else { // 모든 일일 미션 클리어
            defaults.set(nil, forKey: "currentDailyMission")
            dailyBtnValue = true
        }
        
        if nextWeeklyMission != nil {
            // 필요하면 주간 미션 변경
            if dateFormatter.string(from: now) >= dateFormatter.string(from: defaults.object(forKey: "refreshWeeklyMissionDate") as? Date ?? now) {
                defaults.set(now.addingTimeInterval(getTimeIntervalForNextMonday(now)), forKey: "refreshWeeklyMissionDate")
                defaults.set(nextWeeklyMission!.content, forKey: "currentWeeklyMission")
                weeklyBtnValue = false // 미션 완료 버튼 초기화
            }
        } else { // 모든 주간 미션 클리어
            defaults.set(nil, forKey: "currentWeeklyMission")
            weeklyBtnValue = true
        }
        
        // MARK: 클리어 한 미션 수와 미션에 실제 데이터(유저디폴트 값)를 넣습니다
        dailyClearQuest = defaults.integer(forKey: "dailyClearMission")
        dailyQuestStirng = defaults.string(forKey: "currentDailyMission") ?? "모든 미션을 클리어 하셨습니다"
        weeklyClearQuest = defaults.integer(forKey: "weeklyClearMission")
        weeklyQuestStirng = defaults.string(forKey: "currentWeeklyMission") ?? "모든 미션을 클리어 하셨습니다"
        
        // userStage 업데이트
        // TODO: Daily와 Weekly의 userStage를 구분할 필요가 있을 것 같아요. 사실 동작이야 제대로 하지만 논리적으로 좀 이상해요(일일 미션은 계속 깨서 userStage가 올라가야 하지만 주간 미션을 하나도 안깼다면?). 하지만 이걸 건들기에는 시간이 부족하니 나중에 리팩토링 할 때 하면 좋을 것 같아요
        if (nextWeeklyMission != nil) && (currentUserStage != nextWeeklyMission!.stage) {
            defaults.set(nextWeeklyMission!.stage.rawValue, forKey: "userStage")
        }
    }
    
    // 특정 요일에서 다음주 월요일까지 필요한 Time Interval 값을 구하는 메소드
    private func getTimeIntervalForNextMonday(_ date: Date) -> Double {
        
        let dayString = getCurrentDayString(date)
        
        switch dayString {
        case "월요일":
            return 3600 * 24 * 7
        case "화요일":
            return 3600 * 24 * 6
        case "수요일":
            return 3600 * 24 * 5
        case "목요일":
            return 3600 * 24 * 4
        case "금요일":
            return 3600 * 24 * 3
        case "토요일":
            return 3600 * 24 * 2
        case "일요일":
            return 3600 * 24 * 1
        default:
            return 0
        }
        
    }
    
    // 특정 날짜의 요일을 구하는 메소드
    private func getCurrentDayString(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier:"ko_KR")
        let dayString = formatter.string(from: date)
        return dayString
        
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
