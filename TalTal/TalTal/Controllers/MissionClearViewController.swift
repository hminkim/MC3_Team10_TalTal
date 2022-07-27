//
//  MissionClearViewController.swift
//  TalTal
//
//  Created by Toby on 2022/07/25.
//


import UIKit
import SwiftUI

class MissionClearViewController: UIViewController {
	@IBOutlet var lblMissionType: UILabel!
	@IBOutlet var viewReflection: UIView!
	@IBOutlet var textViewReflection: UITextView!
	@IBOutlet var lblReflectionCount: UILabel!
	private var isTextViewSelected: Bool = true
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
		initblblMissionType()
		initReflection()
        // Do any additional setup after loading the view.
    }
	
	
	private func initblblMissionType() {
		lblMissionType.clipsToBounds = true
		lblMissionType.layer.cornerRadius = 13
		view.addSubview(lblMissionType)
	}
	
	private func initReflection() {
		viewReflection.clipsToBounds = true
		viewReflection.backgroundColor = .white
		viewReflection.layer.cornerRadius = 15
		view.addSubview(viewReflection)
		
		textViewReflection.clipsToBounds = true
		textViewReflection.backgroundColor = .clear
		viewReflection.addSubview(textViewReflection)
		
		viewReflection.addSubview(lblReflectionCount)
	}
}

