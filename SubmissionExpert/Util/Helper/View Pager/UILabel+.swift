//
//  UILabel+.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 23/08/21.
//

import Foundation
import UIKit

public extension UILabel {
    func edgeTo (_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true 
    }
}
