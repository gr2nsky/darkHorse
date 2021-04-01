//
//  UserInfo.swift
//  find fIndDecimal
//
//  Created by Yoon on 2021/03/19.
//

import Foundation

class UserInfo{
    var grade = 3
    let name: String
    var horse: Horse?
    var money = 10000
    var schedule: Schedule = Schedule()
    var inventory: [Item]
    var days: Int = 0
    
    var raceGrade = 3
    var win = 0
    var participation = 0
    var winRate: Int {
        return Int(win/participation * 100)
    }
    
    
    init(_ name: String){
        self.name = name
        inventory = initItemList()
        noneHorse()
    }
    
    func horseIsEmpty() -> Bool{
        if horse == nil {
            return true
        }
        return false
    }
    
    func noneHorse(){
        if horseIsEmpty() {
            print("말 이름을 정해주세요.")
            let inputedName = readLine()
            if let inputedName = inputedName {
                horse = Horse(inputedName)
            }
        }
    }
    
    func itemPurchase(_ code: Int, _ quantity: Int){
        for i in inventory {
            if i.code == code {
                i.amount += quantity
                money -= (i.price * quantity)
            }
        }
    }
    
    func getItem(_ input: Int) -> Item?{
        for i in inventory {
            if i.code == input {
                return i
            }
        }
        return nil
    }
    
    func printInventory(){
        print("[보유 아이템 목록]")
        havingItem()
    }
    
    func havingItem(){
        for i in inventory {
            if i.amount != 0 {
                print("\(i.name) : \(i.amount)개")
            }
        }
    }
    
    func getGrade() -> String{
        switch raceGrade {
        case 3:
            return "무명"
        case 2:
            return "유명"
        case 1:
            return "최고"
        default:
            return "error"
        }
    }
    
    func printIntro(){
        print("[\(user.name)]     소지금:\(user.money)     등급 : \(getGrade())")
        print("경주횟수 : \(participation)회    승수 : \(win)승     승률 : \(winRate)%")
    }
    
}


