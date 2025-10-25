//
//  CustomNavigationBar.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/25/25.
//

import UIKit
import SnapKit
import Then

class CustomNavigationBar: UIView {
    
    var delegate: UIViewController?
    
    private lazy var backButton = UIButton().then {
        $0.setImage(.leftPointer, for: .normal)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    func configure(title: String,
                   isLeftButtonShown: Bool = true,
                   delegate: UIViewController) {
        titleLabel.text = title
        backButton.isHidden = isLeftButtonShown
    }
    
    func setConstraints() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func backButtonTapped() {
        guard let delegate = delegate else { return }
        if delegate.navigationController != nil {
            delegate.navigationController?.popViewController(animated: true)
        } else {
            delegate.dismiss(animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
