//
//  OnBoardingViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 23/08/21.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    //A lazy var is a property whose initial value is not calculated until the first time it's called.
    lazy var view0: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        let label = UILabel()
        label.text = "Page 0"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view)
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("TEST", for: .normal)
        button.addTarget(self, action: #selector(move), for: .touchUpInside)
        view.addSubview(button)
        
        return view
    }()
    
    lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        let label = UILabel()
        label.text = "Page 1"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view)
        return view 
    }()
    
    lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        let label = UILabel()
        label.text = "Page 2"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view)
        return view
    }()
    
    lazy var view3: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        let label = UILabel()
        label.text = "Page 3"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view)
        
        return view
    }()
    
    @objc private func move(sender: UIButton!) {
        print("segueToTabBar")
     
        performSegue(withIdentifier: "seguetotabbariden", sender: self)
        
    }
    
    
    lazy var views = [view0, view1, view2, view3]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
        
        for i in 0..<views.count {
            scrollView.addSubview(views[i])
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
        
        scrollView.delegate = self
        
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        pageControl.currentPage = 0
        
        return pageControl
    }()
    
    @objc private func pageControlTapHandler(sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.edgeTo(view)
        
        view.addSubview(pageControl)
        pageControl.pinTo(view)
    }

}

extension OnBoardingViewController: UIScrollViewDelegate {
    //Content Offset -> The position of the content view within the scroll view is called the content offset 
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
