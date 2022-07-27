//
//  MissionClearViewController.swift
//  TalTal
//
//  Created by Toby on 2022/07/25.
//


import UIKit
import SwiftUI

class MissionClearViewController: UIViewController {
	@IBOutlet var missionTypeLabel: UILabel!
	@IBOutlet var reflectionView: UIView!
	@IBOutlet var reflectionTextView: UITextView!
	@IBOutlet var reflectionTextCountLable: UILabel!
	@IBOutlet var confirmButton: UIButton!
	@IBOutlet var cancelButton: UIButton!
	private var isTextViewSelected: Bool = true

	override func viewDidLoad() {
		super.viewDidLoad()

		reflectionTextView.delegate = self
		view.backgroundColor = UIColor(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
		initMissionTypeLabel()
		initReflection()
	}

	private func initMissionTypeLabel() {
		missionTypeLabel.clipsToBounds = true
		missionTypeLabel.layer.cornerRadius = 13
		view.addSubview(missionTypeLabel)
	}

	private func initReflection() {
		reflectionView.clipsToBounds = true
		reflectionView.backgroundColor = .white
		reflectionView.layer.cornerRadius = 15
		view.addSubview(reflectionView)

		reflectionTextView.clipsToBounds = true
		reflectionTextView.backgroundColor = .clear
		reflectionView.addSubview(reflectionTextView)
		reflectionView.addSubview(reflectionTextCountLable)
	}

	@IBAction func actionBtnCancel(_ sender: Any) {
		//TODO: Close Modal
	}

	@IBAction func actionBtnConfirm(_ sender: Any) {
		//TODO: Save Reflection & Close Modal
	}
}

extension MissionClearViewController: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		// 연속으로 Enter 입력시 방지
		if textView.text.last == "\n" {
			let index = textView.text.index(textView.text.endIndex, offsetBy: -2)
			if textView.text[index] == "\n" {
				let start = textView.text.startIndex
				let end = textView.text.index(textView.text.endIndex, offsetBy: -1)
				let range = start..<end
				textView.text = String(textView.text[range])
			}
		}

// 50 글자 이상 방지
		if textView.text.count > 50 {
			let start = textView.text.startIndex
			let end = textView.text.index(textView.text.startIndex, offsetBy: 50)
			let range = start..<end
			textView.text = String(textView.text[range])
		}
		reflectionTextCountLable.text = "\(textView.text.count) / 50"
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
			textView.textColor = UIColor(red: 199 / 255, green: 199 / 255, blue: 204 / 255, alpha: 1)
		}
	}
}
