//
//  ViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tvHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvHome.dataSource = self
        tvHome.delegate = self
        
        registerTableView()
    }
    
    private func registerTableView(){
        tvHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvHome.dequeueReusableCell(withIdentifier: "homecell") as! HomeTableViewCell
        
        cell.ivHome.image = UIImage(named: "teddy")
        cell.lblFoodId.text = "3001"
        cell.lblFoodName.text = "Pasta With Tuna"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

