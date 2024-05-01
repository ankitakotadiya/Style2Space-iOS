//
//  Coordinator.swift
//  CarviOSTask
//
//  Created by Ankita Kotadiya on 30/07/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var tabNavControllers: [UINavigationController] { get set }
    var window: UIWindow {get}
    func start()
}
