//
//  Beverage.swift
//  VendingMachine
//
//  Created by 심 승민 on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class Beverage: CustomStringConvertible {
    // 브랜드(String), 무게(Int), 가격(Int), 이름(String), 제조일자(Date)
    private let brand: String
    private let volume: Int
    private let price: Int
    private let productName: String
    private let manufacturedDate: Date
    init(_ brand: String, _ volume: Int, _ price: Int, _ productName: String, _ manufacturedDate: Date) {
        self.brand = brand
        self.volume = volume
        self.price = price
        self.productName = productName
        self.manufacturedDate = manufacturedDate
    }
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("YYYYMMdd")
        return "\(self.brand), \(self.volume)ml, \(self.price)원, \(self.productName), \(dateFormatter.string(from: self.manufacturedDate))"
    }
}
