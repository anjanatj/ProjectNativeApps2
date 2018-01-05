import RealmSwift
import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: Results<Category>!
    
    private var indexPathToEdit: IndexPath!
    
    override func viewDidLoad() {
        categories = try! Realm().objects(Category.self)
    }
}
