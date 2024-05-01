//
//  CustomTabBarController.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 23/04/24.
//

import UIKit

class CustomTabBarController: UITabBarController, Storyboard {
    
    weak var coordinator: MainCoordinator?
    private let tabBarViewModel: TabBarViewModel = TabBarViewModel()
    private var bidButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "Home"
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = Colors.AppColour
        
        self.setupBidButton(imageName: ImageName.bid.rawValue)
        self.setTabBarItems()
        

    }
    
    private func setTabBarItems() {
        for (index, viewController) in self.viewControllers?.enumerated() ?? [].enumerated() {
            
            guard let tabBarItem = viewController.tabBarItem else { continue }
            let tabItem = self.tabBarViewModel.tabItems[index]
            
            tabBarItem.image = UIImage(named: tabItem.imageName.rawValue)
            tabBarItem.selectedImage = UIImage(named: tabItem.selecteImage.rawValue)
            
            if tabItem.imageName == .bid {
                tabBarItem.image = UIImage(named: "")
            }
        }
    }
    
    private func setupBidButton(imageName: String) {
        
        lazy var customView: UIView = {
            let safeArea = self.coordinator?.window.safeAreaInsets.bottom ?? CGFloat(0)
            let tabBarHeight = self.tabBar.frame.height + safeArea
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: tabBarHeight))
            view.backgroundColor = Colors.tabTint
            view.layer.cornerRadius = 20
            return view
        }()

        self.bidButton = {
            let button = UIButton(frame: CGRect(x: self.view.bounds.width/2 - 30, y: -20, width: 60, height: 60))
            button.setBackgroundImage(UIImage(named: imageName), for: .normal)
            return button
        }()
        
        customView.addSubview(self.bidButton!)
        self.tabBar.addSubview(customView)
    }
    
}
