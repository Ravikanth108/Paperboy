//
//  TopNewsCollectionViewCell.swift
//  Paperboy
//
//  Created by sai Nikhil on 2019-12-07.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit

class TopNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.size.width + 5, height: 270))

               let gradient = CAGradientLayer()

               gradient.frame = view.frame

               gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]

               gradient.locations = [0.0, 1.0]

               view.layer.insertSublayer(gradient, at: 0)

               imgView.addSubview(view)

               imgView.bringSubviewToFront(view)
        
    }
    
}
