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
    var imageView: UIImageView?
    
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
    
        
        switch page {
        case Pages.pageZero:
            setupImage(imageName: "food1")
            setupTitle(title: "Have you feel tired to manage your diet?")
        case Pages.pageOne:
            setupTitle(title: "Don’t worry, that’s why Here we are")
        case Pages.pageTwo:
            setupTitle(title: "Are you ready to Start your diet with us?")
        case Pages.pageThree:
           // setupTitle(title: "Have you feel tired to manage your diet?")
        setupButton(buttonText: "Let's Start!")
        default:
            setupTitle(title: "Have you feel tired to manage your diet?")
        }
        
       
        
    }
    
    @objc private func onTap(sender: UIButton!) {
        delegate?.moveToVC()
    }

    private func setupTitle(title: String) {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 200, width: view.frame.size.width, height: 30))
     //   titleLabel?.center = CGPoint(x: 160, y: 250)
        titleLabel?.text = title
        titleLabel?.textAlignment = .center
        
     
        
        
        self.view.addSubview(titleLabel!)
    }
    
    private func setupImage(imageName: String){
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image)
        imageView!.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: image!.size.height)
        view.addSubview(imageView!)
    }
    
    private func setupButton(buttonText: String) {
        let button = UIButton(frame: CGRect(x: 0, y: 400, width: view.frame.size.width / 4 , height: 20))
        
        button.addTarget(self, action: #selector(onTap(sender:)), for: .touchUpInside)
        button.setTitle(buttonText, for: .normal)
        
        self.view.addSubview(button)
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
           NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
    }
   
    

}
