//
//  MarketData.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit

struct MarketData {
    var name: String
    var image: UIImage
    
    static let data: [MarketData] = [
        MarketData(name: "B마트", image: UIImage()),
        MarketData(name: "CU", image: UIImage()),
        MarketData(name: "이마트슈퍼", image: UIImage()),
        MarketData(name: "홈플러스", image: UIImage()),
        MarketData(name: "GS25", image: UIImage()),
        MarketData(name: "홈플슈퍼", image: UIImage()),
        MarketData(name: "이마트24", image: UIImage()),
        MarketData(name: "GS더프레시", image: UIImage()),
        MarketData(name: "JAJU", image: UIImage()),
        MarketData(name: "펫마트", image: UIImage()),
        ]
}

