//
//  ViewController.swift
//  Todoey
//
//  Created by Wei Ho on 2019/1/22.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    let defaultKey = "ToDoListSaved"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.itemName = "Write a book"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.itemName = "Listen to Radio"
        itemArray.append(newItem2)
    
        
        let newItem3 = Item()
        newItem3.itemName = "Watch BBC"
        itemArray.append(newItem3)
        
        
        
        if let newItemArray = defaults.array(forKey: defaultKey) as? [Item]{
            itemArray = newItemArray
        }
        
    }


    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoeyCell")!
        cell.textLabel?.text = itemArray[indexPath.row].itemName
        
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
 

        
        return cell
        
    }
    
    //MARK - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let item = itemArray[indexPath.row]
        print(item)

        
        /*
        if item.done == false {
            item.done = true
        }else{
            item.done = false
        }
 */
 
        item.done = !item.done // = ! means if item.done is false(or true) then item.done is the opposite which is true
 
        tableView.reloadData()
        
        /*
        
         if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
 
        */
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add button on our UIAlert
            print("Success!")
            
            let newItem = Item()
            newItem.itemName = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: self.defaultKey)
            print(self.itemArray)
            self.tableView.reloadData()
        }
        
        
        
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create New Todoey Item"
        print(alertTextField.text)
        textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        

    }
    
    
}
