//
//  HealthTableViewCell.swift
//  Paperboy
//
//  Created by sai Nikhil on 2019-12-08.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit

class HealthTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
