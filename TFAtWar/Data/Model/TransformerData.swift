//
//  TransformerData.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import Foundation

public enum TransformerTeam: String {
    case unknown
    case decepticon = "D"
    case autobot = "A"
    
    public static func type(from string: String) -> TransformerTeam {
        if string == "A" {
            return .autobot
        }else if string == "D" {
            return .decepticon
        }else {
            return .unknown
        }
    }
}

public struct TransformerData {
    
    public let id: String
    public let name: String
    public let strength: Int
    public let intelligence: Int
    public let speed: Int
    public let endurance: Int
    public let rank: Int
    public let courage: Int
    public let firepower: Int
    public let skill: Int
    public let team: TransformerTeam
    public let teamIcon: URL
    public lazy var overallRating: Int = {
        strength + intelligence + speed + endurance + firepower
    }()
    
    private enum CodingKeys: String, CodingKey {
        case id, name, strength, intelligence, speed, endurance, rank, courage, firepower, skill, team
        case teamIcon = "team_icon"
    }
    
    private enum AdditionalInfoKeys: String, CodingKey {
        case team, teamIcon
    }
    
    public init(id: String,
         name: String,
         strength: Int,
         intelligence: Int,
         speed: Int,
         endurance: Int,
         rank: Int,
         courage: Int,
         firepower: Int,
         skill: Int,
         team: TransformerTeam,
         teamIcon: URL) {
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
        self.team = team
        self.teamIcon = teamIcon
    }
}

extension TransformerData: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        strength = try values.decode(Int.self, forKey: .strength)
        intelligence = try values.decode(Int.self, forKey: .intelligence)
        speed = try values.decode(Int.self, forKey: .speed)
        endurance = try values.decode(Int.self, forKey: .endurance)
        rank = try values.decode(Int.self, forKey: .rank)
        courage = try values.decode(Int.self, forKey: .courage)
        firepower = try values.decode(Int.self, forKey: .firepower)
        skill = try values.decode(Int.self, forKey: .skill)
        
        let rawTeam = try values.decode(String.self, forKey: .team)
        if let team = TransformerTeam(rawValue: rawTeam) {
            self.team = team
        }else{
            // TODO: in dev builds this should throw
            self.team = .unknown
        }
        
        let rawTeamIcon = try values.decode(String.self, forKey: .teamIcon)
        if let teamIcon = URL(string: rawTeamIcon) {
            self.teamIcon = teamIcon
        }else{
            // TODO: in dev builds this should throw
            // TODO: for prod we should use a placeholder URL that redirects to a real image
            self.teamIcon = URL(string: "https://google.com")!
        }
    }
}

extension TransformerData: Equatable {
    public static func ==(lhs: TransformerData, rhs: TransformerData) -> Bool {
      return lhs.id == rhs.id
    }
}

