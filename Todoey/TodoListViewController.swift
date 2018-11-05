//
//  ViewController.swift
//  Todoey
//
//  Created by 吴飞 on 2018/11/5.
//  Copyright © 2018 吴飞. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //MARK:- 属性
    var itemArray = ["Find Mike","Buy Eggos","Destory Demogorgon"]
    
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
 
    //MARK:- tabe lView delegate methods
    //ToDo: - 当前选中行
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //正常状态下 选中tableView时选中的行 是灰色的 。
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert =  UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let leftAction =  UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            if let item = textField.text {
                self.itemArray.append(item)
                self.tableView.reloadData()
            }
        }
        
        let rightAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive) { (result) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            print("Cancel")
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
            textField = alertTextField
        }
        alert.addAction(leftAction)
        alert.addAction(rightAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}
