//
//  shop.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/26.
//

import Foundation

func shopFlow(){
    while true {
        print("[상점]                      [보유금액\(user.money)원]")
        for i in user.inventory {
            i.printItem()
        }
        print("구매하실 아이템을 선택해주세요. [0:메인메뉴로]")
        let input = Int(readLine()!)
        switch input{
        case 0:
            return
        case nil:
            print("유효하지 않은 입력입니다.")
            continue
        default:
            selectItem(input!)
        }
    }
}

func selectItem(_ input: Int) {
    var selectedItem: Item?
    
    selectedItem = getItem(input)
    if selectedItem == nil{
        print("error")
        return
    }
    
    if input < 5 {
        expendables(selectedItem!)
    } else {
        notConsumable(input, selectedItem!)
    }

}
func notConsumable (_ input: Int, _ selectedItem: Item){
    if user.inventory[input].amount == 1 {
        print("이미 보유하고 있는 상품입니다.")
        print("진행하려면 아무키나 입력해 주세요")
        readLine()
        return
    }
    if user.money < selectedItem.price{
        print("구매금액이 \(selectedItem.price - user.money)원 모자랍니다.")
        print("진행하려면 아무키나 입력해 주세요")
        readLine()
        return
    }
    
    print("\(selectedItem.name)을/를  \(selectedItem.price)원에 구매하셨습니다.")
    user.itemPurchase(selectedItem.code, 1)
    print("진행하려면 아무키나 입력해 주세요")
    readLine()
    return
}

func expendables(_ selectedItem: Item){
    while(true){
        print("\(selectedItem.name)을/를 구매할 수량을 입력해주세요. [0: 취소]")
        let input = Int(readLine()!)
        if input == nil {
            print("올바른 입력이 아닙니다.")
            continue
        }
        if input == 0 {
            return
        }
        
        if user.money < selectedItem.price * input! {
            print("구매금액이 \((selectedItem.price * input!) - user.money)원 모자랍니다.")
            print("진행하려면 아무키나 입력해 주세요")
            readLine()
        }
        
        print("\(selectedItem.name)을/를 \(input!)개를 \(selectedItem.price * input!)원에 구매하셨습니다.")
        user.itemPurchase(selectedItem.code, input!)
        print("진행하려면 아무키나 입력해 주세요")
        readLine()
        break
    }
}
