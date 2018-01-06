import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var category: Category! {
        didSet {
            nameLabel.text = category.name
        }
    }
    
    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if !category.isInvalidated {
            nameLabel.text = category.name
        }
    }*/
}
