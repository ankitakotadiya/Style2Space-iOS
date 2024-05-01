//
//  PlaceBidTableViewCell.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 24/04/24.
//

import UIKit

protocol PlaceBidTableViewCellProtocol: AnyObject {
    func placeBidButtonClicked(type: ButtonTitles)
}

class PlaceBidTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomDescLabel: UILabel!
    @IBOutlet weak var placeBidButton: UIButton!
    @IBOutlet weak var bottomLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLabelTopConstraint: NSLayoutConstraint!
    
    weak var delegate: PlaceBidTableViewCellProtocol?
    private var homeModel: TableRows?
    private var imageModel: [ImageModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.placeBidButton.addTarget(self, action: #selector(bottomButtonClicked), for: .touchUpInside)
    }
        
    private func configureCollectionView() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: String.className(for: ImageGalleryCollectionViewCell.self), bundle: Bundle.main), forCellWithReuseIdentifier: String.className(for: ImageGalleryCollectionViewCell.self))
        self.collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(homeModel: TableRows,imgModel: [ImageModel]) {
        self.homeModel = homeModel
        self.imageModel = imgModel
        
        let buttonTiles = homeModel.buttonTiles
        
        switch buttonTiles {
        case .placebid:
            configurePlaceBidMode()
            
        case .portfolio, .ideas:
            configurePortfolioOrIdeasMode()
            
        case .clintinterior, .insight:
            configureClintInteriorOrInsightMode()
            
        default:
            break
        }
        self.configureCollectionView()
    }
    
    private func configurePlaceBidMode() {
        guard let homeModel = homeModel else { return }
        
        titleLabel.configure(text: homeModel.title, textColor: .black, font: UIFont.systemFont(ofSize: 15.0), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
        bottomDescLabel.configure(text: homeModel.description, textColor: .black, font: UIFont.systemFont(ofSize: 19.0, weight: .bold), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
        
        collectionView.backgroundColor = .white
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 0.0
        placeBidButton.setImage(UIImage(named: "place-bid"), for: .normal)
        
        bottomLabelHeight.constant = 20.0
        bottomButtonTopConstraint.constant = 20.0
        bottomLabelTopConstraint.constant = 20.0
        buttonHeight.constant = 62.0
        separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    private func configurePortfolioOrIdeasMode() {
        guard let homeModel = homeModel else { return }
        
        separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: 0)
        titleLabel.configure(text: homeModel.title, textColor: .black, font: UIFont.systemFont(ofSize: 19.0, weight: .bold), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
        placeBidButton.setImage(UIImage(named: "view-all"), for: .normal)
        bottomDescLabel.text = ""
        
        bottomLabelTopConstraint.constant = 0.0
        bottomLabelHeight.constant = 0.0
        bottomButtonTopConstraint.constant = 20.0
        buttonHeight.constant = 62.0
        
        if homeModel.buttonTiles == .ideas {
            containerView.roundCorners(corners: [.topLeft, .topRight], radius: 25.0, fram: containerView.frame)
            containerView.backgroundColor = Colors.homeBackground
            collectionView.backgroundColor = Colors.homeBackground
        } else {
            collectionView.backgroundColor = .white
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 0.0
        }
    }

    private func configureClintInteriorOrInsightMode() {
        guard let homeModel = homeModel else { return }
        
        separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: 0)
        bottomLabelHeight.constant = 0.0
        bottomButtonTopConstraint.constant = 0.0
        bottomLabelTopConstraint.constant = 0.0
        buttonHeight.constant = 0.0
        placeBidButton.setImage(UIImage(named: ""), for: .normal)
        bottomDescLabel.text = ""
        
        if homeModel.buttonTiles == .clintinterior {
            titleLabel.configure(text: homeModel.title, textColor: .black, font: UIFont.systemFont(ofSize: 19.0, weight: .bold), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
            collectionView.backgroundColor = .white
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 0.0
        } else {
            titleLabel.configure(text: homeModel.title, textColor: .black, font: UIFont.systemFont(ofSize: 15.0), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
            containerView.roundCorners(corners: [.topLeft, .topRight], radius: 25.0, fram: containerView.frame)
            containerView.backgroundColor = Colors.homeBackground
            collectionView.backgroundColor = Colors.homeBackground
        }
    }
    
    @objc func bottomButtonClicked() {
        
        if let buttonTile = self.homeModel?.buttonTiles {
            self.delegate?.placeBidButtonClicked(type: buttonTile)
        }
    }
}

extension PlaceBidTableViewCell: UICollectionViewDataSource {
    
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

extension PlaceBidTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
