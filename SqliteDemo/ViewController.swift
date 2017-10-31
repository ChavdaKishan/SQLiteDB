//
//  ViewController.swift
//  SqliteDemo
//
//  Created by iFlame on 10/24/17.
//  Copyright © 2017 iflame. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var TxtID: UITextField!
    @IBOutlet weak var TxtNM: UITextField!
    @IBOutlet weak var TxtADD: UITextField!
    @IBOutlet weak var TxtSUB: UITextField!
    @IBOutlet weak var TxtCITY: UITextField!
    
    override func loadView()
    {
        super.loadView()
        print("loadView")
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewDidLoad")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBTN(_ sender: Any)
    {
        do
        {
            let dbURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("studentInfo.db")
            
            let database = FMDatabase(url: dbURL)
 
            guard database.open() else
            {
                print("not opening database")
                return;
            }
            
            try database.executeUpdate("insert into studentInformations(name,address,subjects,class) values(?,?,?,?)", values: [TxtNM.text!,TxtADD.text!,TxtSUB.text!,TxtCITY.text!])
            
            database.close()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func ListBTN(_ sender: Any)
    {
        let list = storyboard?.instantiateViewController(withIdentifier: "StudentsListViewController") as! StudentsListViewController
        self.navigationController?.pushViewController(list, animated: true)
    }
}
