//
//  WarEngineTests.swift
//  TFWarEngine_Tests
//
//  Created by Guillermo Sáenz on 12/14/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest

class WarEngineTests: XCTestCase {
    
    var sut: WarEngine!
    
    var autobots = [TransformerData]()
    var decepticons = [TransformerData]()
    
    override func setUp() {
        super.setUp()
        
        autobots = createAutobots()
        decepticons = createDecepticons()
        
        sut = WarEngine(transformers: autobots + decepticons)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

extension WarEngineTests {
    
    func testWarEngine_whenInit_allDecepticons() {
        
        let decepticons = sut.decepticons
        
        decepticons.forEach {
            XCTAssertTrue($0.team == .decepticon)
        }
    }
    
    func testWarEngine_whenInit_allAutobots() {
        
        let autobots = sut.autobots
        
        autobots.forEach {
            XCTAssertTrue($0.team == .autobot)
        }
    }
    
    func testWarEngine_whenFight_winAutobot() {
        
        let result = sut.startBattle()!
        
        XCTAssertTrue(result.winnerTeam == .autobot)
        XCTAssertFalse(result.winnerTeam == .decepticon)
    }
    
    func testWarEngine_whenFight_winDecepticons() {
        
        let autobots = sut.autobots
        var decepticons = sut.decepticons
        
        decepticons.append(createSpecialPlayerPredaking(team: .decepticon))
        
        sut = WarEngine(transformers: autobots+decepticons)
        
        let result = sut.startBattle()!
        
        XCTAssertTrue(result.winnerTeam == .decepticon)
        XCTAssertFalse(result.winnerTeam == .autobot)
    }
    
    func testWarEngine_whenFight_allDead() {
        
        autobots.append(createSpecialPlayerOptimus(team: .autobot))
        decepticons.append(createSpecialPlayerPredaking(team: .decepticon))
        
        sut = WarEngine(transformers: autobots+decepticons)
        
        let result = sut.startBattle()
        
        XCTAssertNil(result)
    }
}

extension WarEngineTests {
    func createAutobots() -> [TransformerData] {
        let a = TransformerData(id: UUID().uuidString,
                                name: "Bluestreak",
                                strength: 6,
                                intelligence: 6,
                                speed: 7,
                                endurance: 9,
                                rank: 5,
                                courage: 2,
                                firepower: 9,
                                skill: 7,
                                team: .autobot,
                                teamIcon: URL(string: "google.com")!)
        
        let b = TransformerData(id: UUID().uuidString,
                                name: "EJECT",
                                strength: 6,
                                intelligence: 6,
                                speed: 2,
                                endurance: 6,
                                rank: 6,
                                courage: 8,
                                firepower: 5,
                                skill: 8,
                                team: .autobot,
                                teamIcon: URL(string: "google.com")!)
        
        let c = TransformerData(id: UUID().uuidString,
                                name: "JAZZ",
                                strength: 5,
                                intelligence: 9,
                                speed: 7,
                                endurance: 7,
                                rank: 8,
                                courage: 9,
                                firepower: 5,
                                skill: 10,
                                team: .autobot,
                                teamIcon: URL(string: "google.com")!)
        
        return [a, b, c]
    }
    
    func createDecepticons() -> [TransformerData] {
        let a = TransformerData(id: UUID().uuidString,
                                name: "Soundwave",
                                strength: 8,
                                intelligence: 9,
                                speed: 2,
                                endurance: 6,
                                rank: 7,
                                courage: 5,
                                firepower: 6,
                                skill: 10,
                                team: .decepticon,
                                teamIcon: URL(string: "google.com")!)
        
        let b = TransformerData(id: UUID().uuidString,
                                name: "BLOT",
                                strength: 9,
                                intelligence: 2,
                                speed: 2,
                                endurance: 10,
                                rank: 4,
                                courage: 10,
                                firepower: 6,
                                skill: 5,
                                team: .decepticon,
                                teamIcon: URL(string: "google.com")!)
        
        let c = TransformerData(id: UUID().uuidString,
                                name: "DIRGE",
                                strength: 7,
                                intelligence: 8,
                                speed: 8,
                                endurance: 6,
                                rank: 5,
                                courage: 4,
                                firepower: 8,
                                skill: 9,
                                team: .decepticon,
                                teamIcon: URL(string: "google.com")!)
        
        return [a, b, c]
    }
    
    func createSpecialPlayerOptimus(team: TransformerTeam) -> TransformerData {
        
        return TransformerData(id: UUID().uuidString,
                               name: "Optimus Prime",
                               strength: 1,
                               intelligence: 1,
                               speed: 1,
                               endurance: 1,
                               rank: 10,
                               courage: 1,
                               firepower: 1,
                               skill: 1,
                               team: team,
                               teamIcon: URL(string: "google.com")!)
    }
    
    func createSpecialPlayerPredaking(team: TransformerTeam) -> TransformerData {
        
        return TransformerData(id: UUID().uuidString,
                               name: "Predaking",
                               strength: 1,
                               intelligence: 1,
                               speed: 1,
                               endurance: 1,
                               rank: 10,
                               courage: 1,
                               firepower: 1,
                               skill: 1,
                               team: team,
                               teamIcon: URL(string: "google.com")!)
    }
}
