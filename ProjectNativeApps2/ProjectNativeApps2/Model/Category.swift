//
//  Created by Anjana T'Jampens.
//  Based on Tasks 4 from class.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import RealmSwift
import UIKit

class Category: Object {
    
    @objc dynamic var name = ""
    let questions = List<Question>()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
}
