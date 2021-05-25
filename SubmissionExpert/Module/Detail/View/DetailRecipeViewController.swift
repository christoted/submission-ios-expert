//
//  DetailRecipeViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/05/21.
//

import UIKit

class DetailRecipeViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var navigationItemDetail: UINavigationItem!
    var ingridientView: UIView!
    var summaryView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItemDetail.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(save))
        
        ingridientView = IngridientViewController().view
        summaryView = SummaryViewController().view
        
        viewContainer.addSubview(ingridientView)
        viewContainer.addSubview(summaryView)
        
        viewContainer.bringSubviewToFront(ingridientView)
      
    }
    
    @objc func save(){
      
    }
    
    @IBAction func switchAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewContainer.bringSubviewToFront(ingridientView)
            break
        case 1:
            viewContainer.bringSubviewToFront(summaryView)
            break
        default:
            viewContainer.bringSubviewToFront(summaryView)
            break
        }
    }
    

  

}
