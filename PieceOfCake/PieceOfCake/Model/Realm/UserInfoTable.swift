//
//  UserInfoTable.swift
//  PieceOfCake
//
//  Created by 이중엽 on 2/18/24.
//

import UIKit
import RealmSwift

class UserInfoTable {
    @Persisted(primaryKey: true) var UID: ObjectId
    @Persisted var id: String
    @Persisted var password: String
    
    convenience init(id: String, password: String) {
        self.init()
        
        self.id = id
        self.password = password
    }
}
