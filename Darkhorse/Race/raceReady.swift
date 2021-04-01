//
//  raceReady.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/23.
//

import Foundation

/**
 달리는 말의 수에 알맞은 index-horse쌍의 딕셔너리를 생성합니다.
 */
func horseDictionrtyMake(userHorse: Horse, level: Int) -> Dictionary<Int, Horse>{
    let aiHorses = aiHorseMaker(level : level)
    var horseDictionary: [Int : Horse] = [:]
    let horseNames: [String] = aiHorses.getHorseName()
    var numOfHorse: Int {
        switch level {
        case 1:
            return 4
        case 2:
            return 6
        case 3:
            return 8
        default:
            return 8
        }
    }
    
    let userNum: Int = Int.random(in: 0...numOfHorse - 1)
    horseDictionary.updateValue(userHorse, forKey: userNum)
    
    for i in 0...numOfHorse - 1 {
        if i != userNum {
            let horse: Horse = Horse(popHorseName(horseNames, horseDictionary))
            horse.stats = aiHorses.getHorseStats()
            horseDictionary.updateValue(horse, forKey: i)
        }
    }
    
    return horseDictionary
}

/**
 말 이름을 출력하고 출력한 이름은 배열에서 삭제합니다.
 */
func popHorseName(_ horseNameArr: [String], _ dic: Dictionary<Int, Horse>) -> String{
    let arr = horseNameArr
    var horseName: String = ""
    while true {
        let index: Int = Int.random(in: 0...(horseNameArr.count - 1))
        horseName = arr[index]
        for value in dic.values {
            if value.name == horseName {
                continue
            }
        }
        return horseName
    }
}
/**
 idex-horse 쌍의 dictionary를 index순서대로  horse의 정보를 출력한다.
 */
func printReadyHorse(_ horses: Dictionary<Int, Horse>){

    for i in 0...horses.count - 1 {
        print("[\(i + 1)번 레인]", terminator : " ")
        horses[i]!.printStats()
    }
}
