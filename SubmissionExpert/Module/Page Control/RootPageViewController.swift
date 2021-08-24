//
//  RootPageViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/08/21.
//

import UIKit

enum Pages: CaseIterable {
    case pageZero
    case pageOne
    case pageTwo
    case pageThree
    
    var name: String {
        switch self {
        case .pageZero:
            return "This is page zero"
        case .pageOne:
            return "This is page one"
        case .pageTwo:
            return "This is page two"
        case .pageThree:
            return "This is page three"
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
        case .pageTwo:
            return 2
        case .pageThree:
            return 3
        }
    }
}

class RootPageViewController: UIViewController {
    
    private var pageController: UIPageViewController?
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0
    
    let preference = UserDefaults.standard
    var isFirstTime: Bool = false
    let IS_FIRST_TIME_KEY = "IS_FIRST_TIME_KEY"
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .lightGray
        
        setupPageControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func setupPageControl() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let initialVC = PageVC(with: pages[0])
        initialVC.delegate = self
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
    

}

extension RootPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PageVC else {
            return nil
        }
        
        var index = currentVC.page.index
        
        print("Index \(index)")
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc: PageVC = PageVC(with: pages[index])
        vc.delegate = self
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PageVC else {
            return nil
        }
        
        var index = currentVC.page.index
        
        print("Index \(index)")
        
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
        let vc: PageVC = PageVC(with: pages[index])
        vc.delegate = self
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
    
}

extension RootPageViewController: MoveDelegate {
    func moveToVC() {
        performSegue(withIdentifier: "seguettotabbar", sender: self)
    }
}
