//
//  MissionViewController.swift
//  TalTal
//
//  Created by Ruyha on 2022/07/25.
//  Ruyha를 작업자 이름으로 변경후 이 주석은 삭제 바람
//

import UIKit

class MissionViewController: UIViewController {

    @IBOutlet weak var dailyView: MissionQuestView!
    @IBOutlet weak var weeklyView: MissionQuestView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dailyView.configureView(type: .daily, quest: "깔깔깔갈갈갈갈ㅇㅇㅇㅇ갈갉깔깔깔갈ㅇㅇㅇㅇㅇ갈갈갈갈")
        self.weeklyView
            .configureView(type: .weekly, quest: "가나다라마바사아자차카타바파하아카카ㅏ캌")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
