//
//  FavouriteViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 19/05/21.
//

import UIKit
import Combine

class FavouriteViewController: UIViewController, FavouriteRouterDelegate {
   
    

    @IBOutlet weak var tvFav: UITableView!
    
    var presenter: FavouritePresenter?
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    private var favouriteMenu: [MenuModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvFav.dataSource = self
        tvFav.delegate = self 
        registerTableView()
        
        makeFavouriteView()
        
        getFavouriteMenu()
    }
    
    func makeFavouriteView() {
        let usecase = Injection().provideHomeUseCase()
        let presenter = FavouritePresenter(useCase: usecase)
        
        self.presenter = presenter

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavouriteMenu()
    }
    
    private func registerTableView(){
        tvFav.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell")
    }
    
    private func getFavouriteMenu() {
        loadingState = true
        
        presenter?.getBookmarkedMenu().receive(on: RunLoop.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        } receiveValue: { (result) in
            print("hasil", result)
        }.store(in: &cancellables)
        
        
        presenter?.getBookmarkedMenu().receive(on: RunLoop.main).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                self.loadingState = false
                print("Finishied")
                
            case .failure(let error):
                self.loadingState = false
                print("Error ", error)
            }
        }, receiveValue: { (result) in
            
            print("Hasil ", result)
            
            self.favouriteMenu = result
            self.tvFav.reloadData()
            
        }).store(in: &cancellables)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguefavtodetail" {
            let dest = segue.destination as! DetailRecipeViewController
            let row = (sender as! NSIndexPath).row
            dest.recipeId = favouriteMenu[row].id ?? 654812
        }
    }
    
}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvFav.dequeueReusableCell(withIdentifier: "homecell") as! HomeTableViewCell
        
        let menu = favouriteMenu[indexPath.row]
        
        let urlPath = menu.image
        
        let url = URL(string: urlPath!)
        
        DispatchQueue.global(qos: .userInteractive).async {
            let imageData = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                cell.ivHome.image = UIImage(data: imageData!)
            }
        }
        
        cell.lblFoodId.text = "\(menu.id as! Int)"
        cell.lblFoodName.text = menu.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seguefavtodetail", sender: indexPath)
    }
    
    
}
