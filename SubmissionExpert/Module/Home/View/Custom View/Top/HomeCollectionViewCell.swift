//
//  HomeCollectionViewCell.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 25/08/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static var homeindentifier = "homecollectioncell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblFoodHome: UILabel!
    @IBOutlet weak var ivFoodHome: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = .white
    }

}
