//
//  Horse.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/23.
//

import Foundation

class Horse {
    let name: String
    var stats: [Int] = [1, 1, 1]
    var fatigueDegree = 0
    
    var fatigueMax: Int{
        return 100 + (stats[0] * 10)
    }
    var runMax: Int{
        var run = 2 + (stats[1] / 3)
        if fatigueDegree >= fatigueMax {
            run /= 2
        }
        return run
    }
    var sleepMax: Int{
        var sleepMax: Double = 3000000
        sleepMax -= Double(stats[2]) * 50000.0
        if sleepMax < 1000000 {
            sleepMax = 1000001
        }
        if fatigueDegree >= fatigueMax {
            sleepMax *= 1.5
        }
        return Int(sleepMax)
    }
        
    init(_ name: String){
        self.name = name
    }
    
    func printMyHorseInfo(){
        print("[\(name)]       진행일수 : \(user.days)    \n\(stats[0]+stats[1]+stats[2])급  [피로도]\(fatigueDegree)/\(fatigueMax)")
        print("[체력]\(stats[0]) [힘]\(stats[1]) [민첩성]\(stats[2])")
    }
    
    func printStats(){
        print("[\(name)]\n\(stats[0]+stats[1]+stats[2])급 : [체력]\(stats[0]) [힘]\(stats[1]) [민첩성]\(stats[2])")
    }
}
class aiHorseMaker{
    var level: String
    var eName = ["천둥", "짱빨라", "총알탄", "부우움", "야나두", "주피선더", "제우스", "쥬피썬더"]
    var nName = ["포세이돈", "광개토", "패왕", "타락파워전사", "강력한", "소문", "나폴리", "징키즈칸", "백마", "메시", "호날두", "손흥민"]
    var hName = ["Tomahork", "Thunder","Babieca","Incitatus","Pyrois","Eous","Aethon","Phlegon","적토마","오추마","팔준마","기린마","거루"]
    
    init(level: Int) {
        switch level {
        case 1:
            self.level = "easy"
        case 2:
            self.level = "nomal"
        case 3:
            self.level = "hard"
        default:
            self.level = "hard"
        }
    }
    
    var eStats:[Int]{
        var result: [Int] = []
        for _ in 0...2 {
            let statsPersentage: Int = Int.random(in: 1...100)
            if statsPersentage < 20 {

                result.append(Int.random(in: 4...8))
            }
            else if statsPersentage >= 20 && statsPersentage < 50{
                result.append(Int.random(in: 2...5))
            }
            else {
                result.append(Int.random(in: 1...3))
            }
        }
        return result
    }
    var nStats:[Int]{
        var result: [Int] = []
        for _ in 0...2 {
            let statsPersentage: Int = Int.random(in: 1...100)
            if statsPersentage < 20 {

                result.append(Int.random(in: 13...18))
            }
            else if statsPersentage >= 20 && statsPersentage < 50{
                result.append(Int.random(in: 9...14))
            }
            else {
                result.append(Int.random(in: 5...10))
            }
        }
        return result
    }
    var hStats:[Int]{
        var result: [Int] = []
        for _ in 0...2 {
            let statsPersentage: Int = Int.random(in: 1...100)
            if statsPersentage < 20 {

                result.append(Int.random(in: 35...40))
            }
            else if statsPersentage >= 20 && statsPersentage < 50{
                result.append(Int.random(in: 25...35))
            }
            else {
                result.append(Int.random(in: 20...30))
            }
        }
        return result
    }
    
    func getHorseName() -> [String]{
        var horseNames: [String] = []
        switch level {
            case "easy":
                horseNames = eName
            case "nomal":
                horseNames = nName
            case "hard":
                horseNames = hName
            default:
                horseNames = hName
        }
        return horseNames
    }
    
    func getHorseStats() -> [Int]{
        var horseStats: [Int] = []
        switch level {
            case "easy":
                horseStats = eStats
            case "nomal":
                horseStats = nStats
            case "hard":
                horseStats = hStats
            default:
                horseStats = hStats
        }
        return horseStats
    }
}
