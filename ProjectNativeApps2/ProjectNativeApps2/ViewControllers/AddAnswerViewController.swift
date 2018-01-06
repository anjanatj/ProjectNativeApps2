import RealmSwift
import UIKit

class AddAnswerViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var answerField: UITextField!
    
    var answer: Answer?
    
    override func viewDidLoad() {
        if let answer = answer {
            saveButton.isEnabled = true
            answerField.text = answer.text
        }
    }
    
    @IBAction func hideKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func save() {
        if answer != nil {
            performSegue(withIdentifier: "didEditAnswer", sender: self)
        } else {
            performSegue(withIdentifier: "didAddAnswer", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didAddAnswer"?:
            answer = Answer(text: answerField.text!)
        case "didEditAnswer"?:
            try! Realm().write {
                answer!.text = answerField.text!
            }
        default:
            fatalError("Unknown segue")
        }
    }
}

extension AddAnswerViewController: UITextFieldDelegate {
    
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

