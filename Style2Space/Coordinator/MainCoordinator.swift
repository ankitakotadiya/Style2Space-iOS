//
//  MainCoordinator.swift
//  CarviOSTask
//
//  Created by Ankita Kotadiya on 30/07/23.
//

import Foundation
import UIKit


class MainCoordinator: Coordinator {
    var window: UIWindow
    var tabNavControllers: [UINavigationController] = []
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBar: CustomTabBarController = CustomTabBarController()
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        self.navigationController.setupNavigationAppearance()
    }
    
    func start() {
        let vc = SignUpViewController.instantiate() //This code can be reused while initiating view controller

        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func tabNavigationController() -> UINavigationController {
        let index = self.tabBar.selectedIndex
        return self.tabNavControllers[index]
    }
    
    func PushtoLogin() {
        let login = ViewController.instantiate()
        login.coordinator = self
        
//        navigationController.pushViewController(login, animated: true)
        
        self.tabNavigationController().pushViewController(login, animated: true)
            
    }
    
    func PushtoAccountVerification() {
        let account = AccountVerificationViewController.instantiate()
        account.coordinator = self
        let accountViewModel = AccountVerificationViewModel(viewType: AccountType.verification)
        account.accountViewModel = accountViewModel
//        account.modalPresentationStyle = .fullScreen
//        navigationController.present(account, animated: true)
        navigationController.pushViewController(account, animated: true)
    }
    
    func PushtoForgotPassword() {
        let forgotpass = AccountVerificationViewController.instantiate()
        forgotpass.coordinator = self
        let accountViewModel = AccountVerificationViewModel(viewType: AccountType.forgotpassword)
        forgotpass.accountViewModel = accountViewModel
//        account.modalPresentationStyle = .fullScreen
//        navigationController.present(account, animated: true)
        navigationController.pushViewController(forgotpass, animated: true)
    }
    
    func PushtoNewPassword() {
        let newpass = CreatePasswordViewController.instantiate()
        newpass.coordinator = self
        navigationController.pushViewController(newpass, animated: true)
    }
    
    private func setupHomeViewController() -> UINavigationController {
        let homeVC = HomeViewController.instantiate()
        homeVC.coordinator = self
        let homeNavigation = UINavigationController(rootViewController: homeVC)
        homeNavigation.setupNavigationAppearance()
        self.tabNavControllers.append(homeNavigation)
        
        return homeNavigation
    }
    
    private func setupSearchViewController() -> UINavigationController {
        let searchVC = SearchViewController.instantiate()
        let searchNavigation = UINavigationController(rootViewController: searchVC)
        searchNavigation.setupNavigationAppearance()
        self.tabNavControllers.append(searchNavigation)
        
        return searchNavigation
    }
    
    private func setupBidViewController() -> UINavigationController {
        let bidVC = BidViewController.instantiate()
        let bidNavigation = UINavigationController(rootViewController: bidVC)
        bidNavigation.setupNavigationAppearance()
        self.tabNavControllers.append(bidNavigation)
        
        return bidNavigation
    }
    
    private func setupFavouriteViewController() -> UINavigationController {
        let favouriteVC = FavouriteViewController.instantiate()
        let favNavigation = UINavigationController(rootViewController: favouriteVC)
        favNavigation.setupNavigationAppearance()
        self.tabNavControllers.append(favNavigation)
        
        return favNavigation
    }
    
    private func setupSettingsViewController() -> UINavigationController {
        let settingsVC = SettingsViewController.instantiate()
        let settingsNavigation = UINavigationController(rootViewController: settingsVC)
        settingsNavigation.setupNavigationAppearance()
        self.tabNavControllers.append(settingsNavigation)
        
        return settingsNavigation
    }
    
}

extension MainCoordinator {
    func navigateToSearchInterior() {
        let interior = SearchInteriorDesignerViewController.loadFromNib()
        interior.coordinator = self
        navigationController.pushViewController(interior, animated: true)

    }
    
    func pushToPlaceBidVC() {
        let placrBid = PlaceBidViewController.loadFromNib()
        placrBid.coordinator = self
        self.tabNavigationController().pushViewController(placrBid, animated: true)

        
    }
}

extension MainCoordinator {
    func setHomeViewControllers() {
        self.tabBar = CustomTabBarController.instantiate()
        self.tabBar.coordinator = self
        let tabNav = UINavigationController(rootViewController: tabBar)
        self.navigationController = tabNav
        self.navigationController.setupNavigationAppearance()
        
        let home = self.setupHomeViewController()
        let search = self.setupSearchViewController()
        let bid = self.setupBidViewController()
        let favourite = self.setupFavouriteViewController()
        let settings = self.setupSettingsViewController()
        
        self.tabBar.setViewControllers([home, search, bid, favourite, settings], animated: true)
        
        self.window.rootViewController = tabNav
        self.window.makeKeyAndVisible()
    }
}
