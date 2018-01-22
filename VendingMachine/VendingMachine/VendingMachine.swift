//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by yuaming on 2018. 1. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class VendingMachine {
    private var money: Money
    private var inventory: Inventory
    
    init() {
        self.money = Money(0)
        self.inventory = Inventory([])
    }
}

extension VendingMachine {
    func fetchListOfPurchasableBeverages() -> [BeverageBox] {
        return checkCurrentInventory().filter ({
            $0.beverageMenu.makeInstance().price <= money
        })
    }
    
    func fetchListOfHottedBeverage() -> [BeverageMenu] {
        return allMenus.filter ({
            if let coffee = $0.makeInstance() as? Coffee {
                return coffee.isHot
            }
            
            return false
        })
    }
    
    func fetchListOfValidDate() -> [BeverageMenu] {
        return allMenus.filter ({
            $0.makeInstance().isExpired(with: DateUtility.today())
        })
    }
}

extension VendingMachine: Userable {
    func insertMoney(coin: Money) throws {
        money = try money.plus(coin: coin)
    }

    func deductMoney(coin: Money) throws {
        money = try money.subtract(coin: coin)
    }

    func countChange() -> Int {
        return money.countChange()
    }

    func buyBeverage(beverageMenu: BeverageMenu) throws {
        let beverage = beverageMenu.makeInstance()
        try deductBeverage(beverageMenu: beverageMenu)
        try deductMoney(coin: beverage.price)
    }
}

extension VendingMachine: MachineManagerable {
    func insertBeverage(beverageMenu: BeverageMenu, quantity: Int = 1) {
        inventory = inventory.add(beverageMenu: beverageMenu, quantity: quantity)
    }

    func deductBeverage(beverageMenu: BeverageMenu, quantity: Int = 1) throws {
        inventory = try inventory.deduct(beverageMenu: beverageMenu, quantity: quantity)
    }

    func countBeverageQuantity(beverageMenu: BeverageMenu) -> Int {
        return inventory.countBeverage(beverageMenu: beverageMenu)
    }
    
    func checkCurrentInventory() -> [BeverageBox] {
        return inventory.fetchListOfBeverage()
    }
    
    func supply(_ defaultQuantity: Int = 1) {
        allMenus.forEach {
            insertBeverage(beverageMenu: $0, quantity: defaultQuantity)
        }
    }
}

