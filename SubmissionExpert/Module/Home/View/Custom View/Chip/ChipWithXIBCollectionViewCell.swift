//
//  ChipWithXIBCollectionViewCell.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 28/08/21.
//

import UIKit

class ChipWithXIBCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewChip: UIView!
    @IBOutlet weak var lblChipTitle: UILabel!
    
    static let identifier = "chipwithxibcell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
