//
//  HomeResuableView.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 28/08/21.
//

import UIKit

class HomeResuableView: UICollectionReusableView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    static let identifier = "headerlabel"
    
    var title: String? {
        didSet {
            headerLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headerLabel.text = title
    }
    
}
