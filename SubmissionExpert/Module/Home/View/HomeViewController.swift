//
//  ViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import UIKit
import Alamofire
import Combine

struct AddMeal : Encodable {
    let date : Int
    let slot : Int
    let position: Int
    let type: String
    let value : ValueMeal
}

struct ValueMeal : Encodable {
    let id : Int
    let servings : Int
    let title : String
    let imageType: String
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tvHome: UITableView!
    
    @IBOutlet weak var navigationItemHome: UINavigationItem!
    
    private var randomMenuOffline: [MenuModel] = []
    private var resultMenuSearch: [MenuModel] = []
    
    @IBOutlet weak var cvHome: UICollectionView!
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    var presenter: HomePresenter?
    
    var textGreetings = "Hello, Good Morning"
    
    var listOfCategory = ["Chicken","Beef","Pork", "Fish", "Bread", "Pizza", "Burger", "Salad", "Soup"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "\(textGreetings)"
        
        
        //        navigationController?.isToolbarHidden = true
        //        navigationController?.isNavigationBarHidden = true
        
        
        //        registerTableView()
        registerCollectionView()
        
        getCategories()
        getChipFoodByCategories(foodTitle: "Chicken")
        
    }
    
    
    private func testAddData(){
        let addMealParam = AddMeal(date: 1627483221, slot: 1, position: 0, type: "RECIPE", value: ValueMeal(id: 296213, servings: 2, title: "Spinach Salad with Roasted Vegetables and Spiced Chickpea", imageType: ".jpg"))
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        // Alamofire supports passing any Encodable type as the parameters of a request. These parameters are then passed through a type conforming to the ParameterEncoder protocol and added to the URLRequest which is then sent over the network. Alamofire includes two ParameterEncoder conforming types: JSONParameterEncoder and URLEncodedFormParameterEncoder. These types cover the most common encodings used by modern services (XML encoding is left as an exercise for the reader).
        
        /*
         AF.request("https://api.spoonacular.com/mealplanner/api-75145-christoted123/items?username=api-75145-christoted123&hash=1ba07f6da0f70ae91f77bae4a8861de8636eaa9f&apiKey=e1f65dc5b65a4d2991aaee052f814b2b",
         method: .post,
         parameters: addMealParam,
         encoder: JSONParameterEncoder.default, headers: headers).responseJSON { response in
         print(response)
         
         }
         */
        
        AF.request("https://api.spoonacular.com/mealplanner/api-75145-christoted123/items?username=api-75145-christoted123&hash=1ba07f6da0f70ae91f77bae4a8861de8636eaa9f&apiKey=e1f65dc5b65a4d2991aaee052f814b2b",
                   method: .post,
                   parameters: addMealParam,
                   encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: AddRecipeResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        print(value.id)
                        print(value.status)
                        
                        
                    case .failure(let error):
                        print(error)
                    }
                   }
    }
    
    
    
    private func registerTableView() {
        tvHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell")
    }
    
    private func registerCollectionView() {
        cvHome.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.homeindentifier)
        cvHome.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cvHome.register(ChipCollectionViewCell.self, forCellWithReuseIdentifier: ChipCollectionViewCell.indentifier)
        cvHome.register(UINib(nibName: "ChipWithXIBCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ChipWithXIBCollectionViewCell.identifier)
        cvHome.register(UINib(nibName: "HomeResuableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeResuableView.identifier)
        cvHome.collectionViewLayout = createCollectionViewLayout()
        cvHome.delegate = self
        cvHome.dataSource = self
        cvHome.showsVerticalScrollIndicator = false
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
            self.randomMenuOffline = result
            //   self.tvHome.reloadData()
            self.cvHome.reloadData()
        }.store(in: &cancellables)
    }
    
    private func getChipFoodByCategories(foodTitle: String){
        loadingState = true
        presenter?.getSearchCategories(foodTitle: foodTitle).receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        }, receiveValue: { (result) in
            self.resultMenuSearch = result
            print("Result \(result)")
            let indexSet = IndexSet(integer: 2)
            self.cvHome.reloadSections(indexSet)
        }).store(in: &cancellables)
    }
}
/*
 extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return randomMenuOffline.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tvHome.dequeueReusableCell(withIdentifier: "homecell") as! HomeTableViewCell
 
 let menu = randomMenuOffline[indexPath.row]
 
 let urlPath: String = menu.image!
 
 DispatchQueue.global(qos: .userInteractive).async {
 
 let url = URL(string: urlPath)
 
 let imageData = try? Data(contentsOf: url!)
 
 DispatchQueue.main.async {
 cell.ivHome.image = UIImage(data: imageData!)
 }
 
 }
 
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
 dest.recipeId = randomMenuOffline[row].id ?? 654812
 dest.presenter?.router = presenter?.homeRouter
 dest.presenter = presenter?.homeRouter?.navigateToDetailModule()
 //  dest.recipeIdNew = randomMenuOffline[row].id ?? 654812
 }
 }
 
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 performSegue(withIdentifier: "toDetail", sender: indexPath)
 }
 
 }
 */

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeResuableView.identifier, for: indexPath) as? HomeResuableView else { fatalError() }
            
            sectionHeaderView.title = "Featured Food"
            
            return sectionHeaderView
        case 1:
            guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeResuableView.identifier, for: indexPath) as? HomeResuableView else { fatalError() }
            
            sectionHeaderView.title = "Category"
            
            return sectionHeaderView
        case 2:
            guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeResuableView.identifier, for: indexPath) as? HomeResuableView else { fatalError() }
            
            sectionHeaderView.title = "TEST"
            
            return sectionHeaderView
        default:
            guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeResuableView.identifier, for: indexPath) as? HomeResuableView else { fatalError() }
            
            sectionHeaderView.title = "TEST"
            
            return sectionHeaderView
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
       // print("INDEX \(indexPath) \(indexPath.row) \(indexPath.section)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "toDetail") {
            let dest = segue.destination as! DetailRecipeViewController
            let section = (sender as! NSIndexPath).section
            
            if section == 0 {
                let row = (sender as! NSIndexPath).row
                dest.recipeId = randomMenuOffline[row].id ?? 654812
                dest.presenter?.router = presenter?.homeRouter
                dest.presenter = presenter?.homeRouter?.navigateToDetailModule()
            } else if section == 2 {
                let row = (sender as! NSIndexPath).row
                dest.recipeId = resultMenuSearch[row].id ?? 654812
                dest.presenter?.router = presenter?.homeRouter
                dest.presenter = presenter?.homeRouter?.navigateToDetailModule()
            }
               
           
            //  dest.recipeIdNew = randomMenuOffline[row].id ?? 654812
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return randomMenuOffline.count
        case 1:
            return 9
        case 2:
            return resultMenuSearch.count
        default:
            return 0
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.homeindentifier, for: indexPath) as! HomeCollectionViewCell
            
            let menu = randomMenuOffline[indexPath.row]
            
            
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                let imageURL = URL(string: menu.image!)
                
                let imageData = try? Data(contentsOf: imageURL!)
                
                DispatchQueue.main.async {
                    cell.ivFoodHome.image = UIImage(data: imageData!)
                }
            }
            
            
            cell.containerView.backgroundColor = .white
            //    cell.ivFoodHome.image = UIImage(named: "teddy")
            cell.lblFoodHome.text = menu.title
            cell.layer.cornerRadius = 8
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
            
            
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipWithXIBCollectionViewCell.identifier, for: indexPath) as! ChipWithXIBCollectionViewCell
            
            
            cell.viewChip.backgroundColor = .white
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
            cell.lblChipTitle.text = listOfCategory[indexPath.row]
            cell.viewChip.layer.cornerRadius = 8
            cell.layer.cornerRadius = 8
            cell.delegate = self
            
            return cell
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.homeindentifier, for: indexPath) as! HomeCollectionViewCell
            
            let menu = resultMenuSearch[indexPath.row]
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                let imageURL = URL(string: menu.image!)
                
                let imageData = try? Data(contentsOf: imageURL!)
                
                DispatchQueue.main.async {
                    cell.ivFoodHome.image = UIImage(data: imageData!)
                }
            }
            
            cell.containerView.backgroundColor = .white
            cell.lblFoodHome.text = menu.title
            cell.layer.cornerRadius = 8
            cell.layer.cornerRadius = 8
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            cell.backgroundColor = .red
            cell.layer.cornerRadius = 8
            
            return cell
        }
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout{
        return UICollectionViewCompositionalLayout{ (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                //Item
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(175)))
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 2, trailing: 2)
                
                //Group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(250)), subitem: item, count: 1)
                
                // group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
                
                //Section Header
                let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .absolute(50.0))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: footerHeaderSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                
                section.boundarySupplementaryItems = [header]
                
                return section
            } else if section == 1 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(120), heightDimension: .absolute(35)))
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                //Group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitem: item, count: 4)
                
                //  group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
                section.orthogonalScrollingBehavior = .continuous
                
                //Section Header
                let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .absolute(50.0))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: footerHeaderSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                
                section.boundarySupplementaryItems = [header]
                
                return section
            } else if section == 2 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(175)))
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 5, trailing: 2)
                
                //Group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(150)), subitem: item, count: 1)
                
                group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 0, trailing: 2)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
                
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            }
            
            return nil
        }
    }
    
}

extension HomeViewController : ChipProtocol {
    func onChipPressed(title: String) {
        print("\(title)")
        getChipFoodByCategories(foodTitle: title)
    }
    
    
}
