//
//  Created by Anjana T'Jampens.
//  Based on Tasks 4 from class.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import RealmSwift
import UIKit

class Question: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var questionDescription = ""
    let answers = List<Answer>()
    
    convenience init(name: String, questionDescription: String = "") {
        self.init()
        self.name = name
        self.questionDescription = questionDescription
    }
}
