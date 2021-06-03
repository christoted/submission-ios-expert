//
//  MenuDetailEntity.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 28/05/21.
//

import Foundation
import RealmSwift

class MenuDetailEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var summary: String = ""
  //  @objc dynamic var dishTypes: [String] = []
    
    var extendedIngredients: [IngridientEntity] = []
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


