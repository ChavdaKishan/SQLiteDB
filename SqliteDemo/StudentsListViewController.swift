//
//  StudentsListViewController.swift
//  SqliteDemo
//
//  Created by iFlame on 10/25/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import UIKit

class StudentsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var studentsListTable: UITableView!
    var studentsData:Array = [Dictionary<String,String>]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do
        {
            let dbURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("studentInfo.db")
            
            let database = FMDatabase(url: dbURL)
            guard database.open() else
            {
                print("not opening database")
                return;
            }
            
            let rs = try database.executeQuery("Select * from studentInformations", values: nil)
            
            while rs.next()
            {
                if let name = rs.string(forColumn: "name"),let adress = rs.string(forColumn: "address"),let subject = rs.string(forColumn: "subjects"),let classname = rs.string(forColumn: "class")
                {
                    var studentInfoDic = Dictionary<String,String>()
                    print("\(name) \(adress) \(subject) \(classname)")
                    studentInfoDic["name"] = name
                    studentInfoDic["address"] = adress
                    studentInfoDic["subject"] = subject
                    studentInfoDic["class"] = classname
                    
                    studentsData.append(studentInfoDic)
                }
            }
            database.close()
        } catch
        {
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return studentsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let studentDic = studentsData[indexPath.row]
        cell.textLabel?.text = studentDic["name"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
