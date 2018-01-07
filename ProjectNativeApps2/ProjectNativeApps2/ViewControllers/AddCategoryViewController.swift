//
//  Created by Anjana T'Jampens.
//  Based on Tasks 4 from class.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import RealmSwift
import UIKit

class AddCategoryViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    
    var category: Category?
    
    override func viewDidLoad() {
        if let category = category {
            title = category.name
            nameField.text = category.name
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func hideKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func save() {
        if category != nil {
            performSegue(withIdentifier: "didEditCategory", sender: self)
        } else {
            performSegue(withIdentifier: "didAddCategory", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddCategory"?:
            category = Category(name: nameField.text!)
        case "didEditCategory"?:
            try! Realm().write {
                category!.name = nameField.text!
            }
        default:
            fatalError("Unknown segue")
        }
    }
}

extension AddCategoryViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let oldText = text as NSString
            let newText = oldText.replacingCharacters(in: range, with: string)
            saveButton.isEnabled = newText.count > 0
        } else {
            saveButton.isEnabled = string.count > 0
        }
        return true
    }
}
