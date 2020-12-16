//
//  ListTableViewswift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit

class ListRootTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var courageLabel: UILabel!
    @IBOutlet weak var firepowerLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var overallRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(_ transformer: TransformerData) {
        var transformer = transformer
        iconImageView.kf.setImage(with: transformer.teamIcon)
        nameLabel.text = transformer.name
        strengthLabel.text = String(transformer.strength)
        intelligenceLabel.text = String(transformer.intelligence)
        speedLabel.text = String(transformer.speed)
        enduranceLabel.text = String(transformer.endurance)
        rankLabel.text = String(transformer.rank)
        courageLabel.text = String(transformer.courage)
        firepowerLabel.text = String(transformer.firepower)
        skillLabel.text = String(transformer.skill)
        overallRatingLabel.text = String(transformer.overallRating)
    }

}
