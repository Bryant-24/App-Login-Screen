//
//  ViewController.swift
//  App-Login-Screen
//
//  Created by Ruslan Galiev on 4/6/23.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailUnderLineView: UIView!
    @IBOutlet var envelopeImageView: UIImageView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordUnderLineView: UIView!
    @IBOutlet var lockImageView: UIImageView!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var dontHaveAccountLabel: UILabel!
    @IBOutlet var signUpButton: UIButton!
    
    // MARK: - Properties
    private let activeColor = UIColor(named: "color") ?? UIColor.gray
    private var email: String = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(email.isEmpty || password.isEmpty)
            loginButton.backgroundColor = !(email.isEmpty || password.isEmpty) ? activeColor : .systemGray5
        }
    }
    private var password: String = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(email.isEmpty || password.isEmpty)
            loginButton.backgroundColor = !(email.isEmpty || password.isEmpty) ? activeColor : .systemGray5
        }
    }
    
    private let mockEmail = "abc@gmail.com"
    private let mockPassword = "123456"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func loginAction(_ sender: UIButton) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if email.isEmpty {
            makeErrorField(textField: emailTextField)
        }
        
        if password.isEmpty {
            makeErrorField(textField: passwordTextField)
        }
        
        if email == mockEmail && password == mockPassword {
            performSegue(withIdentifier: "goToHomePage", sender: sender)
        } else {
            let alert = UIAlertController(title: "Error".localized,
                                          message: "Wrong email or password".localized,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok".localized, style: .default)
            
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    private func setupLoginButton() {
        loginButton.layer.shadowColor = activeColor.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 4.0, height: 2.0)
        loginButton.layer.shadowOpacity = 1.0
        loginButton.layer.shadowRadius = 5.0
        loginButton.isUserInteractionEnabled = false
        loginButton.backgroundColor = .systemGray5
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else { return }
        
        switch textField {
        case emailTextField:
            let isValidEmail = check(email: text)
            
            if isValidEmail {
                email = text
                
                envelopeImageView.tintColor = .systemGray5
                emailUnderLineView.backgroundColor = .systemGray5
            } else {
                email = ""
                makeErrorField(textField: textField)
            }
        case passwordTextField:
            let isValidPassword = check(password: text)
            
            loginButton.isUserInteractionEnabled = isValidPassword
            loginButton.backgroundColor = isValidPassword ? activeColor : .systemGray5
            
            if isValidPassword {
                password = text
                
                lockImageView.tintColor = .systemGray5
                passwordUnderLineView.backgroundColor = .systemGray5
            } else {
                password = ""
                makeErrorField(textField: textField)
            }
        default:
            print("Unknown Text Field")
        }
    }
    
    private func check(email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
    
    private func check(password: String) -> Bool {
        password.count >= 4
    }
    
    private func makeErrorField(textField: UITextField) {
        switch textField {
        case emailTextField:
            envelopeImageView.tintColor = activeColor
            emailUnderLineView.backgroundColor = activeColor
        case passwordTextField:
            lockImageView.tintColor = activeColor
            passwordUnderLineView.backgroundColor = activeColor
        default:
            print("Unknown Text Field")
        }
    }
}

