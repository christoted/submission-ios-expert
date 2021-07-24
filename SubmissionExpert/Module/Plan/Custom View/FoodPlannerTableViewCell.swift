//
//  FoodPlannerTableViewCell.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import UIKit

class FoodPlannerTableViewCell: UITableViewCell {

    @IBOutlet weak var foodCalLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
