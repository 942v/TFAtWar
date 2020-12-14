//
//  FormData.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit
import TFData

typealias OnFormItemCompletion = (String?) -> Void

struct AddFormItemProperties {
    var keyboardType = UIKeyboardType.numberPad
    var cellType: AddRootTableViewCellType?
}

protocol AddFormItemValidator {
    var isValid: Bool { get set }
    
    func checkIfValid()
}

class AddFormData {
    var formItems = [AddFormItem]()
    
    var id: String?
    var name: String?
    var strength: String?
    var intelligence: String?
    var speed: String?
    var endurance: String?
    var rank: String?
    var courage: String?
    var firepower: String?
    var skill: String?
    var team: String?
    
    var request: TransformerRequest {
        guard let name = self.name,
              let strength = self.strength,
              let intelligence = self.intelligence,
              let speed = self.speed,
              let endurance = self.endurance,
              let rank = self.rank,
              let courage = self.courage,
              let firepower = self.firepower,
              let skill = self.skill,
              let team = self.team else {
            fatalError("Asking for request when data is not complete, check validator")
        }
        
        let strengthValue = Int(strength) ?? 0
        let intelligenceValue = Int(intelligence) ?? 0
        let speedValue = Int(speed) ?? 0
        let enduranceValue = Int(endurance) ?? 0
        let rankValue = Int(rank) ?? 0
        let courageValue = Int(courage) ?? 0
        let firepowerValue = Int(firepower) ?? 0
        let skillValue = Int(skill) ?? 0
        let teamValue = TransformerTeam.type(from: team)
        
        return TransformerRequest(id: id,
                                  name: name,
                                  strength: strengthValue,
                                  intelligence: intelligenceValue,
                                  speed: speedValue,
                                  endurance: enduranceValue,
                                  rank: rankValue,
                                  courage: courageValue,
                                  firepower: firepowerValue,
                                  skill: skillValue,
                                  team: teamValue)
    }
    
    init(from transformerData: TransformerData?) {
        self.setupInitialData(transformerData)
        self.configureItems()
    }
    
    // MARK: Form Validation
    @discardableResult
    func isValid() -> Bool {
        
        var isValid = true
        for item in formItems {
            item.checkIfValid()
            if !item.isValid {
                isValid = false
            }
        }
        return isValid
    }
    
    /// Prepare all form Items ViewModels for the DirectStudioForm
    private func configureItems() {
        
        func makeAddFormItem(title: String,
                             placeholder: String,
                             cellType: AddRootTableViewCellType,
                             value: String?) -> AddFormItem {
            let item = AddFormItem(title: title,
                                   placeholder: placeholder)
            item.properties.cellType = cellType
            item.value = value
            return item
        }
        
        // Team
        let teamItem = makeAddFormItem(title: "Team",
                                       placeholder: "Type A or D",
                                       cellType: AddRootTableViewCellType.textField,
                                       value: team)
        teamItem.properties.keyboardType = .default
        teamItem.onCompletion = { [weak self, weak teamItem] value in
            self?.team = value
            teamItem?.value = value
        }
        
        // Name
        let nameItem = makeAddFormItem(title: "Name",
                                       placeholder: "Enter name",
                                       cellType: AddRootTableViewCellType.textField,
                                       value: name)
        nameItem.properties.keyboardType = .default
        nameItem.onCompletion = { [weak self, weak nameItem] value in
            self?.name = value
            nameItem?.value = value
        }
        
        // Strength
        let strengthItem = makeAddFormItem(title: "Strenght",
                                           placeholder: "1 to 10",
                                           cellType: AddRootTableViewCellType.textField,
                                           value: strength)
        strengthItem.onCompletion = { [weak self, weak strengthItem] value in
            self?.strength = value
            strengthItem?.value = value
        }
        
        // Intelligence
        let intelligenceItem = makeAddFormItem(title: "Intelligence",
                                               placeholder: "1 to 10",
                                               cellType: AddRootTableViewCellType.textField,
                                               value: intelligence)
        intelligenceItem.onCompletion = { [weak self, weak intelligenceItem] value in
            self?.intelligence = value
            intelligenceItem?.value = value
        }
        
        // Speed
        let speedItem = makeAddFormItem(title: "Speed",
                                        placeholder: "1 to 10",
                                        cellType: AddRootTableViewCellType.textField,
                                        value: speed)
        speedItem.onCompletion = { [weak self, weak speedItem] value in
            self?.speed = value
            speedItem?.value = value
        }
        
        // Endurance
        let enduranceItem = makeAddFormItem(title: "Endurance",
                                            placeholder: "1 to 10",
                                            cellType: AddRootTableViewCellType.textField,
                                            value: endurance)
        enduranceItem.onCompletion = { [weak self, weak enduranceItem] value in
            self?.endurance = value
            enduranceItem?.value = value
        }
        
        // Rank
        let rankItem = makeAddFormItem(title: "Rank",
                                       placeholder: "1 to 10",
                                       cellType: AddRootTableViewCellType.textField,
                                       value: rank)
        rankItem.onCompletion = { [weak self, weak rankItem] value in
            self?.rank = value
            rankItem?.value = value
        }
        
        // Courage
        let courageItem = makeAddFormItem(title: "Courage",
                                          placeholder: "1 to 10",
                                          cellType: AddRootTableViewCellType.textField,
                                          value: courage)
        courageItem.onCompletion = { [weak self, weak courageItem] value in
            self?.courage = value
            courageItem?.value = value
        }
        
        // Firepower
        let firepowerItem = makeAddFormItem(title: "Firepower",
                                            placeholder: "1 to 10",
                                            cellType: AddRootTableViewCellType.textField,
                                            value: firepower)
        firepowerItem.onCompletion = { [weak self, weak firepowerItem] value in
            self?.firepower = value
            firepowerItem?.value = value
        }
        
        // Skill
        let skillItem = makeAddFormItem(title: "Skill",
                                        placeholder: "1 to 10",
                                        cellType: AddRootTableViewCellType.textField,
                                        value: skill)
        skillItem.onCompletion = { [weak self, weak skillItem] value in
            self?.skill = value
            skillItem?.value = value
        }
        
        self.formItems = [teamItem,
                          nameItem,
                          strengthItem,
                          intelligenceItem,
                          speedItem,
                          enduranceItem,
                          rankItem,
                          courageItem,
                          firepowerItem,
                          skillItem]
    }
    
    func setupInitialData(_ transformerData: TransformerData?) {
        guard let transformerData = transformerData else {
            return
        }
        
        self.id = transformerData.id
        self.name = transformerData.name
        self.strength = String(transformerData.strength)
        self.intelligence = String(transformerData.intelligence)
        self.speed = String(transformerData.speed)
        self.endurance = String(transformerData.endurance)
        self.rank = String(transformerData.rank)
        self.courage = String(transformerData.courage)
        self.firepower = String(transformerData.firepower)
        self.skill = String(transformerData.skill)
        self.team = transformerData.team.rawValue
    }
}
