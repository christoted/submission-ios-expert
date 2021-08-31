//
//  SearchViewCell.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 11/07/21.
//

import UIKit

class SearchViewCell: UICollectionViewCell {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var baseContainerView: UIView!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageSearch: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupStyle()
        
    }
    
    
    private func setupStyle(){
        baseContainerView.layer.cornerRadius = 8
        imageSearch.layer.masksToBounds = true
        imageContainerView.layer.cornerRadius = 8
        imageSearch.layer.cornerRadius = 8
        orangeView.layer.cornerRadius = 8
        
    }

}
