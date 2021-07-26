//
//  SearchResultViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 26/07/21.
//

import UIKit

class SearchResultViewController: UIViewController {
    var queryText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ASd",queryText)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ASD",queryText)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
