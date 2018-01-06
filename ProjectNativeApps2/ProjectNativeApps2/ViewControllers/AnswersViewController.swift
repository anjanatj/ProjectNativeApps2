import RealmSwift
import UIKit

class AnswersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionName: UITextField!
    @IBOutlet weak var questionDescription: UITextView!
    
    var question: Question!
    var answers: Results<Answer>!
    
    private var indexPathToEdit: IndexPath!
    
    override func viewDidLoad() {
        answers = try! Realm().objects(Answer.self)
        questionName.text = question.name
        questionDescription.text = question.questionDescription
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "addAnswer"?:
            break
        case "editAnswer"?:
            let addAnswerViewController = segue.destination as! AddAnswerViewController
            addAnswerViewController.answer = answers[indexPathToEdit.row]
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindFromAddAnswer(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddAnswer"?:
            let addAnswerViewController = segue.source as! AddAnswerViewController
            let realm = try! Realm()
            try! realm.write {
                realm.add(addAnswerViewController.answer!)
            }
            tableView.insertRows(at: [IndexPath(row: answers.count - 1, section: 0)], with: .automatic)
        case "didEditAnswer"?:
            tableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Unkown segue")
        }
    }
}

extension AnswersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            self.indexPathToEdit = indexPath
            self.performSegue(withIdentifier: "editAnswer", sender: self)
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor.orange
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            let answer = self.answers[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(answer)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

extension AnswersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerCell
        cell.answer = answers[indexPath.row]
        return cell
    }
}

