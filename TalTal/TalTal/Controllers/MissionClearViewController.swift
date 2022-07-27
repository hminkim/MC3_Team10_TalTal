//
//  MissionClearViewController.swift
//  TalTal
//
//  Created by Toby on 2022/07/25.
//


import UIKit
import SwiftUI

class MissionClearViewController: UIViewController, UITextViewDelegate {
	@IBOutlet var lblMissionType: UILabel!
	@IBOutlet var viewReflection: UIView!
	@IBOutlet var textViewReflection: UITextView!
	@IBOutlet var lblReflectionCount: UILabel!
	@IBOutlet var btnConfirm: UIButton!
	@IBOutlet var btnCancel: UIButton!
	private var isTextViewSelected: Bool = true
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		textViewReflection.delegate = self
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
	
	func textViewDidChange(_ textView: UITextView) {
		if textView.text.count > 50 {
			let start = textView.text.startIndex
			let end = textView.text.index(textView.text.startIndex, offsetBy: 50)
			let range = start..<end
			textView.text = String(textView.text[range])
		}
		
		lblReflectionCount.text = "\(textView.text.count) / 50"
	}
	
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		if isTextViewSelected {
			textView.text = ""
			textView.textColor = .black
			isTextViewSelected = false
		}
		return true
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.count == 0 {
			isTextViewSelected = true
			textView.text = "50자 이내로 적어주세요."
			textView.textColor = UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1)
		}
	}
	
	@IBAction func actionBtnCancel(_ sender: Any) {
		//TODO: Close Modal
	}
	
	
	@IBAction func actionBtnConfirm(_ sender: Any) {
		//TODO: Save Reflection & Close Modal
	}
	
	
}

