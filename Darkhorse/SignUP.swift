//
//  SignUP.swift
//  find fIndDecimal
//
//  Created by Yoon on 2021/03/18.
//

import Foundation

func signUpMainFlow(){
    if newIdInputed() {
        newPwInputed()
    }
}

func newPwInputed(){
    while(true){
        print("pw를 입력하세요 0 입력시 종료합니다.")
        let inputed = readLine()
        if let inputed = inputed {
            if inputed == "0" {
                print("[newPwInputed]종료를 눌렀음")
                break;
            }
            if inputed == "1q2w3e4r"{
                print("[newPwInputed]비밀번호 생성")
                break;
            }
        } else {
            print("유효하지 않은 입력입니다.")
        }
    }
}
/**존재하는 id이면 id 반환, 0은 종료, 아니면 무한루프*/
func newIdInputed() -> Bool{
    while (true){
        print("id를 입력하세요 0 입력시 종료합니다.")
        let inputed = readLine()
        if let inputed = inputed {
            if inputed == "0" {
                print("[newIdInputed]종료를 눌렀음")
                return false
            }
            if inputed == "dbswovlf2009"{
                print("[newIdInputed]유효한 아이디")
                return true
            }
        } else {
            print("유효하지 않은 입력입니다.")
        }
    }
}
