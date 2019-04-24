//
//  LocalDataController.swift
//  swiftTest
//
//  Created by LiuJianning on 2019/4/22.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

import SQLite

class LocalDataController: baseViewController {

    private var DBNAME = "db3"
     private var TableKeyDict = ["users":["a", "j"], "users15":["name", "status", "age"]] //表的键值
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.addTopTitle(title: "数据本地化-sqlite.swift")
        self.addBackButton()
        self.crestTb()
    }
    
    func crestTb() {
        let arr = ["增", "删", "改", "查", "加表字段", "判断表是否存在"]
        for i in 0...arr.count-1 {
            let button = UIButton.init(frame: CGRect(x: 0, y: 100+40*i, width: 100, height: 30), bColor: UIColor.lightGray, tag: 100+i)
            button.setTitle(arr[i], for: .normal)
            self.view.addSubview(button)
            button.addTarget(self, action: #selector(buttonActionq(button:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonActionq(button:UIButton){
        switch button.tag {
        case 100:
            //增
            //在库名为 dd2 的里面的 users15 表增加一条数据, 如果没有这个表,则会自动建立一张表后再增加一条数据
            self.addData(dbName:DBNAME, tableName: "users15", model: "hh")
            break
        case 101:
            //删
            break
        case 102:
            //改
            break
        case 103:
            //查
            break
        case 104:
            //加表字段
            self.addNewField(dbName:DBNAME, tableName: "users15", newFieldArr: ["a", "b", "c"])
            break
        case 105:
            //判断表是否存在
            if self.isTable(dbName: DBNAME, tableName: "users15") == true {
                print("存在")
            }else{
                print("不存在")
            }
            break
        default:
            break
        }
    }
    
    // MARK: ===== 根据库名创建数据库
    func creatMyDB(dbName:String) -> Connection {
        //1.指定库的位置
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        print("库的位置为-> \(path)")
        //2.建库
        let targetDB = try! Connection("\(path)/\(dbName).sqlite3")
        //3.设置连接时间
        targetDB.busyTimeout = 5.0
        return targetDB
    }

    //MARK:给某张表新增字段
    func addNewField(dbName:String, tableName:String, newFieldArr:[String]) {
        let targetDB =  self.creatMyDB(dbName: dbName)
        let targetTable = Table(tableName)
        for i in 0...newFieldArr.count-1 {
            do {
                try targetDB.run(targetTable.addColumn(Expression<String?>(newFieldArr[i])))
                print("新增表字段   \(newFieldArr[i])   成功")
            } catch  {
                print("新增表字段   \(newFieldArr[i])   失败 -> \(error)")
            }
        }
    }
    
    //MARK:=====根据表名创建数据表
    func creatMyTable(dbName:String, tableName:String) -> Table {
        let targetDB =  self.creatMyDB(dbName: dbName)
        let targetTable = Table(tableName)
        //temporary:是否是临时表
        //ifNotExists:是否不存在的情况才会创建，记得设置为true
        //withoutRowid:是否自动创建自增的rowid
        try! targetDB.run(targetTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
            for i in 0...TableKeyDict[tableName]!.count-1 {
                let sqlite_key = Expression<String?>(TableKeyDict[tableName]![i])
                t.column(sqlite_key)
            }
        })
        )
        return targetTable
    }
    
    /**
     判断指定库里面的某张表是否存在
     */
    func isTable(dbName:String, tableName:String) -> Bool {
        do {
            let targetDB = self.creatMyDB(dbName: dbName)
            let targetTable = Table(tableName)
            let email = Expression<String>("email")//该行需要针对具体业务调整
            let name = Expression<String>("email")//该行需要针对具体业务调整
            let tableCount = try targetDB.scalar(targetTable.filter(email == "" && name == "").count)//该行需要针对具体业务调整
            return tableCount == 1
        } catch {
            return false
        }
    }
    
    /**
        增
     */
    func addData(dbName:String, tableName: String,  model:String) {
        let targetDB =  self.creatMyDB(dbName: dbName)
        let targetTable = self.creatMyTable(dbName:dbName, tableName: tableName)
        //键值可以不写全,但必须写对!
        let insert = targetTable.insert(Expression<String>("name") <- model, Expression<String>("status") <- model)//该行需要针对具体业务调整
        if let rowId = try? targetDB.run(insert) {
            print("插入成功：\(rowId )")
        } else {
            print("插入失败")
        }
    }
    
    
    
    
    
    
    
}
