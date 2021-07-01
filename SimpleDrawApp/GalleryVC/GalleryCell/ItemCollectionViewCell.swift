//
//  ItemCollectionViewCell.swift
//  SimpleDrawApp
//
//  Created by CodergirlTM on 01.07.21.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var paintedImg: UIImageView!
    var image:UIImage! {
    didSet {
    self.paintedImg.image = image
    }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
