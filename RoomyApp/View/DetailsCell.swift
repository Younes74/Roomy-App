//
//  DetailsCell.swift
//  RoomyApp
//
//  Created by mac on 7/31/19.
//  Copyright © 2019 Fons. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageOne: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setup(with room: Rooms) {
        imageOne.sd_setImage(with: URL(string: room.image!), placeholderImage: nil)
        placeLabel.text = room.place
        priceLabel.text = room.price
        titleLabel.text = room.title

    }
    
}
