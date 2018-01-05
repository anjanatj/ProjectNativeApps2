import RealmSwift
import UIKit

class Question: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var questionDescription = ""
    let questions = List<Answer>()
    
    convenience init(name: String, questionDescription: String = "") {
        self.init()
        self.name = name
        self.questionDescription = questionDescription
    }
}
