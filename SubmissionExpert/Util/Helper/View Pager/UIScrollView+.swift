//
//  UIScrollView+.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 23/08/21.
//

import Foundation
import UIKit

public extension UIScrollView {
    func edgeTo(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true ) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.height * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
}
