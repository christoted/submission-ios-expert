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
    var buttonNext: UIButton?
    
    var page: Pages
    
    var delegate: MoveDelegate?
    
    init(with page: Pages) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    //You can use layout anchors, you can use the NSLayoutConstraint class, or you can use the Visual Format Language.
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch page {
        case Pages.pageZero:
            setupImage(imageName: "food1")
            setupTitle(title: "Have you feel tired to manage your diet?")
            setupConstraintLayout()
        case Pages.pageOne:
            setupImage(imageName: "food2")
            setupTitle(title: "Don’t worry, that’s why Here we are")
            setupConstraintLayout()
        case Pages.pageTwo:
            setupImage(imageName: "food3")
            setupTitle(title: "Are you ready to Start your diet with us?")
            setupConstraintLayout()
        case Pages.pageThree:
            setupImage(imageName: "food4")
            // setupTitle(title: "Have you feel tired to manage your diet?")
            setupButton(buttonText: "Let's Start!")
            setupConstraintLayout()
        default:
            setupTitle(title: "Have you feel tired to manage your diet?")
        }
        
    }
    
    @objc private func onTap(sender: UIButton!) {
        delegate?.moveToVC()
    }
    
    private func setupTitle(title: String) {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        titleLabel?.text = title
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel?.numberOfLines = 2
        titleLabel?.textAlignment = .center
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel!)
        
        
        // view.addConstraints([top, bottom, leading, trailing])
    }
    
    private func setupImage(imageName: String){
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView!)
    }
    
    private func setupConstraintLayout(){
        //Image
        imageView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageView?.heightAnchor.constraint(equalToConstant: (imageView?.frame.height)!).isActive = true
        imageView?.widthAnchor.constraint(equalToConstant: (imageView?.frame.width)!).isActive = true
        //Text Below
        titleLabel?.topAnchor.constraint(equalTo:imageView!.bottomAnchor, constant: 5).isActive = true
        titleLabel?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titleLabel?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        titleLabel?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
       
    }
    
    private func setupButton(buttonText: String) {
        buttonNext = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        
        buttonNext!.addTarget(self, action: #selector(onTap(sender:)), for: .touchUpInside)
        buttonNext!.setTitle(buttonText, for: .normal)
        buttonNext?.translatesAutoresizingMaskIntoConstraints = false
        buttonNext!.backgroundColor = .orange
        buttonNext!.layer.cornerRadius = 12
     
        
        self.view.addSubview(buttonNext!)
        //Button
//        buttonNext?.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: 100).isActive = true
//        buttonNext?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        buttonNext?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        buttonNext?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//   //     buttonNext?.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//        buttonNext?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let widthContraints =  NSLayoutConstraint(item: buttonNext, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 350)
        let heightContraints = NSLayoutConstraint(item: buttonNext, attribute: NSLayoutConstraint.Attribute.height, relatedBy:  NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let xContraints = NSLayoutConstraint(item: buttonNext, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let yContraints = NSLayoutConstraint(item: buttonNext, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 400)
        NSLayoutConstraint.activate([heightContraints,widthContraints,xContraints,yContraints])
        //        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        //        let centerYConstraint = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        //           NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
    }
    
    
    
}
