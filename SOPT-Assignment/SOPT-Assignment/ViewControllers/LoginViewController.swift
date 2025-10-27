//
//  LoginViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/25/25.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    private lazy var customNavigationBar = CustomNavigationBar().then {
        $0.configure(title: "이메일 또는 아이디로 계속", delegate: self)
    }
    
    private lazy var loginButton = ConfirmButton().then {
        $0.configure(title: "로그인")
    }
    
    private lazy var emailIdTextField = designedTextField().then {
        $0.placeholder = "이메일 아이디"
    }
    
    private lazy var passwordTextField = designedTextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
    }
    
    private lazy var clearPasswordButton = UIButton().then {
        $0.setImage(.crossGray, for: .normal)
        $0.isHidden = true
    }
    
    private lazy var toggleHidePasswordButton = UIButton().then {
        $0.setImage(.eyeSlash, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(toggleHidingPassword), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func toggleHidingPassword() {
        self.passwordTextField.isSecureTextEntry.toggle()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setEdittingMode()
        if textField == self.passwordTextField {
            clearPasswordButton.isHidden = false
            toggleHidePasswordButton.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setEdittingEndMode()
        if textField == self.passwordTextField {
            clearPasswordButton.isHidden = true
            toggleHidePasswordButton.isHidden = true
        }
    }
    
}

// MARK: - UI
extension LoginViewController {
    
    private func configureUI() {
        [customNavigationBar, emailIdTextField, passwordTextField,
         clearPasswordButton, loginButton, toggleHidePasswordButton].forEach {
            view.addSubview($0)
        }
        
        [emailIdTextField, passwordTextField, loginButton].forEach {
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
        
        customNavigationBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        emailIdTextField.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).offset(24)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailIdTextField.snp.bottom).offset(12)
        }
        
        clearPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.width.height.equalTo(30)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-56)
        }
        
        toggleHidePasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.width.height.equalTo(22)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
    }
    
    private func designedTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 4
        textField.font = .systemFont(ofSize: 14)
        
        textField.delegate = self
        
        textField.addPadding()
        textField.snp.makeConstraints { make in
            make.height.equalTo(46)
        }
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }
    
}

extension UITextField {
    func addLeftPadding(_ width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(_ width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
        /// 텍스트 필드에 좌우 패딩을 한 번에 추가합니다.
    func addPadding(leftAmount: CGFloat = 10, rightAmount: CGFloat = 10) {
        addLeftPadding(leftAmount)
        addRightPadding(rightAmount)
    }
    
    func setEdittingMode() {
        self.layer.borderColor = UIColor.baeminBlack.cgColor
        self.layer.borderWidth = 2
    }
    
    func setEdittingEndMode() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


#Preview {
    LoginViewController()
}
