//
//  MissionDataManager.swift
//  TalTal
//
//  Created by kimhyeongmin on 2022/07/26.
//

import Foundation

class MissionDataManager {
    static var shared = MissionDataManager()
    private var completeMissions: [CompleteMission]
    private var completeDailyMissions: [CompleteMission]
    private var completeWeeklyMissions: [CompleteMission]
    
    private init() {
        //FIXME: 동기화시 문제가 생긴다면 고칠 것
        completeMissions = MissionDAO.shared.fetchMissionData()
        
        // 미션 타입을 통해 미션의 종류를 분류하여 배열에 담음
        completeDailyMissions = completeMissions.filter{ $0.type == .daily }
        completeWeeklyMissions = completeMissions.filter{ $0.type == .weekly }
    }
    
    // 타입에 따른 미션 가져오는 함수
    func getCompleteMission(type: MissionQuest) -> [CompleteMission] {
        var typicalCompletemission: [CompleteMission]
        
        switch type {
        case .daily:
            typicalCompletemission = completeDailyMissions
        case .weekly:
            typicalCompletemission = completeWeeklyMissions
        }
        
        return typicalCompletemission
    }
    
    
    func requestMission(stage: MissionStage, type: MissionQuest) -> Mission? {
        var missions: Set<Mission>
        
        // Stage에 따른 전체 미션 갖고오기 ( missions에 저장)
        switch stage {
        case .beginner:
            missions = type == .daily ? beginnerDailyMissions : beginnerWeeklyMissions
        case .intermediate:
            missions = type == .daily ? intermediateDailyMissions : intermediateWeeklyMissions
        case .advancded:
            missions = type == .daily ? advancedDailyMissions : advancedWeeklyMissions
        }
        
        
        var filterMissons: Set<Mission> = missions
        
        // stage 구분 + daily와 weekly를 구분 -> filterMissions에서 이미 깬 값 제거
        for ele in completeMissions {
            if ele.stage == stage && ele.type == type {
                filterMissons.remove(.init(content: ele.content!, stage: ele.stage, intention: ele.intention!))
            }
        }
        
        // 필터링 된 미션 중에서 랜덤값 추출
        let result = filterMissons.randomElement()
        
        // result가 nil 이면 filterMissions가 비어있다는 뜻 -> 다음 난이도로 변경해야 한다. -> 다음 난이도로 변경하는 재귀함수 호출
        // 재귀함수 탈출 조건 : 난이도가 advanced & result == nil 이면 -> 모든 미션을 꺴다는 뜻
        if result == nil {
            switch stage {
            case .beginner:
                return requestMission(stage: .intermediate, type: type)
            case .intermediate:
                return requestMission(stage: .advancded, type: type)
            case .advancded:
                return nil
            }
        } else {
            return result
        }
    } // requestMission
    
    // MARK: - requestDailyMission
    /// 출력 값
    /// - Mission Type 정상 출력
    /// - nil 모든 임무 완수
    @available(*, deprecated, renamed: "requestMission")
    func requestDailyMission(stage: MissionStage) -> Mission? {
        var missions: Set<Mission>
        
        // Stage에 따른 전체 미션 갖고오기
        switch stage {
        case .beginner:
            missions = beginnerDailyMissions
        case .intermediate:
            missions = intermediateDailyMissions
        case .advancded:
            missions = advancedDailyMissions
        }
        
        var filterMissons: Set<Mission> = missions
        
        // stage 구분 + daily와 weekly를 구분 -> filterMissions에서 이미 깬 값(CoreData에 들어있었던 값) 제거
        for ele in completeDailyMissions {
            if ele.stage == stage && ele.type == .daily {
                // filtermission에서 ele(이미 깬 값) 제거 / 제거할 값이 없어도 알아서 처리 됨
                filterMissons.remove(.init(content: ele.content!, stage: ele.stage, intention: ele.intention!))
            }
        }
        
        // 깨지 않은 Mission들 중에서 랜덤값 추출
        let result = filterMissons.randomElement()
        
        // result가 nil 이면 filterMissions가 비어있다는 뜻 -> 다음 난이도로 변경해야 한다. -> 다음 난이도(stage 파라미터)로 변경하는 재귀함수 호출
        // 재귀함수 탈출 조건 : 난이도가 advanced & result == nil 이면 -> 모든 미션을 꺴다는 뜻
        if result == nil {
            switch stage {
            case .beginner:
                return requestDailyMission(stage: .intermediate)
            case .intermediate:
                return requestDailyMission(stage: .advancded)
            case .advancded:
                return nil
            }
        } else {
            return result
        }
    } // reqeustDailyMission
    
    
    // MARK: - requestWeeklyMission
    /// 출력 값
    /// - Mission Type 정상 출력
    /// - nil 모든 임무 완수
    @available(*, deprecated, renamed: "requestMission")
    func requestWeeklyMission(stage: MissionStage) -> Mission? {
        var missions: Set<Mission>
        
        // Stage에 따른 전체 미션 갖고오기
        switch stage {
        case .beginner:
            missions = beginnerWeeklyMissions
        case .intermediate:
            missions = intermediateWeeklyMissions
        case .advancded:
            missions = advancedWeeklyMissions
        }
        
        var filterMissons: Set<Mission> = missions
        
        // stage 구분 + daily와 weekly를 구분 -> filterMissions에서 이미 깬 값 제거
        for ele in completeWeeklyMissions {
            if ele.stage == stage && ele.type == .weekly {
                // filtermission에서 ele(이미 깬 값) 제거 / 제거할 값이 없어도 알아서 처리 됨
                filterMissons.remove(.init(content: ele.content!, stage: stage, intention: ele.intention!))
            }
        }
        
        // 깨지 않은 Mission들 중에서 랜덤값 추출
        let result = filterMissons.randomElement()
        
        // result가 nil 이면 filterMissions가 비어있다는 뜻 -> 다음 난이도로 변경해야 한다. -> 다음 난이도(stage 파라미터)로 변경하는 재귀함수 호출
        // 재귀함수 탈출 조건 : 난이도가 advanced result값이 nil 이면 -> 모든 미션을 꺴다는 뜻
        if result == nil {
            switch stage {
            case .beginner:
                return requestWeeklyMission(stage: .intermediate)
            case .intermediate:
                return requestWeeklyMission(stage: .advancded)
            case .advancded:
                return nil
            }
        } else {
            return result
        }
    } // reqeustWeeklyMission
    
    
    // MARK: - saveMission
    /// 미션을 CoreData에 저장하는 함수
    func saveMission(mission: Mission, reflection: String?, type: MissionQuest) {
        self.completeMissions = MissionDAO.shared.saveReflection(type: type, stage: mission.stage, content: mission.content, reflection: reflection, intention: mission.intention)
        completeDailyMissions = completeMissions.filter{ $0.type == .daily }
        completeWeeklyMissions = completeMissions.filter{ $0.type == .weekly }
    }
    
} // MissionDataManager


