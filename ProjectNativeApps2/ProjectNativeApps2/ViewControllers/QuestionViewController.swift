import RealmSwift
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category!
    var questions: Results<Question>!
    
    private var indexPathToEdit: IndexPath!
    
    override func viewDidLoad() {
        questions = try! Realm().objects(Question.self)
        title = category.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "addQuestion"?:
            break
        case "editQuestion"?:
            let addQuestionViewController = segue.destination as! AddQuestionViewController
            addQuestionViewController.question = questions[indexPathToEdit.row]
        case "showAnswers"?:
            let answersViewController = (segue.destination as! UINavigationController).topViewController as! AnswersViewController
            let selection = tableView.indexPathForSelectedRow!
            answersViewController.question = questions[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindFromAddQuestion(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddQuestion"?:
            let addQuestionViewController = segue.source as! AddQuestionViewController
            let realm = try! Realm()
            try! realm.write {
                realm.add(addQuestionViewController.question!)
            }
            tableView.insertRows(at: [IndexPath(row: questions.count - 1, section: 0)], with: .automatic)
        case "didEditQuestion"?:
            tableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Unkown segue")
        }
    }
}

extension QuestionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            self.indexPathToEdit = indexPath
            self.performSegue(withIdentifier: "editQuestion", sender: self)
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor.orange
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            let question = self.questions[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                question.answers.forEach(realm.delete(_:))
                realm.delete(question)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

extension QuestionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionCell
        cell.question = questions[indexPath.row]
        return cell
    }
}
