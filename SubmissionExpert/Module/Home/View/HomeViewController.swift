//
//  ViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import UIKit
import Alamofire
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var tvHome: UITableView!

    @IBOutlet weak var navigationItemHome: UINavigationItem!
    
    private var randomMenu: [RandomMenuResponse] = []
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []

    var presenter: HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tvHome.dataSource = self
        tvHome.delegate = self
        
        navigationItemHome.title = "Foodiecipe"
    
        registerTableView()

        getCategories()
    }

    private func registerTableView() {
        tvHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell")
    }

    private func getCategories() {
        loadingState = true
        presenter?.getCategories().receive(on: RunLoop.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        } receiveValue: { (result) in
            self.randomMenu = result
            self.tvHome.reloadData()
        }.store(in: &cancellables)
    }
    
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvHome.dequeueReusableCell(withIdentifier: "homecell") as! HomeTableViewCell

        let menu = randomMenu[indexPath.row]
        cell.ivHome.image = UIImage(named: "teddy")
        cell.lblFoodId.text = "\(menu.id ?? 0)"
        cell.lblFoodName.text = menu.title

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "toDetail") {
            let dest = segue.destination as! DetailRecipeViewController
            let row = (sender as! NSIndexPath).row
            dest.recipeId = randomMenu[row].id ?? 654812
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }

}

