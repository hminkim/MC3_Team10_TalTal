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
        // 테이블뷰 셀이 클릭 되었을때 백그라운드 컬러 제거
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        selectedBackgroundView = backgroundView
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}
