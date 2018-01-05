import RealmSwift
import UIKit

class Answer: Object {
    
    @objc dynamic var text = ""
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
}
