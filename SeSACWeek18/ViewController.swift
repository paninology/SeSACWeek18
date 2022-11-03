//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by yongseok lee on 2022/11/02.
//

import UIKit
import RxSwift

class ViewController: UIViewController { //프로필

    let api = APIService()
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let phone = Phone()
        print(phone[2])
        
//        api.signup()
//        api.login()

//        api.profile()
        print(UserDefaults.standard.string(forKey: "token"))
        viewModel.profile
            .subscribe { value in
                print(value.user.email)
                print(value.user.username)
            } onError: { error in
                print(error.localizedDescription)

            }
            .disposed(by: disposeBag)

        viewModel.getProfile()
        

        func checkCOW() {
            var test = "jack"
            address(&test) //inout 매개변수
            
            var test2 = test
            address(&test2)
            
            test2 = "sesac"
            address(&test)
        }
       
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }
    


}

