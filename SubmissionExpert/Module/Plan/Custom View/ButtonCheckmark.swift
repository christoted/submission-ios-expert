//
//  ButtonCheckmark.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 17/08/21.
//

import Foundation
import UIKit

class ButtonCheckmark: UIButton {
    
    @IBInspectable var defaultImage: UIImage? {
        didSet {
            setImage(defaultImage, for: .normal)
        }
    }
    
    @IBInspectable var selectedImage: UIImage? {
        didSet {
            setImage(selectedImage, for: .selected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        isSelected = false
        addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc private func tap(){
        isSelected = !isSelected
        print("tapped")
    }
}
