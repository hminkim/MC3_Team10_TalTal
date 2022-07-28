//
//  MissionModel.swift
//  TalTal
//
//  Created by kimhyeongmin on 2022/07/26.
//

enum MissionStage: Int {
	case beginner
	case intermediate
	case advancded
}

struct Mission {
	let content: String
	let stage: MissionStage
	let intention: String
}
