//
//  ConfirmButton.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/25/25.
//

import UIKit
import SnapKit

final class ConfirmButton: UIButton {
    
    private var toggle = false
    var isAvailable: Bool { return toggle } // get-only property
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    private lazy var title: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    func configure(title: String, isAvailable: Bool = false) {
        self.title.text = title
        toggle = self.isAvailable
        if isAvailable {
            setAvailableMode()
        } else {
            setUnavailableMode()
        }
    }
    
    func setUnavailableMode() {
        self.backgroundColor = .baeminGray
        toggle = false
        self.isEnabled = false
    }
    
    func setAvailableMode() {
        self.backgroundColor = .baeminMint
        toggle = true
        self.isEnabled = true
    }
    
    func toggleMode() {
        toggle.toggle()
        if toggle {
            setAvailableMode()
        } else {
            setUnavailableMode()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
