//
//  LocalDataController.swift
//  swiftTest
//
//  Created by LiuJianning on 2019/4/22.
//  Copyright © 2019 ljn. All rights reserved.
//

/**
 * 1.SQLite.swift开源项目已有近六千star,是swift语言中关于数据库操作star最多的框架 https://github.com/stephencelis/SQLite.swift
 * 2.SQLite.swift是对SQLite的强封装,纯swift接口，无需SQL语句。
 * 3.采用链式编程的写法，让数据库的管理变得优雅，可读性极强。
 * 4.本类列举了几项实用的使用方法,部分函数需要针对具体的业务做修改.
 * 5.在对数据库进行操作是要明确 哪个库里的哪张表.(一般会创建一个库多张表)
 * 6.配合Datum-Lite(App Store免费),查看数据.
 */

import UIKit

import SQLite

class LocalDataController: baseViewController {

    private var DBNAME = "db3"
    private var TableKeyDict = ["users":["a", "j"], "users15":["name", "status", "age"]] //统一管理表及其键值["表名1":["表名1对应的字段1", "表名1对应的字段2"], "表名2":[表名2对应的字段1, 表名2对应的字段2]]
    
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
            let button = UIButton.init(frame: CGRect(x: 0, y: 100+40*i, width: 200, height: 30), bColor: UIColor.lightGray, tag: 100+i)
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
            self.addData(dbName:DBNAME, tableName: "users15", model: "hm")//表名必须已经在 TableKeyDict 里面配置.
            break
        case 101:
            //删
            self.deleteData(dbName: DBNAME, tableName: "users15", model: "")
            break
        case 102:
            //改
            self.modifyData(dbName: DBNAME, tableName: "users15", model: "")
            break
        case 103:
            //查
            self.queryData(dbName: DBNAME, tableName: "users15", model: "")
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
        return targetDB //会自动校验库是否已经存在,不用担心重复建相同的库的问题
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
    
    //MARK:=====根据 库名+表名 创建数据表
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
        return targetTable //会自动校验表是否已经存在,不用担心重复建相同的表的问题
    }
    
    //MARK: ==== 判断指定库里面的某张表是否存在
    func isTable(dbName:String, tableName:String) -> Bool {
        do {
            let targetDB = self.creatMyDB(dbName: dbName)
            let targetTable = Table(tableName)
            let email = Expression<String>("name")//该行需要针对具体业务调整
            let name = Expression<String>("status")//该行需要针对具体业务调整
            let tableCount = try targetDB.scalar(targetTable.filter(email == "hh" && name == "hh").count)//该行需要针对具体业务调整
            return tableCount == 1
        } catch {
            print("判断失败->  \(error)")
            return false
        }
    }
    
    //MARK: ==== 增加一条数据
    func addData(dbName:String, tableName: String,  model:String) {
        let targetDB =  self.creatMyDB(dbName: dbName)
        let targetTable = self.creatMyTable(dbName:dbName, tableName: tableName)
        let insert = targetTable.insert(Expression<String>("name") <- model, Expression<String>("status") <- model)//1.该行需要针对具体业务调整;2.不需要给表里面存在的每个键都赋值,但只要赋值了,键值必须写正确.
        if let rowId = try? targetDB.run(insert) {
            print("插入成功：\(rowId )")
        } else {
            print("插入失败")
        }
    }
    
    //MARK: ==== 删除一条数据
    func deleteData(dbName:String, tableName: String,  model:String) {
        let targetDB =  self.creatMyDB(dbName: dbName)
        let targetTable = self.creatMyTable(dbName:dbName, tableName: tableName)
//        let deleteItem = targetTable.filter(Expression<String>("name") == "hm") //根据数据j指定删除
        let deleteItem = targetTable//删除整张表的内容,表还在.
        do {
            if try targetDB.run(deleteItem.delete()) > 0{
                print("删除成功")
            }else{
                print("删除失败,没有改条数据")
            }
        } catch  {
            print("删除失败-> \(error)")
        }
    }
    
    //MARK: ==== 修改 一条/多条 数据
    func modifyData(dbName:String, tableName: String,  model:String) {
        let targetDB =  self.creatMyDB(dbName: dbName)
        let targetTable = self.creatMyTable(dbName:dbName, tableName: tableName)
        //修改一个/多个参数
        let updateItem = targetTable.filter(Expression<String>("name") == "小吧" || Expression<String>("name") == "hm")
        do {
            if try targetDB.run(updateItem.update(Expression<String>("name") <- "拒绝", Expression<String>("name") <- "哈哈"))>0{
                print("修改成功")
            }else{
                print("修改失败,没有符合修改条件的行")
            }
        } catch {
            print("修改失败-> \(error)")
        }
    }
    
    //MARK: ==== 查询数据并组装为的定数据结构的数据
    func queryData(dbName:String, tableName: String,  model:String) {
        let targetDB =  self.creatMyDB(dbName: dbName)
        let targetTable = self.creatMyTable(dbName:dbName, tableName: tableName)
        
        var array = [Dictionary<String, String>].init()
        do {
            //条件查询
//            for item in try targetDB.prepare(targetTable.filter(Expression<String>("name") == "哈哈")) //根据特定条件查询
            for item in try targetDB.prepare(targetTable)//将整表拿出来
            {
                var dic = Dictionary<String, String>.init()
                dic.updateValue(item[Expression<String>("name")], forKey: "name")
                dic.updateValue(item[Expression<String>("status")], forKey: "status")
                array.append(dic)
            }
            print("组装好的数组-> \(array)")
        } catch  {
            print("查询失败-> \(error)")
        }

    }
    
    
    
    
    
}
