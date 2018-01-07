//
//  Created by Anjana T'Jampens.
//  Based on Tasks 4 from class.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import RealmSwift
import UIKit

class AddQuestionViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    var question: Question?
    
    override func viewDidLoad() {
        if let question = question {
            saveButton.isEnabled = true
            nameField.text = question.name
            descriptionField.text = question.questionDescription
        }
    }
    
    @IBAction func moveFocus() {
        nameField.resignFirstResponder()
        descriptionField.becomeFirstResponder()
    }
    
    @IBAction func save() {
        if question != nil {
            performSegue(withIdentifier: "didEditQuestion", sender: self)
        } else {
            performSegue(withIdentifier: "didAddQuestion", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddQuestion"?:
            question = Question(name: nameField.text!, questionDescription: descriptionField.text!)
        case "didEditQuestion"?:
            try! Realm().write {
                question!.name = nameField.text!
                question!.questionDescription = nameField.text!
            }
        default:
            fatalError("Unknown segue")
        }
    }
    
}


extension AddQuestionViewController: UITextFieldDelegate {
    
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
