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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI() {
        [customNavigationBar, loginButton].forEach {
            view.addSubview($0)
        }
        
        customNavigationBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(235)
        }
    }
    
}

#Preview {
    LoginViewController()
}
