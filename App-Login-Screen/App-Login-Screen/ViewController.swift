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
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordUnderLineView: UIView!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var dontHaveAccountLabel: UILabel!
    @IBOutlet var signUpButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButton()
    }
    
    // MARK: - IBActions
    @IBAction func loginAction(_ sender: UIButton) {
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    private func customizeButton() {
        loginButton.layer.shadowColor = UIColor(red: 216/255, green: 73/255, blue: 52/255, alpha: 1).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 4.0, height: 2.0)
        loginButton.layer.shadowOpacity = 1.0
        loginButton.layer.shadowRadius = 5.0
    }
}

