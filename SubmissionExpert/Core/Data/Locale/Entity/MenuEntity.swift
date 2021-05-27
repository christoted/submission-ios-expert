//
//  Menu.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import RealmSwift

class MenuEntity: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var imageType: String = ""
    @objc dynamic var isBookmarked: Bool = false 
    
    var nutrition: [NutrientsEntity] = []
   
    override static func primaryKey() -> String? {
        return "id"
    }
    
}


class NutrientsEntity: Object  {
    @objc dynamic var title: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var unit: String = ""
    
    
}