//TODO: fileprivate 대신에 extention + private 조합?
//MARK: DailyMissons
fileprivate let beginnerDailyMissions: Set<Mission> = Set([
    .init(content: "beginnerDailyMissionContent01".localized, stage: .beginner, intention: "beginnerDailyMissionIntention01".localized),
    .init(content: "beginnerDailyMissionContent02".localized, stage: .beginner, intention: "beginnerDailyMissionIntention02".localized),
    .init(content: "beginnerDailyMissionContent03".localized, stage: .beginner, intention: "beginnerDailyMissionIntention03".localized),
    .init(content: "beginnerDailyMissionContent04".localized, stage: .beginner, intention: "beginnerDailyMissionIntention04".localized),
    .init(content: "beginnerDailyMissionContent05".localized, stage: .beginner, intention: "beginnerDailyMissionIntention05".localized),
    .init(content: "beginnerDailyMissionContent06".localized, stage: .beginner, intention: "beginnerDailyMissionIntention06".localized),
    .init(content: "beginnerDailyMissionContent07".localized, stage: .beginner, intention: "beginnerDailyMissionIntention07".localized)
])

fileprivate let intermediateDailyMissions: Set<Mission> = [
    .init(content: "IntermediateDailyMissionContent01".localized, stage: .intermediate, intention: "IntermediateDailyMissionIntention01".localized),
    .init(content: "IntermediateDailyMissionContent02".localized, stage: .intermediate, intention: "IntermediateDailyMissionIntention02".localized),
    .init(content: "IntermediateDailyMissionContent03".localized, stage: .intermediate, intention: "IntermediateDailyMissionIntention03".localized),
    .init(content: "IntermediateDailyMissionContent04".localized, stage: .intermediate, intention: "IntermediateDailyMissionIntention04".localized),
    .init(content: "IntermediateDailyMissionContent05".localized, stage: .intermediate, intention: "IntermediateDailyMissionIntention05".localized),
    .init(content: "IntermediateDailyMissionContent06".localized, stage: .intermediate, intention: "IntermediateDailyMissionIntention06".localized),
    .init(content: "IntermediateDailyMissionContent07".localized, stage: .intermediate, intention: "IntermediateDailyMissionIntention07".localized)
]

fileprivate let advancedDailyMissions: Set<Mission> = [
    .init(content: "AdvancedDailyMissionContent01".localized, stage: .advancded, intention: "AdvancedDailyMissionIntention01".localized),
    .init(content: "AdvancedDailyMissionContent02".localized, stage: .advancded, intention: "AdvancedDailyMissionIntention02".localized),
    .init(content: "AdvancedDailyMissionContent03".localized, stage: .advancded, intention: "AdvancedDailyMissionIntention03".localized),
    .init(content: "AdvancedDailyMissionContent04".localized, stage: .advancded, intention: "AdvancedDailyMissionIntention04".localized),
    .init(content: "AdvancedDailyMissionContent05".localized, stage: .advancded, intention: "AdvancedDailyMissionIntention05".localized),
    .init(content: "AdvancedDailyMissionContent06".localized, stage: .advancded, intention: "AdvancedDailyMissionIntention06".localized)
]


//MARK: WeeklyMission
fileprivate let beginnerWeeklyMissions: Set<Mission> = [
    .init(content: "beginnerWeeklyMissionContent01".localized, stage: .beginner, intention: "beginnerWeeklyMissionIntention01".localized)
]

fileprivate let intermediateWeeklyMissions: Set<Mission> = [
    .init(content: "IntermediateWeeklyMissionContent01".localized, stage: .intermediate, intention: "IntermediateWeeklyMissionIntention01".localized),
    .init(content: "IntermediateWeeklyMissionContent02".localized, stage: .intermediate, intention: "IntermediateWeeklyMissionIntention02".localized)
    
]

fileprivate let advancedWeeklyMissions: Set<Mission> = [
    .init(content: "AdvancedWeeklyMissionContent01".localized, stage: .advancded, intention: "AdvancedWeeklyMissionIntention01".localized),
    .init(content: "AdvancedWeeklyMissionContent02".localized, stage: .advancded, intention: "AdvancedWeeklyMissionIntention02".localized)
]
