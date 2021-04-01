//
//  scheduleMain.swift
//  Darkhorse
//
//  Created by 윤재필 on 2021/03/24.
//

import Foundation
//점심훈련, 저녁훈련 두가지로 분류하고 훈련시 티켓으로 초급/고급 훈련 구분하기
//스케쥴 다 선택 후 말먹이도 선택하게끔 진행
func scheduleMainFlow(){
    while true {
        print("[스케쥴 관리]\n1. 스케쥴 진행\n2. 스케쥴 설정\n3. 급여 선택\n0. 메인 메뉴로")
        let input = Int(readLine()!)
        switch input {
        case 1:
            if scheduleProgress() == 0 {
                return
            }
        case 2:
            selectSchedul()
        case 3:
            selectFeed()
        case 0:
            return
        default:
            print("유효하지 않은 입력입니다.")
        }
    }
}
/**
 [등록된 스케쥴 print] 후 작업 시작
 1. 아침훈련 선택 -> 훈련종류 선택 -> 티켓 사용(초급/중급/일반) -> 등록되었습니다.
 2. 점심훈련 선택
 (해당 두개 메뉴는 등록/수정을 겸한다.)
 */
func selectSchedul(){
    while true {
        print("-----------현재 스케쥴-----------")
        user.schedule.printSchedule()
        print("등록/변경할 일정을 선택해주세요.\n [1]아침 훈련 [2]점심 훈련 [0]이전 메뉴로")
        let input = Int(readLine()!)
        switch input {
        case 1:
            inputTranining(input: input!)
        case 2:
            inputTranining(input: input!)
        case 0:
            return
        default:
            print("유효하지 않은 입력입니다.")
        }
        
    }
}

func scheduleProgress() -> Int{
    while true {
        user.schedule.printSchedule()
        print("[ 위의 일정을 실행하시겠습니까? [1]진행한다 [2]진행하지 않는다 ]")
        let inputed = Int(readLine()!)
        if inputed == 1{
            if dayCount > 0 {
                print("오늘은 훈련을 더이상 진행할 수 없습니다.")
            }
            for i in user.schedule.scheduleArr {
                trainingProgress(trainingNum: i)
            }
            dayCount += 1
            return 0
        } else if inputed == 2{
            return 1
        } else {
            print("유효하지 않은 입력입니다.")
            continue
        }
    }
}






