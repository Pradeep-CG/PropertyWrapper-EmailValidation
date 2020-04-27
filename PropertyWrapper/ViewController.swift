//
//  ViewController.swift
//  PropertyWrapper
//
//  Created by Pradeep on 27/04/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

extension String{
    
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,64}"
       let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
}

@propertyWrapper
struct EmailPropertyWrapper{
    
    private var _value :String
    var wrappedValue :String{
        
        get{
            return self.isValidEmail(email: _value) ? _value: String()
        }
        set{
            _value = newValue
        }
    }
    init(emailValue: String) {
        _value = emailValue
    }
    private func isValidEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,64}"
       let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: email)
    }
    
}
struct User{
    
    var name: String
    @EmailPropertyWrapper var email: String
    
    func validate() -> Bool {
        
        if name.isEmpty || email.isEmpty {
            debugPrint("name and email is required")
            return false
        }
//        if email.isValidEmail() == false {
//            debugPrint("email is not valid, Please enter valid email")
//            return true
//        }
        return true
    }
    func registerUser() {
        
        if validate() {
            
            // saving user records code
            debugPrint("User data saved")
        }
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let user = User(name: "pradeep", email: EmailPropertyWrapper(emailValue: "prdeep@gmail.com"))
        print(user.validate())
    }


}

