//
//  ViewController.swift
//  hedwig ver 0.1
//
//  Created by lavaspoon on 25/06/2019.
//  Copyright © 2019 lavaspoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiIdInput: UITextField!
    @IBOutlet weak var uiPasswordInput: UITextField!
    
    let id = "root"
    let password = "1234"
    
    var databasePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DB 연결
        let fileMgr = FileManager.default
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPath[0]
        databasePath = docsDir.appending("/contacts.db")
        
        if !fileMgr.fileExists(atPath: databasePath) {
            let contactDB = FMDatabase(path: databasePath)
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS MEMBER (ID TEXT PRIMARY KEY, PASSWORD TEXT, NAME TEXT, AGE INTEGER)"
                if !contactDB.executeStatements(sql_stmt) {
                    NSLog("SQL 오류")
                }
                contactDB.close()
            } else {
                NSLog("contactDB 열기 실패")
            }
        } else {
            NSLog("contactDB가 존재")
        }
        // DB 연결 종료
    }

    @IBAction func loginClicked(_ sender: Any) {
        
        let userId = uiIdInput.text
        let userPassword = uiPasswordInput.text
        
        let alert = UIAlertController(
            title: "알림창",
            message: "아이디: \(userId!), 비밀번호: \(userPassword!)",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default){
            (alert:UIAlertAction!) -> Void in
            
            if(userId == self.id) && (userPassword == self.password){
                NSLog("로그인 성공")
            }else{
                NSLog("로그인 실패")
            }
        }
        
        alert.addAction(okAction)
        present(alert,animated: true, completion: nil)
        
    }

}

