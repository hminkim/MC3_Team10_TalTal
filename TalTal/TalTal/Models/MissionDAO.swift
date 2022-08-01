//
//  MissionDAO.swift
//  TalTal
//
//  Created by kimhyeongmin on 2022/07/26.
//

import UIKit
import CoreData

//MARK: 코어데이터를 관리하는 데이터 매니저
final class MissionDAO {
	
	// 싱글톤으로 인스턴스 생성
	static let shared = MissionDAO()
	private init() {}
	
	// 앱 델리게이트
	let appDelegate = UIApplication.shared.delegate as? AppDelegate
	
	// context (임시 저장소 같은 느낌??)
	lazy var context = appDelegate?.persistentContainer.viewContext
	
	// 타입 별 미션을 담아둘 배열 선언 !!!!!
	var completeMission:[CompleteMission] = []
	
	//MARK: [Read] 코어데이터에 저장된 Mission 데이터 읽어오는 메서드
	func fetchMissionData() -> [CompleteMission] {
		
		var completeMission: [CompleteMission] = []
		
		if let context = context {
			// 요청서 생성
			let request = NSFetchRequest<NSManagedObject>(entityName: "CompleteMission")
			// clearDate를 기준으로 정렬 순서를 정해서 요청서에 넘김
			let dataOrder = NSSortDescriptor(key: "clearDate", ascending: false)
			request.sortDescriptors = [dataOrder]
			
			do {
				if let fetchedMissionDatas = try context.fetch(request) as? [CompleteMission] {
					completeMission = fetchedMissionDatas
					print(completeMission)
				}
			} catch {
				print(error.localizedDescription)
			}
		}
		return completeMission
	}
	
	//MARK: [Create] 코어데이터에 데이터 생성하는 메서드 (회고 저장)
	func saveReflection(type: MissionQuest, stage: MissionStage, content: String?, reflection: String?, intention: String?) {
		if let context = context {
			// context에 있는 데이터를 그려줄 형태 파악
			if let entity = NSEntityDescription.entity(forEntityName: "CompleteMission", in: context) {
				// context에 올라가게 할 객체만들기 (NSManagedObject -> CompleteMission)
				if let completeMission = NSManagedObject(entity: entity, insertInto: context) as? CompleteMission {
					
					// mission에 실제 데이터를 할당
					completeMission.type = type
					completeMission.stage = stage
					completeMission.content = content
					completeMission.reflection = reflection
					completeMission.clearDate = Date()
					completeMission.intention = intention
				}
				appDelegate?.saveContext()
			}
		}
		completeMission = fetchMissionData()
	}
}
