//
//  Login.swift
//  find fIndDecimal
//
//  Created by Yoon on 2021/03/18.
//

import Foundation

/**1 : 로그인, 2: 회원가입, 3: 종료*/
func logInMainFlow() -> String{
    while(true){
        let selectedMenu = selectMenu()
        switch selectedMenu {
        case 1:
            print("[logInMainFlow] 1입력받음")
            let id = loginFlow()
            if(id == "end"){
                continue
            }
            return id
            
        case 2:
            print("[logInMainFlow] 2입력받음")
            signUpMainFlow()
            
        case 0:
            print("[logInMainFlow] 0입력받음")
            exit(0)
            
        default:
            print("[logInMainFlow] 잘못된 입력받음")
            continue
        }
    }

}
/**nil 검사 후 올바른 입력값이면 반환*/
func selectMenu()  -> Int{
    print("로그인은 1, 회원가입은 2, 종료는 0" )
    let input: String? = readLine()
    if let input = input {
        if let inputNum = Int(input) {
            return inputNum
        }
 }
    print("잘못된 입력입니다.")
    return 9
}

//해당 id에 알맞은 비밀번호면 true, 틀리면 무한루프, 0은 false 반환
func inputedPw() -> Bool{
    while(true){
        print("pw를 입력하세요 0 입력시 종료합니다.")
        let inputed = readLine()
        if let inputed = inputed {
            if inputed == "0" {
                return false
            }
            if inputed == "1q2w3e4r"{
                return true
            }
        } else {
            print("유효하지 않은 입력입니다.")
        }
    }
}
/**존재하는 id이면 id 반환, 0은 종료, 아니면 무한루프*/
func inputedId() -> String{
    while (true){
        print("id를 입력하세요 0 입력시 종료합니다.")
        let inputed = readLine()
        if let inputed = inputed {
            if inputed == "0" {
                return "end"
            }
            if inputed == "dbswovlf2009"{
                return inputed
            }
        } else {
            print("유효하지 않은 입력입니다.")
        }
    }
}

/**DB연동시  큰 변화. 처음엔 흉내만. */
func loginFlow() -> String{
    let userId = inputedId()
    if userId == "end" || !inputedPw() {
        return "end"
    }
    return userId
}

