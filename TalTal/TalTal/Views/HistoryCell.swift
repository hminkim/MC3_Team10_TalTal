//
//  HistoryCell.swift
//  TalTal
//
//  Created by kimhyeongmin on 2022/07/26.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func changeCellColor(_ missionType: String) {
//        if missionType == "dailyMissionCell" {
//            cellView.backgroundColor = UIColor(named: "PointLightPink")
//        }
//        else if missionType == "weeklyMissionCell" {
//            cellView.backgroundColor = UIColor(named: "PointLightBlue")
//        }
//    }

}
