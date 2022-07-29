//
//  MissionModel.swift
//  TalTal
//
//  Created by kimhyeongmin on 2022/07/26.
//

enum MissionStage: String {
	case beginner
	case intermediate
	case advancded
}

struct Mission: Hashable {
	let content: String
	let stage: MissionStage
	let intention: String
}
