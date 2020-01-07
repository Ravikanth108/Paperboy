//
//  EntertainmentTableViewCell.swift
//  Paperboy
//
//  Created by sai Nikhil on 2019-12-06.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit

class EntertainmentTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
