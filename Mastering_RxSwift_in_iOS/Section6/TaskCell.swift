//
//  TaskCell.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/16.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
