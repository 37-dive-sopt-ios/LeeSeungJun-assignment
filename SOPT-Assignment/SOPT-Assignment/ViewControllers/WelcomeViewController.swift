//
//  WelcomeViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/27/25.
//

import UIKit
import SnapKit
import Then

class WelcomeViewController: UIViewController {
    
    private lazy var navigationBar = CustomNavigationBar().then {
        $0.configure(title: "대체 누가 뼈짐 시켰어??", delegate: self)
    }
    
    private lazy var imaeView = UIImageView().then {
        $0.image = .welcome
    }
    
    private lazy var welcomeMainLabel = UILabel().then {
        $0.text = "환영합니다."
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    private lazy var welcomeSubLabel = UILabel().then {
        $0.text = "반가워요"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.numberOfLines = 1
    }
    
    private lazy var goBackButton = ConfirmButton().then {
        $0.configure(title: "뒤로가기", isAvailable: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setConstraints()
    }
    
    func configure(email: String) {
        welcomeSubLabel.text = "\(email)님 반가워요!"
    }
    
    func addSubviews() {
        [navigationBar, imaeView, welcomeMainLabel, welcomeSubLabel, goBackButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        [navigationBar, imaeView, welcomeMainLabel, welcomeSubLabel].forEach {
            $0.snp.makeConstraints{ make in
                make.leading.trailing.equalToSuperview()
            }
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        imaeView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.height.equalTo(211)
        }
        
        welcomeMainLabel.snp.makeConstraints { make in
            make.top.equalTo(imaeView.snp.bottom).offset(24)
        }
        
        welcomeSubLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeMainLabel.snp.bottom).offset(14)
        }
        
        goBackButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-48)
        }
    }
    
}

#Preview {
    WelcomeViewController()
}
