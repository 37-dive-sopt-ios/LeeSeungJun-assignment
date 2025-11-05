//
//  BaeminFeedViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/5/25.
//

import UIKit
import SnapKit
import Then

class BaeminFeedViewController: UIViewController {
    
    private var baeminFeedView = BaeminFeedView().then {
        $0.self
    }
    
    override func viewDidLoad() {
        self.view = baeminFeedView
    }
    
    
}

#Preview {
    BaeminFeedViewController()
}
