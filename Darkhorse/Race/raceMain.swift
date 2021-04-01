//
//  raceMain.swift
//  darkhorse
//
//  Created by 윤재필 on 2021/03/22.
//

import Foundation

func raceMainFlow(){
    
    while(true){
        let selected: Int? = selectedRace()
        if let selected = selected {
            if raceSelect(selected) == 0 {
                break
            }
        } else {
            print("입력 오류. 다시 입력하세요")
        }
    }
}	

func raceSelect(_ input: Int) -> Int{
    switch input {
    case 0:
        return 0
    case 1...3:

        mappingRace(input)
        return 1
    default:
        return 9
    }
}

func selectedRace() -> Int?{
    if dayCount == 0 {
        print("오늘 훈련일정을 소화하지 않았습니다. 경주는 저녁에 시작되므로, 경주 후엔 훈련이 불가능합니다.")
    } else if dayCount >= 2 {
        print("이미 오늘 경주를 소화하셨습니다. 다음날에 참가해 주세요.")
        return 0
    }
    
    print("달릴 대회를 선택하세요")
    print("1. 동네 그랑프리\n2. 한국 그랑프리\n3. 월드 챔시언십\n0. 메인 메뉴로")
    let selected: String? = readLine()
    if let selected = selected {
        if Int(selected) != nil{
            return Int(selected)
        }
    }
    return 9
}

func mappingRace(_ input: Int ){
    let dic = horseDictionrtyMake(userHorse: user.horse!, level: input)
    printReadyHorse(dic)
    
    print("준비됬다면 아무키나 입력해 주세요")
    readLine()
    
    var lenth: Int {
        switch input {
        case 1:
            return 8
        case 2:
            return 20
        case 3:
            return 30
        default:
            return 8
        }
    }

    raceStart(level: input, lenth: lenth, horseDic: dic)
    user.horse!.fatigueDegree += raceFatigue()
    dayCount += 2
    print("계속 진행하려면 아무키나 입력해주세요.")
    readLine()
}

func raceFatigue() -> Int{
    let ranNum = Int.random(in: 1...10)
    if ranNum < 2 {
        print("[말이 이정도 레이스 거뜬한듯 쌩쌩합니다.] 피로도 + 10")
        return 10
    } else if ranNum < 4 {
        print("[말이 레이스를 무사히 끝마쳤습니다.] 피로도 + 20")
        return 20
    } else if ranNum < 9 {
        print("[말이 다소 지친 기색입니다.] 피로도 + 30")
        return 30
    } else {
        print("[말이 극심한 피로감을 호소합니다.]  피로도 + 50")
        return 50
    }
}
