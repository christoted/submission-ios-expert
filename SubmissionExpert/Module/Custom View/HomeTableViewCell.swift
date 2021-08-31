//
//  HomeTableViewCell.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 19/05/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var containerImageView: UIView!
    @IBOutlet weak var ivHome: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodId: UILabel!
    
    @IBOutlet weak var containerViewParent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivHome.layer.masksToBounds = true
        containerImageView.layer.cornerRadius = 8
        containerViewParent.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
