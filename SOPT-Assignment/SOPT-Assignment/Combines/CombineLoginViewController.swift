//
//  LoginViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/25/25.
//

import Combine
import UIKit

import SnapKit
import Then

final class CombineLoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: UI Components
    
    private lazy var customNavigationBar = CustomNavigationBar().then {
        $0.configure(title: "이메일 또는 아이디로 계속", delegate: self)
    }
    
    private lazy var loginButton = ConfirmButton().then {
        $0.configure(title: "로그인")
        $0.addTarget(self, action: #selector(pushWelcomeViewController), for: .touchUpInside)
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
        $0.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
    }
    
    private lazy var toggleHidePasswordButton = UIButton().then {
        $0.setImage(.eye, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(toggleHidePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var findAccountButton = UIButton().then {
        $0.setTitle("계정 찾기 >", for: .normal)
        $0.setTitleColor(.baeminBlack, for: .normal)
        $0.titleLabel?.font = UIFont(name: Pretendard.Regular.name(), size: 14)
    }
    
    // MARK: Setup Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        hideKeyboardWhenTappedAround()
        setSubscription()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureUI() {
        [customNavigationBar, emailIdTextField, passwordTextField,
         clearPasswordButton, loginButton, toggleHidePasswordButton,
         findAccountButton].forEach {
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
        
        findAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(32)
        }
    }
    
    private func setSubscription() {
        emailIdTextField
            .textDidChangePublisher()
            .sink { [weak self] id in
                guard let self else { return }
                self.viewModel.id.send(id)
            }
            .store(in: &cancellables)
        
        passwordTextField
            .textDidChangePublisher()
            .sink { [weak self] password in
                guard let self else { return }
                self.viewModel.password.send(password)
            }
            .store(in: &cancellables)
        
        viewModel.isLoginEnabled
            .sink { [weak self] isEnabled in
                guard let self else { return }
                if isEnabled {
                    loginButton.setAvailableMode()
                } else {
                    loginButton.setUnavailableMode()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: Action Methods
    
    @objc func clearTextField() {
        passwordTextField.text = ""
        loginButton.setUnavailableMode()
    }
    
    @objc func toggleHidePasswordButtonTapped() {
        self.passwordTextField.isSecureTextEntry.toggle()
        self.toggleHidePasswordButton.setImage(self.passwordTextField.isSecureTextEntry ? .eye : .eyeSlash , for: .normal)
    }
    
    @objc func pushWelcomeViewController() {
        let vc = CombineWelcomeViewController()
        vc.configure(email: emailIdTextField.text!) { [weak self] in
            self?.emailIdTextField.text = ""
            self?.passwordTextField.text = ""
        }
        // 강제 언래핑 : 버튼은 TextField.text가 반드시 채워져야지만 활성화되기 때문에 사용했다.
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Private Methods
    
    private func designedTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 4
        textField.font = UIFont(name: Pretendard.Regular.name(), size: 14)
        textField.tintColor = .baeminMint300
        
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

#Preview {
    UINavigationController(rootViewController: CombineLoginViewController())
}
