//
//  PlanEntity.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 02/08/21.
//

import Foundation
import RealmSwift

class PlanEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var dayCategory: String = ""
    @objc dynamic var date: String = ""
    var listMenuEntity = List<MenuEntity>()
    @objc dynamic var foodListTitle: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var isChecked: Bool = false
    
}
