//
//  tranining.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/28.
//

import Foundation

/**
 - 체력(일반/중급/고급) : 11/2/3
 - 힘(일반/중급/고급) : 21/12/13
 - 민첩(일반/중급/고급) : 31/22/23
 */

func inputTranining(input: Int){
    let schduleTime = input - 1
    var scheduleNum = 0
    
    while true {
        print("훈련을 선택해주세요. [1]체력훈련 [2]힘 훈련 [3]민첩 훈련 [4]휴식 [0]종료")
        let input = Int(readLine()!)
        switch input {
        case 1:
            scheduleNum += 10
        case 2:
            scheduleNum += 20
        case 3:
            scheduleNum += 30
        case 4:
            scheduleNum += 0
        case 0:
            return
        default:
            print("유효하지 않은 입력입니다.")
        }

        scheduleNum = setTraniningIntensity(scheduleNum, schduleTime)
        if scheduleNum%10 == 0 {
            continue
        }
        user.schedule.scheduleArr[schduleTime] = scheduleNum
        break
    }
    
}
/**
1. 스케쥴 비어있을시 휴식하겠습니까? 확인받기
2. 스케쥴 진행해 말 능력치 관여하는 메서드 실행
 */
func setTraniningIntensity(_ scheduleNum: Int, _ schduleTime: Int) -> Int{
    var time: String{
        if schduleTime == 0{
            return "아침"
        }
        return "점심"
    }
    
    while true {
        print("훈련의 강도를 선택하세요. [1]일반 [2]중급 [3]고급 [0]이전 메뉴로")
        let input = Int(readLine()!)
        switch input {
        case 1:
            return scheduleNum + 1
        case 2:
            if user.inventory[1].amount == 0 {
                print("일반 시설 이용 티켓이 모자랍니다.")
                DispatchQueue.global().sync {
                    sleep(2)
                }
                return 0
            }
            return scheduleNum + 2
        case 3:
            if user.inventory[2].amount == 0 {
                print("고급 시설 이용 티켓이 모자랍니다.")
                DispatchQueue.global().sync {
                    sleep(2)
                }
                return 0
            }
            return scheduleNum + 3
        case 0:
            return scheduleNum
        default:
            print("유효하지 않은 입력입니다.")
        }
    }
}

func trainingProgress(trainingNum: Int){
    var trainingResult: Int = 0
    let trainingName = getScheduleName(scheduleNum: trainingNum)
    
    if user.horse!.fatigueDegree >= user.horse!.fatigueMax {
        print("말의 피로도가 너무 심하여 훈련진행이 불가능합니다. 휴식으로 대체합니다.")
        user.horse!.fatigueDegree -= restHorse()
        if (user.horse!.fatigueDegree < 0) {
            user.horse!.fatigueDegree = 0
        }
        return
    }
    
    if trainingNum == 0 {
        user.horse!.fatigueDegree -= restHorse()
        if (user.horse!.fatigueDegree < 0) {
            user.horse!.fatigueDegree = 0
        }
        return
    }
    
    DispatchQueue.global().sync {
        print("훈련을 진행 중압니다...")
        sleep( UInt32(Int.random(in: 3...5)) )
    }
    
    trainingResult = levelUp(trainingName, trainingNum)
    user.horse!.fatigueDegree += plusFatigue(trainingNum)

    switch trainingNum%10 {
    case 1:
        user.horse!.stats[0] += trainingResult
    case 2:
        user.horse!.stats[1] += trainingResult
    case 3:
        user.horse!.stats[2] += trainingResult
    default:
        print("error")
    }
    
    user.schedule.scheduleArr = [0, 0]
}

func plusFatigue(_ trainingNum: Int) -> Int{
    var ranNum = 10
    var userMaxFatigue: Double = Double(user.horse!.fatigueMax)
    var fatigue: Double = userMaxFatigue * 0.3
    switch trainingNum % 10 {
    case 1:
        ranNum = Int.random(in: 0...10)
    case 2:
        user.inventory[1].amount -= 1
        ranNum = Int.random(in: 1...9)
    case 3:
        user.inventory[2].amount -= 1
        ranNum = Int.random(in: 0...6)
    default:
        ranNum = Int.random(in: 0...10)
    }
    
    if user.schedule.feed == 4 {
        fatigue -= (userMaxFatigue * 0.05)
    }else if user.schedule.feed == 3 {
        fatigue -= (userMaxFatigue * 0.1)
    }

    DispatchQueue.global().sync {
        print("훈련을 진행 중압니다...")
        sleep( UInt32(Int.random(in: 3...5)) )
    }
    if ranNum < 2 {
        fatigue -= (userMaxFatigue * 0.2)
        print("[말이 이정도 훈련은 거뜬한듯 쌩쌩합니다.] 피로도 + \(Int(fatigue))")
    } else if ranNum < 4 {
        fatigue -= (userMaxFatigue * 0.15)
        print("[말은 훈련이 힘들었지만, 보람차다고 생각합니다.] 피로도 + \(Int(fatigue))")
    } else if ranNum < 9 {
        fatigue -= (userMaxFatigue * 0.1)
        print("[말이 억지로 훈련하느라 다소 피곤해합니다.] 피로도 + \(Int(fatigue))")
    } else {
        print("[말이 극심한 피로감을 호소합니다.]  피로도 + \(Int(fatigue))")
    }
    
    print("계속 진행하려면 아무키나 눌러주세요.")
    readLine()
    
    return Int(fatigue)
}

func levelUp(_ trainingName : String, _ trainingNum: Int) -> Int{
    var ranNum = 0
    switch trainingNum % 10 {
    case 1:
        ranNum = Int.random(in: 0...10)
    case 2:
        ranNum = Int.random(in: 2...11)
    case 3:
        ranNum = Int.random(in: 4...12)
    default:
        ranNum = Int.random(in: 0...10)
    }
    if ranNum < 5 {
        print("[훈련 실패] \(trainingName) : 변화가 없습니다.")
        return 0
    } else if ranNum < 9 {
        print("[훈련 성공] \(trainingName) : 1레벨 증가합니다.")
        return 1
    } else {
        print("[훈련 대성공] \(trainingName) : 2레벨 증가합니다.")
        return 2
    }
}
