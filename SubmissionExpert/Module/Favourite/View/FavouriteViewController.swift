//
//  FavouriteViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 19/05/21.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var tvFav: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvFav.dataSource = self
        tvFav.delegate = self 
        registerTableView()
    }
    
    private func registerTableView(){
        tvFav.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell")
    }
    
}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvFav.dequeueReusableCell(withIdentifier: "homecell") as! HomeTableViewCell
        
        cell.ivHome.image = UIImage(named: "teddy")
        cell.lblFoodId.text = "3001"
        cell.lblFoodName.text = "Pasta With Tuna"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 
    }
    
    
}
