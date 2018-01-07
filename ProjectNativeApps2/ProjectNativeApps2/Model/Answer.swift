//
//  Created by Anjana T'Jampens.
//  Based on Tasks 4 from class.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import RealmSwift
import UIKit

class Answer: Object {
    
    @objc dynamic var text = ""
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
}
