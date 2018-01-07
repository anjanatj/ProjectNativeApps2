//
//  Created by Anjana T'Jampens.
//  Based on Tasks 4 from class.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import RealmSwift
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var category: Category!
    var questions: Results<Question>!
    
    let realm = try! Realm()
    var filteredQuestions: Results<Question>!
    
    private var indexPathToEdit: IndexPath!
    
    override func viewDidLoad() {
        searchBar.delegate = self
        questions = category.questions.filter("TRUEPREDICATE")
        filteredQuestions = questions
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
            let q = addQuestionViewController.question!
            NSLog(category.name)
            NSLog(q.name)
            let realm = try! Realm()
            try! realm.write {
                category.questions.append(q)
                NSLog(category.name)
                NSLog((category.questions.first?.name)!)
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
        return filteredQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionCell
        cell.question = filteredQuestions[indexPath.row]
        return cell
    }
}

extension QuestionViewController: UISearchBarDelegate {
    // Source: https://github.com/codepath/ios_guides/wiki/Search-Bar-Guide
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredQuestions = questions
        } else {
            filteredQuestions = questions.filter("name CONTAINS[cd] %@", searchText.lowercased())
        }
        tableView.reloadData()
    }
}
