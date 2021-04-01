import Foundation
/**
 - arr : 참가한 말들의 배열
 - rnak : 참가한 말들이 골인시 순서대로 append
 - lenth : 경주 길이
 - horseDic: index-Horse 쌍으로 구성된 딕셔너리 타입
 */
class Race {
    var raceProgress: [Int] = []
    var rank: [Int] = []
    var lenth: Int
    var horseDic: [Int:Horse]
    var level: Int
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
    /**
     - Parameters:
        - numOfHorse: 경주에 참여하는 말의 수
        - lenth: 경주 길이
     */
    init(level: Int, lenth: Int, horseDic: Dictionary<Int, Horse>){
        self.lenth = lenth
        self.horseDic = horseDic
        self.level = level
        self.raceProgress = Array(repeating: 0, count: self.numOfHorse)
    }
    /**
     - Parameter index: 말이 달리는 경주로 번호
     */
    func horseIsGoal(index i: Int) -> Bool{
        let rank = self.rank.firstIndex(of: i + 1)
        if rank != nil {
            return true
        }
        return false
    }
    /**
     경주에 참여한 모든 말이 골인해 rank배열이 다 찼다면 true, 경주중이면 false를 반환합니다.
     */
    func isEnd() -> Bool{
        if rank.count == raceProgress.count {
            return true
        }
        return false
    }
    /**
     해당 인덱스의 말이 달리는 것을 구현합니다
     - Parameters:
        - index: 말의 경주로 번호
        - run: 말이 달릴 칸수
     */
    func runHorse(index i: Int, run: Int) -> Bool{
        raceProgress[i] += run
        if( raceProgress[i] >= lenth) {
            raceProgress[i] = lenth
            rank.append(i + 1)
            return true
        }
        return false
    }
    /**
     말의 얼마나 달렸는지를 출력합니다. 꽉 찬 사각형이 달린 부분, 빈 박스가 남은 구간입니다.
     - Parameter index: 말의 경주로 번호입니다.
     */
    func printHores(index i: Int){
        print("[\(i + 1)번 레인]", terminator: "")
        var count = raceProgress[i]
        while(count > 0){
            print("■", terminator: "")
            count -= 1
        }
        count = lenth - raceProgress[i]
        while(count > 0){
            print("□", terminator: "")
            count -= 1
        }
        if horseIsGoal(index: i) {
            print("[\(rank.firstIndex(of: i + 1)! + 1)]등", terminator: "")
        }
        print()
        
    }
    /**
     printHorse를 총 말의 수만큼 출력해 전체 레이스 상황을 출력합니다.
     */
    func printAll(){
        print("-------------------------------------------")
        for i in 0..<raceProgress.count {
            printHores(index: i)
        }
        print("-------------------------------------------")
    }
    
    func raceEne() -> Int{
        var userRank = 8
        var reward = 0
        for i in 0...2 {
            var index: Int = rank[i] - 1
            if horseDic[index]!.name == user.horse!.name {
                userRank = i
            }
        }
        user.participation += 1
        switch userRank {
        case 0:
            print("축하합니다! 경주에서 승리했습니다.")
            user.win += 1
            return 0
        case 1:
            print("아쉽게 2등을 하였습니다.")
            return 1
        case 2:
            print("3등으로 들어왔습니다.")
            return 2
        default:
            print("당신은 아쉽게 입상에 실패했습니다.")
            return 3
        }
    }
    
}
/**
 Race 인스턴스를 생성해 말의 수, 경기장의 길이만큼 스레드들을 작동시킵니다.
 - Parameters:
    - numOfHorse: 달릴 말들의 수
    - lenth: 경기장 길이
    - horseDic: index-Horse 쌍으로 구성된 딕셔너리 타입
 */
func raceStart(level: Int, lenth: Int, horseDic: Dictionary<Int, Horse>){
    let race: Race = Race(level: level, lenth: lenth, horseDic: horseDic)
    let runLoop = CFRunLoopGetCurrent()
    
    let raceGroup = DispatchGroup.init()
    let raceQueue = DispatchQueue(label: "raceQueue", attributes: .concurrent)
    
    let displayQueue = displayRace(race, runLoop!, level)
    raceQueue.async(group: raceGroup, execute: displayQueue)
    
    for i in 0..<race.numOfHorse{
        let horseQueue = setHorse(horseNum: i, race)
        raceQueue.async(group: raceGroup, execute: horseQueue)
    }
    CFRunLoopRun()
}
/**
 경주상황을 출력해주는 DIspatchWorkItem 인스턴스를 반환합니다.
 가장 마지막에 종료되는 스레드로,  동작을 완료한 후 CFrunLoop을 종료시킵니다.
 - Parameters:
    - race: Race의 인스턴스입니다.
    - runLoop: 스레드들을 작동시키는 CFRunLoop의 인스턴스입니다.
 */
func displayRace(_ race: Race, _ runLoop: CFRunLoop, _ level: Int) -> DispatchWorkItem{
    var price = 0
    let displayRace = DispatchWorkItem{
        while !race.isEnd() {
            race.printAll()
            usleep(500000)
        }
        race.printAll()
        printRank(race)
        
        switch race.raceEne() {
        case 0 :
            price = 500
        case 1 :
            price = 200
        case 2 :
            price = 100
        default :
            price = 0
        }
        
        switch level {
        case 1 :
            price *= 1
        case 2 :
            price *= 2
        case 3 :
            price *= 3
        default :
            price *= 1
        }
        
        CFRunLoopStop(runLoop)
    }
    return displayRace
}

/**
 순위별로 말을 출력합니다.
 */
func printRank(_ race : Race){
    print("------------[순위]--------------")
    var count = 1
    for i in race.rank {
        print("\(count)등 : \(race.horseDic[i - 1]!.name)")
        count += 1
    }
    print("-------------------------------")
}

/**
 말들이 달리는것을 구현한 DIspatchWorkItem의 인스턴스를 반환합니다.
 - Parameters:
    - horseNum: 경주로 번호입니다.
    - race: Race의 인스턴스입니다.
 */
func setHorse(horseNum i:Int, _ race: Race) -> DispatchWorkItem{
    let horse = race.horseDic[i]
    let runHorse = DispatchWorkItem{
        while(true){
            var s: Int = Int.random(in: 1...horse!.runMax)
            if race.runHorse(index: i, run: s) {
                break
            }
            s = Int.random(in: 1000000...horse!.sleepMax)
            usleep( UInt32(s) )
        }
    }
    return runHorse
}

