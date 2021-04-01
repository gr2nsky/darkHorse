import Foundation

//원래는 DBMS해야 하지만 임시로 유저정보 매핑
let userId:String = logInMainFlow()
let user: UserInfo = UserInfo(userId)
var dayCount: Int = 0
mainFlow(userInfo: user)
    
func mainFlow(userInfo :UserInfo){
    let userInfo: UserInfo = userInfo
    
    while(true){
        print("메인메뉴입니다. 선택하세요")
        print("1. 레이스 참가\n2. 훈련스케쥴 관리\n3. 내 정보\n4. 상점\n5. 하루 끝내기\n0. 종료")
        let input = Int(readLine()!)
            if movingSelect(input!) == 0 {
            break
        }
    }
}

func movingSelect(_ input: Int) -> Int{
    switch input {
    case 0:
        return 0
    case 1:
        raceMainFlow()
        return 1
    case 2:
        scheduleMainFlow()
        return 1
    case 3:
        user.printIntro()
        print("----------------------------")
        user.horse!.printMyHorseInfo()
        print("----------------------------")
        user.printInventory()
        print("----------------------------")
        print("계속 진행하려면 아무키나 눌러주세요.")
        readLine()
        return 1
    case 4:
        shopFlow()
        return 1
    case 5:
        fullRest()
        dayCount = 0
        user.days += 1
        return 1
    case nil:
        print("입력 오류. 다시 입력하세요")
        return 1
    default:
        print("입력 오류. 다시 입력하세요")
        return 1
    }
}

