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
	

	// 코어데이터에서 저장된 데이터를 가져오는 모델
	let missionDataManager = MissionDAO.shared
	
	// segmentedControl에 따른 다른 히스토리를 보여주기 위한 변수
	var status: MissionQuest = .daily
	
	override func viewDidLoad() {
		super.viewDidLoad()
		missionTableView.delegate = self
		missionTableView.dataSource = self
	}
	
	// 화면에 진입할 때 마다 테이블뷰를 다시 그림
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		missionTableView.reloadData()
	}
	
	// segmentedControl에 따라서
	// 1) 다른 히스토리를 보여주기
	// 2) segmentedControl의 색 변경해주기
	// 두 가지 일을 수행한 후 테이블뷰를 다시 그리기
	@IBAction func switchMissionType(_ sender: UISegmentedControl) {
		if sender.selectedSegmentIndex == 0 {
			status = .daily // 1)
			segmentedController.selectedSegmentTintColor = UIColor(named: "PointPink") // 2)
			missionTableView.reloadData()
		} else if sender.selectedSegmentIndex == 1 {
			status = .weekly // 1)
			segmentedController.selectedSegmentTintColor = UIColor(named: "PointBlue") // 2)
			missionTableView.reloadData()
		}
	}
}

extension HistoryViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		// 미션에 타입에 따라 미션 데이터의 갯수만큼 셀 생성
		if status == .daily {
			return MissionDataManager.shared.getCompleteMission(type: .daily).count
		} else if status == .weekly {
			return MissionDataManager.shared.getCompleteMission(type: .weekly).count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		// 만들어진 셀을 꺼내서 사용
		let cell = missionTableView.dequeueReusableCell(withIdentifier: "missionCell", for: indexPath) as! HistoryCell
		
		// 각 셀에 라운드 코너 주기
		cell.cellView.layer.cornerRadius = 20
		
		if status == .daily {
			cell.cellView.backgroundColor = UIColor(named: "PointLightPink")
			cell.missionLabel.text = MissionDataManager.shared.getCompleteMission(type: .daily)[indexPath.row].content
			cell.dateLabel.text = MissionDataManager.shared.getCompleteMission(type: .daily)[indexPath.row].clearDate?.timeToString()
		} else if status == .weekly {
			cell.cellView.backgroundColor = UIColor(named: "PointLightBlue")
			cell.missionLabel.text = MissionDataManager.shared.getCompleteMission(type: .weekly)[indexPath.row].content
			cell.dateLabel.text = MissionDataManager.shared.getCompleteMission(type: .weekly)[indexPath.row].clearDate?.timeToString()
		}
		return cell
	}
}

extension HistoryViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "toDetail", sender: indexPath)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toDetail" {
			let reflectionViewController = segue.destination as! ReflectionViewController
      
			// getMissionData에서 미션을 받아옴
            switch status {
            case .daily:
                let missionDatas = missionDataManager.fetchMissionData().filter { $0.type == .daily }
                let indexPath = sender as! IndexPath
                
                reflectionViewController.missionData = missionDatas[indexPath.row]
                print(missionDatas[indexPath.row])
            case .weekly:
                let missionDatas = missionDataManager.fetchMissionData().filter { $0.type == .weekly }
                let indexPath = sender as! IndexPath
                
                reflectionViewController.missionData = missionDatas[indexPath.row]
                print(missionDatas[indexPath.row])
            }
			// Data 넘겨주는 코드
			// ReflectionViewController에
			// var missionData: Mission?
			// 코드 추가 후 사용
		}
	}
}
