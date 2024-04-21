//
//  LoginViewModel.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 17/04/24.
//

import Foundation
import Combine

protocol LoginViewModelDelegate: AnyObject {
    func callLoginAPI(email: String, password: String)
}

protocol LoginDataSourceProtocol{
    var titleLabel: String {get}
    var descriptionLabel: String {get}
    var emailPlaceHolder: String {get}
    var passwordPlaceHolder: String {get}
    func forgotPasswordButtonTitles() -> (forgotPassword: String, reset: String)
}

class LoginViewModel: LoginDataSourceProtocol {
    
    weak var delegate: LoginViewModelDelegate?
    var loginUser: LoginUser?
    private var cancellables = Set<AnyCancellable>()
    
    var titleLabel: String {
        return "Welcome\nBack"
    }
    
    var descriptionLabel: String {
        return "We're delighted to welcome you back. Please enter your login details to access your account."
    }
    
    var emailPlaceHolder: String {
        return "Email or Contact Number"
    }
    
    var passwordPlaceHolder: String {
        return "Password"
    }
    
    func forgotPasswordButtonTitles() -> (forgotPassword: String, reset: String) {
        return ("Forgot Password? ", "Reset")
    }
    
    func callLoginAPI(email: String, password: String, completion: @escaping (Result<LoginUser, Error>) -> Void) {
        
        ApiManager.shared.getData(endPoint: .login, method: .GET, headers: APIHeaders.defaultHeaders(), parameters: ["email": email, "password": password], type: LoginUser.self).sink { result in
            
            switch result{
                
            case .failure(let error):
                completion(.failure(error))
                
            case .finished:
                break
            }
        } receiveValue: { data in
            
            if let LoginUser = data.first {
                self.loginUser = LoginUser
                completion(.success(LoginUser))
            }
            
        }
        .store(in: &self.cancellables)
        
    }
    
}
