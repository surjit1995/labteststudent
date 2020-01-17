//
//  EditViewController.swift
//  LabTest1
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditViewController: UIViewController {
    
     var student: [NSManagedObject] = []
     var managedContext: NSManagedObjectContext!
    var s = ""
    
    @IBOutlet weak var studentnametextfield: UITextField!
    
    @IBOutlet weak var agetextfield: UITextField!
    
    @IBOutlet weak var termstartdatetextfield: UITextField!
    
    @IBOutlet weak var tuitionfeetextfield: UITextField!
    
    override func viewDidLoad()
    {
    super.viewDidLoad()
        print(s)
    }
    
    @IBAction func savebutton(_ sender: Any) {
        
        let nameToSave = studentnametextfield.text
        let ageToSave = agetextfield.text
        let tuitionToSave = tuitionfeetextfield.text
        let dateToSave = termstartdatetextfield.text
        
        if(nameToSave == ""  || ageToSave == "" || tuitionToSave == "" || dateToSave == "")
        {
            return
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        self.save(name: nameToSave!,age : Int32(ageToSave!)!, tuition : Double(tuitionToSave!)!, date : dateFormatter.date(from: dateToSave!)!)
       
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
    func save(name: String, age : Int32, tuition : Double, date : Date) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext

      let entity = NSEntityDescription.entity(forEntityName: "Student",
                                              in: managedContext)!

      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

      person.setValue(name, forKeyPath: "name")
         person.setValue(age, forKeyPath: "age")
         person.setValue(tuition, forKeyPath: "tuition")
         person.setValue(date, forKeyPath: "date")

      do {
        try managedContext.save()
        student.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.destination is ViewController
//    {
//       
//        let vc = segue.destination as? ViewController
//       
//       }
//       }
//    
}
