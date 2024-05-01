//
//  HomeViewController.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 23/04/24.
//

import UIKit

class HomeViewController: UIViewController, Storyboard {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var locationButton: UIButton?
    var dropdownButton: UIButton?
    
    weak var coordinator: MainCoordinator?
    private let homeViewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUPNavigation()
        self.setUpTableView()
    }
    
    private func setUPNavigation() {
        self.titleLabel.configure(text: "Hello Ankita,", textColor: Colors.AppColour, font: UIFont.systemFont(ofSize: 19.0, weight: .bold), backgroundColor: .clear, numberOfLines: 0, alignment: .left)

        let logoImage = UIImage(named: "app-logo")?.withRenderingMode(.alwaysOriginal)
        let leftButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = leftButton
        
        self.locationButton = UIButton(type: .system)
        self.locationButton?.setImage(UIImage(named: "location"), for: .normal)
        self.locationButton?.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
        self.locationButton?.addTarget(self, action: #selector(locationItemClicked(_:)), for: .touchUpInside)
        
        self.dropdownButton = UIButton(type: .system)
        self.dropdownButton?.setTitle("London", for: .normal)
        self.dropdownButton?.setImage(UIImage(named: "down-arrow"), for: .normal)
        self.dropdownButton?.frame = CGRect(x: 30 , y: 0, width: 70, height: 30)
        self.dropdownButton?.semanticContentAttribute = .forceRightToLeft
        
        let rightItemsView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        rightItemsView.addSubview(self.locationButton!)
        rightItemsView.addSubview(self.dropdownButton!)
        
        let rightItem = UIBarButtonItem(customView: rightItemsView)
        
        let contactImage = UIImage(named: "contact")?.withRenderingMode(.alwaysOriginal)
        let rightItemContact = UIBarButtonItem(image: contactImage, style: .plain, target: self, action: #selector(contactItemClicked(_:)))
        self.navigationItem.rightBarButtonItems = [rightItemContact, rightItem]
    }
    
    private func setUpTableView() {
        
        self.homeTableView.register(UINib(nibName: String.className(for: PlaceBidTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String.className(for: PlaceBidTableViewCell.self))
        
        self.homeTableView.register(UINib(nibName: String.className(for: HeaderTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String.className(for: HeaderTableViewCell.self))
        
        self.homeTableView.register(UINib(nibName: String.className(for: ClientInsightTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String.className(for: ClientInsightTableViewCell.self))

        self.homeTableView.dataSource = self
        self.homeTableView.delegate = self
        self.homeTableView.separatorColor = Colors.separatorColor
        self.homeTableView.backgroundColor = Colors.homeBackground
        self.homeTableView.estimatedRowHeight = 356.0
        self.homeTableView.rowHeight = UITableView.automaticDimension
//        self.homeTableView.reloadData()
    }
    
    @objc func contactItemClicked(_ sender: UIBarButtonItem) {
        
    }
    
    @objc func locationItemClicked(_ sender: UIButton) {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.homeViewModel.rowsSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.rowsSections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionNo = self.homeViewModel.rowsSections[indexPath.section].title
        
        if sectionNo == .first {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String.className(for: PlaceBidTableViewCell.self)) as? PlaceBidTableViewCell {
                cell.delegate = self
                cell.configure(homeModel: self.homeViewModel.rowsSections[indexPath.section].rows[indexPath.row], imgModel: self.homeViewModel.imageModel)
                return cell
            }
        } else if sectionNo == .second {
            if let headerCell = tableView.dequeueReusableCell(withIdentifier: String.className(for: HeaderTableViewCell.self)) as? HeaderTableViewCell {
                headerCell.configure(for: self.homeViewModel.rowsSections[indexPath.section].rows[indexPath.row], imgModel: self.homeViewModel.imageModel)
                return headerCell
            }
        } else if sectionNo == .third {
            if let insightCell = tableView.dequeueReusableCell(withIdentifier: String.className(for: ClientInsightTableViewCell.self)) as? ClientInsightTableViewCell {
                insightCell.configure(for: self.homeViewModel.rowsSections[indexPath.section].rows[indexPath.row], imgModel: self.homeViewModel.imageModel)
                return insightCell
            }
        }
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: PlaceBidTableViewCellProtocol {
    func placeBidButtonClicked(type: ButtonTitles) {
        self.coordinator?.pushToPlaceBidVC()
    }
}
