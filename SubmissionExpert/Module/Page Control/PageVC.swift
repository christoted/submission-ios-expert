//
//  PageVC.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/08/21.
//

import UIKit

protocol MoveDelegate {
    func moveToVC()
}

class PageVC: UIViewController {
    
    var titleLabel: UILabel?
    
    var page: Pages
    
    var delegate: MoveDelegate?
    
    init(with page: Pages) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        titleLabel?.center = CGPoint(x: 160, y: 250)
        titleLabel?.text = page.name
        self.view.addSubview(titleLabel!)
        
        if page == Pages.pageThree {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
            button.setTitle("Tap Here", for: .normal)
            button.addTarget(self, action: #selector(onTap(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
        
    }
    
    @objc private func onTap(sender: UIButton!) {
        delegate?.moveToVC()
    }

   

}
