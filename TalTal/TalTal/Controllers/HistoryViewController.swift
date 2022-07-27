//
//  HistoryViewController.swift
//  TalTal
//
//  Created by Kkoma on 2022/07/25.
//

import UIKit

class HistoryViewController: UIViewController {
	
	@IBOutlet var historyMainLabel: UILabel!
	@IBOutlet var missioSegmentedControl: UISegmentedControl!
	@IBOutlet weak var missionTableView: UITableView!
	@IBOutlet weak var segmentedController: UISegmentedControl!
	
	var missionDataManager = MissionDataManager()
	
	// segmentedControl에 따른 다른 히스토리를 보여주기 위한 변수
	var status: String = "dailyMissionCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		missionTableView.dataSource = self
		missionTableView.delegate = self
		
		// DataManger 클래스의 makeMissionData 메서드를 통해 미션 데이터 생성
		missionDataManager.makeMissionData()
	}
	
	// segmentedControl에 따라서
	// 1) 다른 히스토리를 보여주기
	// 2) segmentedControl의 색 변경해주기
	@IBAction func switchMissionType(_ sender: UISegmentedControl) {
		print(#function)
		if sender.selectedSegmentIndex == 0 {
			status = "dailyMissionCell"
			segmentedController.selectedSegmentTintColor = UIColor(named: "PointPink")
			missionTableView.reloadData()
		}
		else if sender.selectedSegmentIndex == 1 {
			status = "weeklyMissionCell"
			segmentedController.selectedSegmentTintColor = UIColor(named: "PointBlue")
			missionTableView.reloadData()
		}
	}
}

extension HistoryViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(#function)
		
		// 미션 데이터의 갯수만큼 셀 생성
		if status == "dailyMissionCell" {
			return missionDataManager.getDailyMissionData().count
		}
		
		else if status == "weeklyMissionCell" {
			return missionDataManager.getWeeklyMissionData().count
		}
		
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		print(#function)
		
		// 만들어진 셀을 꺼내서 사용
		let cell = missionTableView.dequeueReusableCell(withIdentifier: "missionCell", for: indexPath) as! HistoryCell
		
		// 라운드 코너 주기
		cell.cellView.layer.cornerRadius = 20
		
		if status == "dailyMissionCell" {
			cell.cellView.backgroundColor = UIColor(named: "PointLightPink")
			cell.missionLabel.text = missionDataManager.getDailyMissionData()[indexPath.row].mission
			cell.dateLabel.text = missionDataManager.getDailyMissionData()[indexPath.row].missionClearDate
		}
		
		else if status == "weeklyMissionCell" {
			cell.cellView.backgroundColor = UIColor(named: "PointLightBlue")
			cell.missionLabel.text = missionDataManager.getWeeklyMissionData()[indexPath.row].mission
			cell.dateLabel.text = missionDataManager.getWeeklyMissionData()[indexPath.row].missionClearDate
		}
		
		return cell
	}
}

extension HistoryViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "toDetail", sender: indexPath)
		//TODO: ReflectionView에서 toDetail을 identifier로 설정 -> Joon
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toDetail" {
			let reflectionViewController = segue.destination as! ReflectionViewController
			
			// getDailyMissionData에서 일일 미션을 받아옴
			//TODO: WeeklyMissionData도 받아올 수 있는 미션 추가 -> Kkoma
			let dailyMissionDatas = missionDataManager.getDailyMissionData()
			
			// tableView 함수에서 sender를 통해 indexPath를 받은 후 타입 캐스팅하여 데이터를 사용할 수 있음
			let indexPath = sender as! IndexPath
			
			// reflectionViewController.missionData = dailyMissionDatas[indexPath.row]
			// Data 넘겨주는 코드
			// ReflectionViewController에
			// var missionData: Mission?
			// 코드 추가 후 사용
		}
	}
}
