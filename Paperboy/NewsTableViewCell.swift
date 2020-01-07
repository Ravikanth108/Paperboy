//
//  NewsTableViewCell.swift
//  Paperboy
//
//  Created by Shyam on 01/12/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
