//
//  ChipWithXIBCollectionViewCell.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 28/08/21.
//

import UIKit

protocol ChipProtocol {
    func onChipPressed(title: String)
}

class ChipWithXIBCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewChip: UIView!
    @IBOutlet weak var lblChipTitle: UILabel!
    
    var delegate : ChipProtocol?
    
    static let identifier = "chipwithxibcell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let onTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        viewChip.addGestureRecognizer(onTap)
    }
    
    @objc private func tap(){
        delegate?.onChipPressed(title: lblChipTitle.text!)
    }
    
    

}
