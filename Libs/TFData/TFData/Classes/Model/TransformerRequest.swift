//
//  TransformerRequest.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import Foundation

public struct TransformerRequest {
    
    let id: String?
    let name: String
    let strength: Int
    let intelligence: Int
    let speed: Int
    let endurance: Int
    let rank: Int
    let courage: Int
    let firepower: Int
    let skill: Int
    let team: String
}

extension TransformerRequest: Encodable {
    
    public init(id: String? = nil,
                name: String,
                strength: Int,
                intelligence: Int,
                speed: Int,
                endurance: Int,
                rank: Int,
                courage: Int,
                firepower: Int,
                skill: Int,
                team: TransformerTeam) {
        self.id = id
        self.name = name
        self.strength = strength
        self.intelligence = intelligence
        self.speed = speed
        self.endurance = endurance
        self.rank = rank
        self.courage = courage
        self.firepower = firepower
        self.skill = skill
        self.team = team.rawValue
    }
}
