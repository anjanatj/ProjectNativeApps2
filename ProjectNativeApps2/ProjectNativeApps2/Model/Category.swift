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
