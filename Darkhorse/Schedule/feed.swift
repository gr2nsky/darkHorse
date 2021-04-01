//
//  feed.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/28.
//

import Foundation

func selectFeed(){
    while(true){
        print("급여할 사료를 선택하세요.       0: 이전 메뉴로")
        print("한번 선택하면 다 쓸때까지 해당 사료를 유지합니다.")
        user.schedule.printNowFeed()
        printMyFeed()
        
        var input = Int(readLine()!)
        switch input {
        case 1:
            setFeed(code: input! + 2)
        case 2:
            setFeed(code: input! + 2)
        case 0:
            return
        default:
            print("올바르지 않은 입력입니다.")
        }
    }
}



func printMyFeed(){
    print("[보유 사료]")
    print("1.\(user.inventory[3].name) : \(user.inventory[3].amount)개")
    print("2.\(user.inventory[4].name) : \(user.inventory[4].amount)개")
    print("------------------------------")
}

func setFeed(code: Int){
    if user.getItem(code) == nil {
        user.schedule.feed = 0
        print("error")
    }
    
    if user.getItem(code)!.amount == 0 {
        user.schedule.feed = 0
        print("보유하지 않은 사료입니다.")
        DispatchQueue.global().sync {
            sleep(2)
        }
        return
    }
    
    print("변경이 완료 되었습니다.")
    DispatchQueue.global().sync {
        sleep(2)
    }
    user.schedule.feed = code
}
