//
//  ViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    @IBOutlet weak var tvHome: UITableView!
    
    var homePresenter: HomePresenter?
    
    var testRandomMenu: [RandomMenuResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvHome.dataSource = self
        tvHome.delegate = self
        
        homePresenter?.objectWillChange.makeConnectable()
            .autoconnect()
             .sink { [weak self] in
                print("TEST", self?.homePresenter?.getCategories())
                 DispatchQueue.main.async { [weak self] in
                    print("TEST", self?.homePresenter?.getCategories())
                 }
             }
        
       
        registerTableView()
        
       // getDataRemote()
    }
    
    private func registerTableView(){
        tvHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell")
    }
    
    private func getDataRemote() {
        if let url = URL(string: EndPoints.Gets.randomMenu.url) {
            AF.request(url)
                .validate()
                .responseDecodable(of: Response.self) { (response) in
                    switch response.result {
                    case .success(let value):
                       print("SUCESS \(value)")
                    case .failure(let value):
                        print("FAIL \(value)")
                    }
                }
        }
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

