//
//  BannerData.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit

struct BannerData {
    var color: UIColor
    
    static let data: [BannerData] = [
        BannerData(color: .red),
        BannerData(color: .orange),
        BannerData(color: .yellow),
        BannerData(color: .green),
        BannerData(color: .blue),
        BannerData(color: .purple),
    ]
}
