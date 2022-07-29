//
//  CompleteMission+CoreDataProperties.swift
//  TalTal
//
//  Created by kimhyeongmin on 2022/07/28.
//
//

import Foundation
import CoreData

public enum Status: String {
	case daily
	case weekly
}

extension CompleteMission {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<CompleteMission> {
		return NSFetchRequest<CompleteMission>(entityName: "CompleteMission")
	}
	
	@NSManaged public var content: String?
	@NSManaged public var reflection: String?
	@NSManaged public var intention: String?
	@NSManaged public var clearDate: Date?
	@NSManaged public var typeValue: String
	@NSManaged public var stageValue: String
	
	// Enum을 지원하지 않는 CoreData에 Enum rawValue를 통해 필터링 하기 위한 코드
	public var stage: MissionStage {
		get {
			return MissionStage(rawValue: self.stageValue)! }
		set {
			self.stageValue = newValue.rawValue
		}
	}
	
	public var type: Status {
		get {
			return Status(rawValue: self.typeValue)! }
		set {
			self.typeValue = newValue.rawValue
		}
	}
}

extension CompleteMission : Identifiable { }

//MARK: Date -> String 타입 변환 메서드
extension Date {
	func timeToString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd."
		dateFormatter.locale = Locale(identifier:"ko_KR")
		
		return dateFormatter.string(from: self)
	}
}

//MARK: String -> Date 타입 변환 메서드
extension String {
	func stringToDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		dateFormatter.locale = Locale(identifier:"ko_KR")
		
		if let date = dateFormatter.date(from: self) {
			return date
		} else {
			return nil
		}
	}
}
