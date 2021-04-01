//
//  item.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/26.
//

import Foundation

class Item {
    var code: Int
    var name: String
    var amount: Int = 0
    var price: Int
    var info : String
    
    init(_ code: Int, _ name: String, _ price: Int, _ info: String){
        self.code = code
        self.name = name
        self.price = price
        self.info = info
    }
    
    func printItem(){
        print("[\(code)]\(name):\(info) (\(price)원)")
    }
}

func initItemList() -> [Item]{
    let nomalTicket: Item = Item(1, "일반 시설이용 티켓", 200, "중급훈련시 필요한 티켓이다.")
    let advancedTicket: Item = Item(2, "고급 시설이용 티켓", 500, "고급훈련시 필요한 티켓이다.")
    let nomalFeed: Item = Item(3, "영양식 사료", 10, "일정을 소화해도 피로가 덜 쌓이게 해준다.")
    let advancedFeed: Item = Item(4, "초호화 사료", 50, "일정을 소화해도 피로가 훨씬 덜 쌓이게 해준다.")
    let nomalHouse: Item = Item(5, "편안한 축사", 4000, "취침시 피로회복량이 150% 증가한다.")
    let excellentHouse: Item = Item(6, "훌륭한 축사", 10000, "취침시 피로회복량이 200% 증가한다.")
    
    return [nomalTicket, advancedTicket, nomalFeed, advancedFeed, nomalHouse, excellentHouse]
}

func getItem(_ input: Int) -> Item?{
    let items: [Item] = initItemList()
    for i in items {
        if i.code == input {
            return i
        }
    }
    return nil
}

