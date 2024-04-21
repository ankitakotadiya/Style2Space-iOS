//
//  MainCoordinator.swift
//  CarviOSTask
//
//  Created by Ankita Kotadiya on 30/07/23.
//

import Foundation
import UIKit


class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let backButtonImage = UIImage(named: "back")
        self.navigationController.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController.navigationBar.tintColor = .black
    }
    
    func start() {
        let vc = SignUpViewController.instantiate() //This code can be reused while initiating view controller

        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func PushtoLogin() {
        let login = ViewController.instantiate()
        login.coordinator = self
        navigationController.pushViewController(login, animated: true)
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
}
