//
//  RealmController.swift
//  swiftTest
//
//  Created by LiuJianning on 2019/4/25.
//  Copyright © 2019 ljn. All rights reserved.
//



/**
 *0.Realm于2014 年7月发布，是一个跨平台的移动数据库引擎，专门为移动应用的数据持久化而生。其目的是要取代Core Data和SQLite
 *1.realm 目前是性能能最好的移动端数据库框架. https://realm.io/blog/introducing-realm/#fast
 *2.realm 自己的数据库存储引擎，可以高效且快速地完成数据库的构建操作.
 *3.支持iOS、Android和Mac三种平台,支持Objective-C、Swift和Java三种语言.
 *4.Realm相比使用CoreData和原生的SQLite来说速度更快更加高效，而且代码量更少.
 *5.Realm的彻底免费的,即使用于商业软件.
 *6.配合Realm Browser(App Store免费)使用,方便高效的查看调试数据.
 *7.中文文档 https://realm.io/cn/docs/swift/latest/d
 */
import UIKit

import RealmSwift

class RealmController: baseViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.addTopTitle(title: "realm的使用")
        self.addBackButton()
        self.testButtonView()
    }
    
    func testButtonView() {
        let actionArray = ["增加普通数据", "增加关联表数据", "批量增加学生数据", "查找数据", "通过主键查询","通过指定条件查询", "升序/降序排列", "根据主键更新-批量更新", "根据主键更新-单条更新", "整列更新", "指定条件更新", "删除单行数据", "删除所有数据", "删除指定数据"]
        for i in 0...actionArray.count-1 {
            let button = UIButton.init(frame: CGRect(x: 10, y: 100+40*i, width: Int(KScreenW-20), height: 30), bColor: UIColor.lightGray, normalImg: UIImage.init(), selectimg: UIImage.init(), tag: 100+i)
            button.setTitle(actionArray[i], for: .normal)
            self.view.addSubview(button)
            button.addTarget(self, action:#selector(buttonAction(button:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonAction(button:UIButton){
        switch button.tag {
        case 100:
            self.insertStudentData()
            break
        case 101:
            self.insertStudentWithBook()
            break
        case 102:
            self.insertMoreStudents()
            break
        case 103:
            self.queryData()
            break
        case 104:
            self.queryDataWithPrimaryKey()
            break
        case 105:
            self.queryDataWithCondition()
            break
        case 106:
            self.studentUp()
            break
        case 107:
            self.updateData_more()
            break
        case 108:
            self.updateData_one()
            break
        case 109:
            self.updateDataWithWholeColumn()
            break
        case 110:
            self.updateMine()
            break
        case 111:
            self.deleteOneData()
            break
        case 112:
            self.DeleteAllDatat()
            break
        case 113:
            self.DeleteDatatWithCondition()
            break
        default:
            break
        }
        
    }
    
    //MARK: ======增加
    ///==== 新增基础数据 Student
    func insertStudentData() {
        let stu1 = Student()
        stu1.name = "极客学伟_有头像_有书"
        stu1.weight = 120;
        stu1.age = 21
        realmModel.insertStudent(by: stu1)
    }
    
    ///==== 建立关联表数据 Student & Book
    func insertStudentWithBook() {
        let stu1 = Student()
        stu1.name = "极客学伟_有头像_有书"
        stu1.weight = 151;
        stu1.age = 26
        let bookDianfuzhe = Book(value: ["颠覆着: 周鸿祎自传","周鸿祎"])
        stu1.books.append(bookDianfuzhe);
        realmModel.insertStudent(by: stu1)
    }

    ///==== 批量增加学生数据
    func insertMoreStudents() {
        var stus = [Student]()
        
        for i in 100...200 {
            let stu = Student()
            stu.name = "极客学伟_\(i)"
            stu.weight = 151;
            stu.age = 26
            stu.id = Date.init().getTimestamp+Int64(i)
            let birthdayStr = "1993-06-10"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            stu.birthday = dateFormatter.date(from: birthdayStr)! as NSDate
            stus.append(stu)
            print(" ===========------\(Int64(i))")
        }
        print(" 开始插入------\(Date.init().getTimestamp)")
        realmModel.insertMoreStudents(by: stus)
        
        
    }
    
    //MARK: ======查询
    ///==== 查找数据
    func queryData() {
        let stus = realmModel.queryAllStudent()
        for stu in stus {
            print("全表输出姓名-> ", stu.name)
            if stu.books.count > 0 {
                for book in stu.books {
                    print("书名:",book.name, "作者:" ,book.author)
                }
            }
        }
    }

    ////==== 通过主键查询
    func queryDataWithPrimaryKey() {
            let student = realmModel.queryDataWithPrimaryKey(primaryKey: 110)
            if let studentL = student {
                print(studentL.name)
            }
    }
    
    ///==== 通过指定条件查询
    func  queryDataWithCondition()  {
        let students = realmModel.queryDataWithCondition("name = '极客学伟_110'")
        if students.count == 0 {
            print("未查询到任何数据")
            return
        }
        for student in students {
            print(student.name,student.weight,student)
        }
    }

    ////==== 查询结果n并排序,将name=极客学伟_110 的结果查询出来,并根据主键ID进行升序/降序排列
    func studentUp()  {
        let students = realmModel.getStudentByUp("name = '极客学伟_110'", isUp:true)
        print("结果:", students)
    }
    
    //MARK: ======更新
    ///==== 根据主键更新-批量更新
    func  updateData_more() {
        var stus = [Student]()
        for i in 100...144 {
            let stu = Student()
            stu.name = "哈哈😝\(i)"
            stu.weight = 148;
            stu.age = 27
            stu.id = Int64(i);
            stus.append(stu)
        }
        realmModel.updateStudent(students: stus)
    }
    
    ///==== 根据主键更新-单条更新
    func  updateData_one() {
        let stu = Student()
        stu.name = "嘿嘿👌😝"
        stu.weight = 148;
        stu.age = 27
        stu.id = 107;
        realmModel.updateStudent(student: stu)
    }
    
   ///==== 全列更新-将name改为"小狗",age改为"4"
    func  updateDataWithWholeColumn() {
        realmModel.updateDataWithWholeColumn(age: 4, name:"小狗")
    }
    
    ///==== 根据多条件联动更新(全表遍历更新/主键更新)
    func updateMine() {
        let stu = Student()
        realmModel.updateDataWithCondition(student: stu)
    }
    
    //MARK:======删除
    ///删除的本质:现查找出符合条件的数据行,再对数据行进行删除操作.
    ///==== 删除单个数据
    func deleteOneData() {
        ///删除主键ID为110 的数据行
        let stu = realmModel.queryDataWithPrimaryKey(primaryKey: 110)
        if stu != nil {
            realmModel.deleteStudent(student: stu!)
        }
    }
    
   ///==== 删除所有数据
    func DeleteAllDatat() {
        let stus = realmModel.queryAllStudent()
        realmModel.deleteStudent(students: stus)
    }
    
    ///==== 删除指定数据
    func DeleteDatatWithCondition() {
        let stus = realmModel.queryAllStudent()//占位用的,内部会重新赋值
        realmModel.deleteDataWithCondition(students: stus)
    }
    
    ///其他功能1.数据库升级2.数据库迁移3.默认数据生成,将本地json直接导入到库里面4.处理事务监听

}
