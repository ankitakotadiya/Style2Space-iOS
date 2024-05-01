//
//  ImageGalleryCollectionViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 24/04/24.
//

import UIKit

class ImageGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    
    private var imgModel: ImageModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(for data: ImageModel) {
        self.imageView.image = UIImage(named: data.image)
    }

}
