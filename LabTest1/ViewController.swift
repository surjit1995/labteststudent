//
//  ViewController.swift
//  LabTest1
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var studentinfo: [Student] = []
    weak var delegate : ViewController?
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Student Information"
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "Cell")
    }
    
  

    @IBAction func AddButton(_ sender: Any) {  // go to edit view controller where vc is declared
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditViewController") as? EditViewController
         vc!.s = "Helllo"
        
         self.navigationController?.pushViewController(vc!, animated: true)

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()  // function to show the data
        tableView.reloadData()
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
    

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return studentinfo.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath) as! Cell1
            
            // data formatter to print th date in particular format
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            
            let value = studentinfo[indexPath.row]
            
            // print details of student in the given format
            //cell.textLabel!.text = value.name! + ", " + String(value.tuition) + ", " + String(value.age) + ", " + dateFormatter.string(from: value.date!)
            
            cell.label1.text = value.name!
            cell.label2.text = String(value.tuition)
            cell.label3.text = String(value.age)
            cell.label4.text = dateFormatter.string(from: value.date!)
            
            
            cell.backgroundColor = UIColor.systemTeal
            tableView.separatorColor = UIColor.black
            

            
            return cell }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let person = studentinfo[indexPath.row]
            context.delete(person)
            
            do {
                try context.save()
                
            }
            catch let error as NSError {
                print(error)
            }
            
            showData()
            tableView.reloadData()
        }
        
    }
    
    //when click on the given cell move to the next controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let s = studentinfo[indexPath.row]
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateViewController") as? UpdateViewController {
        
            print(indexPath.row)
            viewController.surjit = studentinfo[indexPath.row].name!
            viewController.a = Int(studentinfo[indexPath.row].age)
            viewController.t = studentinfo[indexPath.row].tuition
            viewController.studentinfo = studentinfo
            viewController.index = (indexPath.row)

             //viewController.surjit = studentinfo[indexPath.row].date!
            
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        // increase the size of row
    }
    
    

}
