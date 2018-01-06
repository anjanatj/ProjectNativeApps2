import UIKit

class AnswerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var answer: Answer! {
        didSet {
            nameLabel.text = answer.text
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


