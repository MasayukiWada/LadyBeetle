//
//  SelectTagCell.swift
//  LadyBeetle
//
//  Created by Masayuki Wada on 2021/09/08.
//

import UIKit

class SelectTagCell: UITableViewCell {
    
    @IBOutlet weak var displayNameLabel:UILabel!

    func configure(tag:Tag){
        self.displayNameLabel.text = tag.displayName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
