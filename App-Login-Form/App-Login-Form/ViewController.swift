//
//  ViewController.swift
//  App-Login-Form
//
//  Created by Ruslan Galiev on 4/12/23.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var emailImageView: UIImageView!
    @IBOutlet var emailUnderlineView: UIView!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordImageView: UIImageView!
    @IBOutlet var passwordUnderlineView: UIView!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    // MARK: - Properties
    private let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    
    private let activeBlueColor = UIColor(named: "Blue") ?? UIColor.blue
    private let activeRedColor = UIColor(named: "Red") ?? UIColor.red
    
    private let emailMock = "abc@gmail.com"
    private let passwordMock = "1234567a"
    
    private var isCorrectEmailValue = false
    private var isCorrectPasswordValue = false
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setEnabledLoginButton(false)
    }
    
    // MARK: - IBActions
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        checkField(sender)
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        checkField(sender)
    }

    @IBAction func actionLoginButton(_ sender: UIButton) {
        if emailTextField.text == emailMock && passwordTextField.text == passwordMock {
            performSegue(withIdentifier: "goToHomePage", sender: sender)
        } else {
            let alert = UIAlertController(title: "Error",
                                          message: "Wrong email or password",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    // MARK: - Methods
    private func checkField(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            setEnabledLoginButton(false)
            return
        }
        
        switch textField {
        case emailTextField:
            isCorrectEmailValue = isCorrectEmail(text)
        case passwordTextField:
            isCorrectPasswordValue = isCorrectPassword(text)
        default:
            print("This Is Unknown Text Field")
        }
        
        setEnabledLoginButton(isCorrectEmailValue && isCorrectPasswordValue)
    }
    
    private func isCorrectEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }

    private func isCorrectPassword(_ password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPredicate.evaluate(with: password)
    }

    private func setEnabledLoginButton(_ isEnabled: Bool) {
        print("No")
        loginButton.backgroundColor = isEnabled ? activeBlueColor : UIColor.systemGray6
        loginButton.tintColor = isEnabled ? .white : .gray
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        setEnabledLoginButton(false)
        return true
    }
}
