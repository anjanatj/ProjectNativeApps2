//
//  Created by Anjana T'Jampens.
//  Based on Tasks 4 from class.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import RealmSwift
import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: Results<Category>!
    
    private var indexPathToEdit: IndexPath!
    
    override func viewDidLoad() {
        categories = try! Realm().objects(Category.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "addCategory"?:
            break
        case "editCategory"?:
            let addCategoryViewController = segue.destination as! AddCategoryViewController
            addCategoryViewController.category = categories[indexPathToEdit.row]
        case "showQuestions"?:
             let questionViewController = (segue.destination as! UINavigationController).topViewController as! QuestionViewController
             let selection = tableView.indexPathForSelectedRow!
             questionViewController.category = categories[selection.row]
             NSLog(questionViewController.category.name)
             tableView.deselectRow(at: selection, animated: true)
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindFromAddCategory(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didAddCategory"?:
            let addCategoryViewController = segue.source as! AddCategoryViewController
            let realm = try! Realm()
            try! realm.write {
                realm.add(addCategoryViewController.category!)
            }
            tableView.insertRows(at: [IndexPath(row: categories.count - 1, section: 0)], with: .automatic)
        case "didEditCategory"?:
            tableView.reloadRows(at: [indexPathToEdit], with: .automatic)
        default:
            fatalError("Unkown segue")
        }
    }
}


extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, completionHandler) in
            self.indexPathToEdit = indexPath
            self.performSegue(withIdentifier: "editCategory", sender: self)
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor.orange
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            let category = self.categories[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                category.questions.forEach(realm.delete(_:))
                realm.delete(category)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

extension CategoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        cell.category = categories[indexPath.row]
        return cell
    }
}

