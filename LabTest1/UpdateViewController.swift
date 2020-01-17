//
//  UpdateViewController.swift
//  LabTest1
//
//  Created by MacStudent on 2020-01-15.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit
import CoreData
 class UpdateViewController : UIViewController{
    
  var studentinfo: [Student] = []
    var index = 0
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var name: UITextField!
       @IBOutlet weak var age: UITextField!
       @IBOutlet weak var tuition: UITextField!
       @IBOutlet weak var date: UITextField!
       

    var surjit = ""
    var a = 0
    var t = 0.0
    var d = Date()
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("Hello")
        showData()
        name.text = surjit
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
       // print(studentDetails[index])
        
       // name.text = studentinfo[index].name
        age.text = a.description
        tuition.text = t.description
        date.text = dateFormatter.string(from: studentinfo[index].date!)
        
     
    
        
        
    }
    
    @IBAction func update(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .short
               dateFormatter.timeStyle = .none
        print(studentinfo[index])
        updateRecord(stu: studentinfo[index], name: name.text!,age : Int32(age.text!)!, tuition : Double(tuition.text!)!, date : dateFormatter.date(from: date.text!)!)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showData(){
       
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do{
            studentinfo = try context.fetch(Student.fetchRequest())
        }
            //if error exists/catch it
        catch{
            print(error)
        }
    }
    
    func updateRecord(stu : Student, name:String, age:Int32, tuition:Double, date:Date){
         stu.name = name
         stu.age = age
         stu.tuition = tuition
         stu.date = date
         saveContext()
    }
    
    func saveContext () {
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
          
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                  // Replace this implementation with code to handle the error appropriately.
                  // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
}
