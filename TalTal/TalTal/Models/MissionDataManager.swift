//
//  MissionDataManager.swift
//  TalTal
//
//  Created by kimhyeongmin on 2022/07/26.
//

import Foundation

class MissionDataManager {
	
	var dailyMissionDatas: [Mission] = []
	var weeklyMissionDatas: [Mission] = []
	
	// 나중에 CoreData 연결 시 확장성 고려
	func makeMissionData() {
		dailyMissionDatas = [
			Mission(mission: "일어나서 스트레칭 하기", missionClearDate: "2022.07.22"),
			Mission(mission: "공부 열심히 하기", missionClearDate: "2022.07.24"),
			Mission(mission: "데일리최대글자데일리최대글자데일리최대글자데일리최대글자최대글자", missionClearDate: "2022.07.25")
		]
		weeklyMissionDatas = [
			Mission(mission: "코드 리뷰 3번 하기", missionClearDate: "2022.07.28"),
			Mission(mission: "HIG에 맞춘 뷰 고려해보기", missionClearDate: "2022.07.29"),
			Mission(mission: "Weekly Mission 내용 아무거나 몰라 뭐든 들어가겠지", missionClearDate: "2022.07.30"),
			Mission(mission: "Weekly Mission 내용 아무거나 몰라 뭐든 들어가겠지", missionClearDate: "2022.07.30")
		]
	}
	
	func getDailyMissionData() -> [Mission] {
		return dailyMissionDatas
	}
	
	func getWeeklyMissionData() -> [Mission] {
		return weeklyMissionDatas
	}
}
