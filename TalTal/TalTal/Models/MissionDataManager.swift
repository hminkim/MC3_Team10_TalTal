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
fileprivate let beginnerDailyMissions: Set<Mission> = Set([
	.init(content: "잠자리 정리하기", stage: .beginner, intention: "매일 아침 “잠자리를 정리했다는 것”은 그날의 첫 번째 과업을 달성했다는 뜻입니다. 이 작은 성취감이 또 다른 일을 해낼 수 있겠다는 용기로 발전할 수 있을 것입니다."),
	.init(content: "일어나서 가벼운 스트레칭 하기", stage: .beginner, intention: "잠을 깨기 위해 단 30초라도 몸을 움직이면 기분에 극적인 영향을 미치고 산란했던 정신도 가라앉게 될 것입니다. 스트래칭을 통해 기분 좋은 하루를 시작해보세요."),
	.init(content: "산책 해보기", stage: .beginner, intention: "산책을 하면서 기분이 좋아지셨나요? 신선한 공기를 마시거나 몸을 움직이면 세로토닌의 효과로 기분이 좋아질 수 있습니다. 생각이 많아지면 가벼운 산책 어떨까요?"),
	.init(content: "좋아하는 음식 먹기", stage: .beginner, intention: "좋아하는 음식을 먹으니 어땠나요? 음식을 먹게 되면 도파민이 방출되기 때문에 기분이 좋아질 수 있습니다. 기분 좋은 하루의 마무리가 되었을까요?"),
	.init(content: "집 청소하기", stage: .beginner, intention: "깔끔해진 집을 보니 어떤가요? 별거 아닌 것 같지만 생각보다 만족스럽지 않나요? 마음 한구석을 찜찜하게 만들었던 지난날들을 한번 정리해 보아요."),
])

fileprivate let intermediateDailyMissions: Set<Mission> = [
	.init(content: "일어나서 명상 해보기", stage: .intermediate, intention: "‘명상’을 하는 이유는 마음 챙김 수련을 하기 위해서입니다. 명상을 하다 보면 현재의 상황을 직시하고 사소한 일에 예민하게 반응하지 않고 침착한 태도를 유지하는 데 도움이 될 것입니다."),
	.init(content: "만족할 만한 수면을 해보기", stage: .intermediate, intention: "수면의 질을 높이는 것은 정말 중요합니다. 자기의 최적의 환경을 만들어야 몸의 생체리듬이 무너지지 않고 피로가 잘 풀리는 적절한 휴식을 할 수 있습니다."),
	.init(content: "잠들기전에 팔굽혀펴기 1회 해보기", stage: .intermediate, intention: "아무리 늦게까지 일을 했더라도 세상이 아무리 어수선하더라도 ‘팔굽혀펴기 1회’를 못할 만큼 힘들기는 불가능할 것입니다. 목표와 계획이 있을 때 가장 중요한 것은 변명의 여지를 없애는 것입니다."),
	.init(content: "거울 속에 나와 눈 마주치고 미소 짓기", stage: .intermediate, intention: "거울 속에 나에게 최대한 밝고 따뜻한 미소를 보내주셨나요? 우리는 웃는 사람을 보면 괜스레 기분이 좋아집니다. 의식적으로 입꼬리를 올리며 자신이 이쁘다는 생각을 계속해 보는 건 어떨까요?"),
	.init(content: "운동 30분 이상 하기", stage: .intermediate, intention: "운동은 세로토닌 분비를 촉진시키는 등 우울증 약만큼의 효과를 보입니다. 처음에는 너무 힘들겠지만 조금씩 성취하면서 자신에게 성공 경험을 부여해 보는 건 어떨까요?"),
]

fileprivate let advancedDailyMissions: Set<Mission> = [
	.init(content: "퇴근하고 SNS 안해보기", stage: .advancded, intention: "SNS는 다른 사람에게 무언가를 보여주기 위해서 존재합니다. 그 과정에서 남과 나를 비교한다면 우울감에 빠질 수 있습니다. 그런 감정이 들면 SNS를 멀리해보세요."),
	.init(content: "나의 장점 3가지 이상 생각해보기", stage: .advancded, intention: "나의 장점을 찾는 일이 어려웠나요? 우리 모두 강점의 씨앗을 가지고 있습니다. 그 강점은 잘하는 것이 아니라 자신에게 힘을 주는 것, 에너지를 얻는 것, 오래 할 수 있는 것 등이 될 것입니다."),
	.init(content: "가장 중요한 일을 2시간 집중해서 하기", stage: .advancded, intention: "이 과정은 한 번에 2시간을 집중하는 것을 말합니다. 2시간 정도를 한 가지에 집중을 하면 반드시 그날 한 가지의 성과는 남길 수 있을 것입니다."),
]


fileprivate let beginnerWeeklyMissions: Set<Mission> = [
	.init(content: "디자이너에게 일주일 동안 3번 웃으면서 인사해보기", stage: .beginner, intention: "자신의 역량을 강화시키기 위한 첫 시작은 “인사”입니다. 인사를 통해 상대방에게 ‘좋은 첫인상’을 주는 것이 좋습니다. 이를 통해 다양한 인간관계를 맺게 될 것입니다. 그 시작은 항상 인사입니다."),
]

fileprivate let intermediateWeeklyMissions: Set<Mission> = [
	.init(content: "코드 리뷰를 3번 이상 주고 받아 봅시다.", stage: .intermediate, intention: "코드 리뷰를 하다 보면 자신이 알고 있는 개념과 모르는 개념을 정확하게 알 수 있을 것입니다. 혹시 부족한 부분이 있었나요? 그럼 그 부분을 공부하면서 더욱 발전해 보면 어떨까요?"),
]

fileprivate let advancedWeeklyMissions: Set<Mission> = [
	.init(content: "내가 과거에 만든 코드를 리팩토링 해보기", stage: .advancded, intention: "과거 내가 만든 코드를 보면서 리팩토링이 필요한 부분이 보였나요? 여러분은 조금씩이라도 꾸준히 성장하고 있다는 뜻입니다. 지금처럼 계속 발전한다면 당신은 충분히 실력 있는 코더가 될 것입니다.")
]
