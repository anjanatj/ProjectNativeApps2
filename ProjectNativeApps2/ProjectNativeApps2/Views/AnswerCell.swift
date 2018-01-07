import UIKit

class AnswerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var answer: Answer! {
        didSet {
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 10
            
            nameLabel.text = answer.text
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


