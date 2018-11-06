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
    var itemArray : [Item] = [Item]()
    
    let defaults = UserDefaults.standard
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        
        
        if let items  = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
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
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
 
    //MARK:- tabe lView delegate methods
    //ToDo: - 当前选中行
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //强制tableView再次调用它的dataSourceMethods
        tableView.reloadData()
        //正常状态下 选中tableView时选中的行 是灰色的 。
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert =  UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let leftAction =  UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            if let itemTitle = textField.text {
                let newItem : Item = Item()
                newItem.title = itemTitle
                self.itemArray.append(newItem)
                //TODO: - 存储数据到用户偏好设置: value 可以为任意类型的数据(字符串、字典。。。)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
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
