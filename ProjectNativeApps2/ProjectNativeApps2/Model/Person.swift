import RealmSwift
import UIKit

class Person: Object {
    
    @objc dynamic var nickname = ""
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    
    convenience init(nickname: String, firstname: String, lastname: String, email: String, password: String) {
        self.init()
        self.nickname = nickname
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
    }
}
