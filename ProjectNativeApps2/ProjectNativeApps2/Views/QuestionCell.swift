import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var question: Question! {
        didSet {
            nameLabel.text = question.name
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

