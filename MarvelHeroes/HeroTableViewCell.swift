//
//  HeroTableViewCell.swift
//  MarvelHeroes
//
//  Created by Cesar Paiva on 29/09/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewThumbnail: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepareCell(with hero: Hero) {
        labelName.text = hero.name
        labelDescription.text = hero.description
        if let url = URL(string: hero.thumbnail.url) {
            imageViewThumbnail.kf.indicatorType = .activity
            imageViewThumbnail.kf.setImage(with: url)
        } else {
            imageViewThumbnail.image = nil
        }
        
        imageViewThumbnail.layer.cornerRadius = imageViewThumbnail.frame.size.height/2
        imageViewThumbnail.layer.borderColor = UIColor.red.cgColor
        imageViewThumbnail.layer.borderWidth = 2
    }
    
}
