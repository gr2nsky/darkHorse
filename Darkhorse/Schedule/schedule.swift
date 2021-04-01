//
//  schedule.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/24.
//

import Foundation


/**
 - 체력(일반/중급/고급) : 11/2/3
 - 힘(일반/중급/고급) : 21/12/13
 - 민첩(일반/중급/고급) : 31/22/23
 */
class Schedule{
    
    var scheduleArr = [0, 0]
    var feed = 3
    
    func printSchedule(){
        print("[아침 스케쥴]", terminator : " ")
        printTraining(scheduleArr[0])
        print("[점심 스케쥴]", terminator : " ")
        printTraining(scheduleArr[1])
    }

    
    func printTraining(_ training: Int){

        if( scheduleArr[0] == 0 ) {
            print("휴식")
            return
        }
        switch training / 10 {
        case 1:
            print("체력훈련 - ", terminator : " ")
        case 2:
            print("힘 훈련 - ", terminator : " ")
        case 3:
            print("민첩 훈련 - ", terminator : " ")
        default:
            return
        }
        switch training % 10 {
        case 1:
            print("일반")
        case 2:
            print("중급")
        case 3:
            print("고급")
        default:
            return
        }
    }
    
    func printNowFeed(){
        var feedNum = user.schedule.feed
        print("[현재 사료]", terminator: " ")
        switch user.schedule.feed {
        case 0:
            print("기본 사료")
        default:
            print ("\(user.getItem(feedNum)!.name) : \(user.getItem(feedNum)!.amount)개")
        }
    }
}

func getScheduleName(scheduleNum: Int) -> String {
    switch scheduleNum/10 {
    case 1:
        return "체력"
    case 2:
        return "힘"
    case 3:
        return "민첩"
    default:
        return "error"
    }
}

func restHorse() -> Int{
    print("말이 휴식을 취합니다...")
    DispatchQueue.global().sync {
        sleep( UInt32(Int.random(in: 3...5)) )
    }
    let ranNum = Int.random(in: 1...10)
    if ranNum < 2 {
        print("[말이 꿀맛같은 휴식을 취힙니다.] 피로도 회복 30")
        return 30
    } else if ranNum < 4 {
        print("[말이 푹 쉰듯합니다.] 피로도 회복 20")
        return 20
    } else if ranNum < 9 {
        print("[말이 개운해 보입니다.] 피로도 회복 + 10")
        return 20
    } else {
        print("[말이 휴식을 거부합니다.] 피로도 회복 0")
        return 0
    }
    DispatchQueue.global().sync {
        sleep( UInt32(Int.random(in: 3...5)) )
    }
}


func fullRest(){
    var maxFatigue = Double(user.horse!.fatigueMax)
    var healPercent: Double = 0
    var heal: Double = 0
    var startCount = 2
    var endCoutn = 11
    if user.inventory[5].amount == 1 {
        startCount = 1
        endCoutn = 9
    } else if user.inventory[4].amount == 1 {
        startCount = 0
        endCoutn = 6
    }

    
    print("하루가 끝나고 휴식을 갖습니다...")
    DispatchQueue.global().sync {
        sleep( UInt32(Int.random(in: 3...5)) )
    }
    let ranNum = Int.random(in: startCount...endCoutn)
    if ranNum < 3 {
        healPercent = 0.5
        print("[말이 꿀잠을 자는 중 입니다...]")
    } else if ranNum < 6 {
        healPercent = 0.3
        print("[말이 고른 숨소리를 내며 자고 있습니다...]")
    } else if ranNum < 9 {
        healPercent = 0.3
        print("[말이 잠자리가 불편한듯 뒤척이고 있습니다...]")
    } else {
        healPercent = 0.2
        print("[말이 뜬눈으로 지새고 있습니다...] ")
    }
    
    if user.inventory[6].amount == 1 {
        healPercent *= 2
    } else if user.inventory[5].amount == 1 {
        healPercent *= 1.5
    }
    
    print ("피로도가 \(healPercent*100) 회복되었습니다.")
    heal = maxFatigue * healPercent
    
    user.horse!.fatigueDegree -= Int(heal)
    if user.horse!.fatigueDegree < 0 {
        user.horse!.fatigueDegree = 0
    }
    DispatchQueue.global().sync {
        sleep( UInt32(Int.random(in: 3...5)) )
    }
}
