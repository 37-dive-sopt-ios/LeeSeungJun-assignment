//
//  WelcomeViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/27/25.
//

import UIKit
import SnapKit
import Then

class CombineWelcomeViewController: UIViewController {
    
    private var dismissAction: (() -> Void)?
    
    private lazy var navigationBar = CustomNavigationBar().then {
        $0.configure(title: "대체 누가 뼈짐 시켰어??", delegate: self)
    }
    
    private lazy var imaeView = UIImageView().then {
        $0.image = .welcome
    }
    
    private lazy var welcomeMainLabel = UILabel().then {
        $0.text = "환영합니다."
        $0.textAlignment = .center
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 24)
    }
    
    private lazy var welcomeSubLabel = UILabel().then {
        $0.text = "반가워요"
        $0.textAlignment = .center
        $0.font = UIFont(name: Pretendard.SemiBold.name(), size: 18)
        $0.numberOfLines = 1
    }
    
    private lazy var goBackButton = ConfirmButton().then {
        $0.configure(title: "뒤로가기", isAvailable: true)
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setConstraints()
    }
    
    @objc func backButtonTapped() {
        if dismissAction != nil {
            dismissAction!()
        }
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(TabBarController(), animated: false)
    }
    
    func configure(email: String, dismissAction: @escaping () -> Void) {
        welcomeSubLabel.text = "\(email)님 반가워요!"
        self.dismissAction = dismissAction
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
            make.height.equalTo(imaeView.snp.width).multipliedBy(211.0/375.0)
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
