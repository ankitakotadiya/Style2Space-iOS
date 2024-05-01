//
//  ClientInsightTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 27/04/24.
//

import UIKit

class ClientInsightTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundTitleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var rowData: TableRows?
    private var imageModel: [ImageModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configureCollectionView() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: String.className(for: ImageGalleryCollectionViewCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: String.className(for: ImageGalleryCollectionViewCell.self))
        self.collectionView.reloadData()
    }
    
    func configure(for data: TableRows, imgModel: [ImageModel]) {
        self.rowData = data
        self.imageModel = imgModel
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: 0)
        self.backgroundTitleLabel.configure(text: self.rowData?.header.title, textColor: .white, font: UIFont.systemFont(ofSize: 19.0, weight: .bold), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
        
        self.titleLabel.configure(text: self.rowData?.title, textColor: .black, font: UIFont.systemFont(ofSize: 14.0), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
        
//        self.containerView.roundCorners(corners: [.topLeft, .topRight], radius: 25.0, fram: self.containerView.frame)
        self.containerView.layer.cornerRadius = 25.0
        self.containerView.backgroundColor = Colors.homeBackground
        self.collectionView.backgroundColor = Colors.homeBackground
        self.backgroundImage.image = UIImage(named: "header-insight")
        self.configureCollectionView()
        
    }
}

extension ClientInsightTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.className(for: ImageGalleryCollectionViewCell.self), for: indexPath) as? ImageGalleryCollectionViewCell {
            
            if let imgModel = self.imageModel?[indexPath.item] {
                cell.configure(for: imgModel)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ClientInsightTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-40, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust the value as needed for spacing between cells
    }
}
    
