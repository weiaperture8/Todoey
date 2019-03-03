//
//  ViewController.swift
//  Todoey
//
//  Created by Wei Ho on 2019/1/22.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import UIKit
// import CoreData
import RealmSwift



class ToDoListViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var toDoItems : Results<Item>?
    

    
    // var itemArray = [Item]()   -- CoreData
    
    
    var selectedCategory : Category? {
        didSet{
            loadItemList()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //let appDelegate = UIApplication.shared.delgate as! AppDelegate
    
    //let defaults = UserDefaults.standard
    let defaultKey = "ToDoListSaved"

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70.0
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //loadItemList() //NSCoder Method of Loading Saved Data
        
        /*
        let newItem = Item()
        newItem.itemName = "Write a book"
        toDoItems.append(newItem)
        
        let newItem2 = Item()
        newItem2.itemName = "Listen to Radio"
        toDoItems.append(newItem2)
    
        
        let newItem3 = Item()
        newItem3.itemName = "Watch BBC"
        toDoItems.append(newItem3)
        */
        
        
        //searchBar.delegate = self
        // loadItemList() - loaded with var selectedCategory
        //tableView.reloadData()
        
        /*
         
         if let newItemArray = defaults.array(forKey: defaultKey) as? [Item]{
            itemArray = newItemArray
        }  //userdefaults method of save item data
         
         */
        
        
    }


    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = toDoItems?[indexPath.row]{
        
        cell.textLabel?.text = item.title
        
        //cell.accessoryType = item?.done .checkmark : .none
        
        //cell.textLabel?.text = itemArray[indexPath.row].itemName
            

        cell.accessoryType = item.done ? .checkmark : .none
        
        
            
        }else{
            cell.textLabel?.text = "No item added yet!"
        }
        
//        if toDoItems?[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
//        }else{
//            cell.textLabel?.text = "No Item Added Yet"
//        }
        return cell
        
        
    }
    
    
    
    //MARK - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        
        if let item = toDoItems?[indexPath.row]{
            
            do{
                try realm.write {
                //realm.delete(item)
                item.done = !item.done
                print("Ithem checked? \(item.done)")
                    
                }
            }catch{
                print("Error saving item done: \(error)")
            }
            
            print("row selected")
            
        }
       

        
        /*
        if item?.done == false {
            item?.done = true
        }else{
            item?.done = false
        }*/
 
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
       // item.done = !item.done // = ! means if item.done is false(or true) then item.done is the opposite which is true
        
        //saveItems()
 
        //tableView.reloadData()
        
        /*
        
         if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
 
        */
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd.HH.mm.ss"
        let getDate = dateFormatter.string(from: currentDate)

        
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add button on our UIAlert
            print("Success!")
            
            
           if let currentCateogry = self.selectedCategory{
            
            do{
                
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = getDate
                    print(newItem.dateCreated)
                    
                    
                    currentCateogry.items.append(newItem)
                }
                
            }catch{
                print("Error Writing to Realm: \(error)")
            }
            
            self.tableView.reloadData()
            
            }
            
            
            /*
            let newItem = Item()
            newItem.title = textField.text!
            self.selectedCategory?.items.append(newItem)
            
            //self.selectedCategory?.items.append(newItem)
            self.saveItems(items: newItem)
             
             // The above can not save Cateogry name in Realm
             
             
            */
            
            
            
    
            
            
//            let newItem = Item(context: self.context) // core data
//
//            // let newItem = Item()     ---> codable
//
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.originalCateogry = self.selectedCategory
//            //newItem.itemName = textField.text!
//
//            self.itemArray.append(newItem)
//            //self.defaults.set(self.itemArray, forKey: self.defaultKey)
            
            
            
            //self.saveItems(items: newItem)
            
            /*
            let encoder = PropertyListEncoder()
            do{
            let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            }catch{
                print("Error encoding tiem arrayk \(error)")
            } //need to conform to Encodable in item.swift
            
            print(self.itemArray)
            self.tableView.reloadData()
            */
        
        }
        
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create New Todoey Item"
        print(alertTextField.text)
        textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveItems(items: Item){
        
        do{
        try realm.write {
            realm.add(items)
        }
        }catch{
            print(error)
        }
        
        
       /* CoreData Save
        do{
            try context.save()
        }catch{
            print("Core Data Error Save \(error)")
        }
        
        tableView.reloadData()
        */
        
        /*  // Codable Save
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array \(error)")
        } //need to conform to Encodable in item.swift
        
        tableView.reloadData()
 
        */
        
        tableView.reloadData()
    }
    
    func loadItemList(){
        
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
        
        
        
    
//    func loadItemList(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
//
//        //let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let categoryPredicate = NSPredicate(format: "originalCateogry.name MATCHES %@", selectedCategory!.name!)
//
//        if let addtionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
//
////        let compundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
////
////        request.predicate = compundPredicate
//
//        do{
//
//        try itemArray = context.fetch(request)
//            }catch{
//
//                print("Error fetching data: \(error)")
//        }
//
//        tableView.reloadData()
//
//    }
    
// Codable method of fetching data
//        if let data = try? Data(contentsOf: dataFilePath!){
//        let decoder = PropertyListDecoder()
//            do{
//            itemArray = try decoder.decode([Item].self, from: data)
//            }catch{
//                print(error)
//            }
//        }
   
    }
    
    
    // Deleting ToDo Item
    
    override func updateDB(at indexPath: IndexPath) {
        if let items = toDoItems?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(items)
                }
            }catch{
                print("Error deleting items:\(error)")
            }
        }
    }
    
            
    
    
} //end of class

//MARK: - Search Bar Function

extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    
    tableView.reloadData()
        
        
        
        
//        -----------------------------------------------CoreData--------------------------------------------
//        let request : NSFetchRequest<Item> = Item.fetchRequest() //Fetch Data from Database
//
//        //let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        //predicate usually set to case and dicritic senstiive so need to make it insensitive by adding [cd]
//
//        //request.predicate = predicate
//
//        //let sortDescriptor = NSSortDescriptor (key: "title", ascending: true)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        //sort the result by "title" order and in alphabetical order
//
//        //request.sortDescriptors = [sortDescriptor]
//
//        loadItemList(with: request, predicate: predicate)
//
//        //loadItemList(with: request)
//
//    /*
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print("Error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
//
//    */
        
        
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItemList()

            DispatchQueue.main.async {
            searchBar.resignFirstResponder() // no longer to be selected as the 1st responder
            } //main = main thread

        }
  }
}
