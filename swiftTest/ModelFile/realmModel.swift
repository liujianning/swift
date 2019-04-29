//
//  realmModel.swift
//  swiftTest
//
//  Created by LiuJianning on 2019/4/26.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit
import RealmSwift

class Book: Object {
    @objc dynamic var name = ""
    @objc dynamic var author = ""
    
    /// LinkingObjects 反向表示该对象的拥有者
    let owners = LinkingObjects(fromType: Student.self, property: "books")
}

class Student: Object {
    @objc dynamic var id = Date.init().getTimestamp

    @objc dynamic var name = ""
    @objc dynamic var age = 18
    @objc dynamic var weight = 156
    @objc dynamic var address = ""
    @objc dynamic var birthday : NSDate? = nil
    @objc dynamic var photo : NSData?  = nil
    @objc dynamic var sex = ""

    //重写 Object.primaryKey() 可以设置模型的主键。
    //声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性,不可重复。
    //一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。
    override static func primaryKey() -> String? {
        return "id"//这个主键ID比较坑,不能系统自增,只能自定义,在这里暂时用毫秒级的时间戳做主键
    }
    
    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
    
    //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
    //List 用来表示一对多的关系：一个 Student 中拥有多个 Book。
    let books = List<Book>()
}



class realmModel: NSObject {

    private class func getDB() -> Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB5.realm")
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
}


extension realmModel {
    
    // 增
    public class func insertStudent(by student : Student) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(student)
        }
    }

    // 批量增
    public class func insertMoreStudents(by students : [Student]) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(students)
        }
    }
    
    // 查找 输出全表
    public class func queryAllStudent() -> Results<Student> {
        let defaultRealm = self.getDB()
        return defaultRealm.objects(Student.self)
    }
    
    // 主键查询 输出指定主键ID对应的额 Student
    public class func queryDataWithPrimaryKey(primaryKey : Int) -> Student? {
        let defaultRealm = self.getDB()
        return defaultRealm.object(ofType: Student.self, forPrimaryKey: primaryKey)
    }

    //根据指定查询
    public class func queryDataWithCondition(_ condition: String) -> Results<Student> {
        let defaultRealm = self.getDB()
        let predicate = NSPredicate(format: condition)
        let results = defaultRealm.objects(Student.self)
        return  results.filter(predicate)
    }

    //升序/降序 排列(将符合结果的数据,根据主键ID(或其他值)进行升序/降序排列)
    public class func getStudentByUp(_ term: String, isUp:Bool) -> Results<Student> {
        if term.count > 0 {
            let defaultRealm = self.getDB()
            let predicate = NSPredicate(format: term)
            let results = defaultRealm.objects(Student.self).sorted(byKeyPath: "id", ascending: isUp)
            return  results.filter(predicate)
        }else{
            let defaultRealm = self.getDB()
            let results = defaultRealm.objects(Student.self).sorted(byKeyPath: "id", ascending: isUp)
            return  results
        }
    }
    
    
    // 根据主键更新 - 更新单个 Student
    public class func updateStudent(student : Student) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(student, update: true)
        }
    }
    
    // 根据主键更新- 更新多个Student
    public class func updateStudent(students : [Student]) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(students, update: true)
        }
    }
    
    // 全列更新(键值更新) 
    public class func updateDataWithWholeColumn(age : Int, name:String) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            let students = defaultRealm.objects(Student.self)
            students.setValue(age, forKey: "age")
            students.setValue(name, forKey: "name")
        }
    }
    
    //指定条件更新
    //例如:将表中name="张三"and age=17的数据的weight改为20;
    public class func updateDataWithCondition(student : Student)  {
        /// 有两种方案.方案一:找到符合条件数据对应的主键ID,然后根据主键ID进行更新,这种方案需要主键可定位;方案二:遍历整表,然后将符合条件的数进行据逐一更改.方案一是最优方案!
        //方案二:全表遍历更改
        let defaultRealm = self.getDB()
        let students = defaultRealm.objects(Student.self)
        for st in students {
            if st.name == "张三" && st.age == 17 {
                try! defaultRealm.write {
                    st.weight = 20
                }
            }
        }
    }
   
    //删除单个
    public class func deleteStudent(student : Student) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(student)
        }
    }
    
    //删除多个
    public class func deleteStudent(students : Results<Student>) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(students)//删除defaultRealm库里面指定表的所有数据
//            defaultRealm.deleteAll()//删除defaultRealm库里面所有表的所有数据
        }
    }
    
    //根据指定条件逐一删除
    //例:将权重是151的数据全部删除
    public class func deleteDataWithCondition(students : Results<Student>) {
        let defaultRealm = self.getDB()
        let stu = defaultRealm.objects(Student.self)
        for s in stu {
            if s.weight == 151 {
                try! defaultRealm.write {
                    defaultRealm.delete(s)
                }
            }
        }
    }

}
