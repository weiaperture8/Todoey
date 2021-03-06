//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Wei Ho on 2019/2/12.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import UIKit
// import CoreData
import RealmSwift
//import SwipeCellKit


class CategoryViewController: SwipeTableViewController{
    
    let realm = try! Realm() // No need to throw error as already throw in Appdelegate
    
    var categoryArray : Results<Category>?
    
    //var categoryArray = [Category]() -- coredata
    
    // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext   -- CoreData

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        print("View Did Load")
        loadCategory()
        tableView.reloadData()
        tableView.rowHeight = 80.0
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1  // if categoryArray is not nil then return cateogry Array, else if it is nil then return 1
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Loading Table View")
        
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        //cell.delegate = self
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet" // if categoryArray is not nil then return categoryArray else return message "No Categories Added Yet"
        
        //cell.textLabel?.text = categoryArray[indexPath.row].name    -- CoreData
        
        return cell
        
    }
    
    
    

    //MARK: - Data manipulation method
    
    
    func saveCategory(category: Category){
        
        do{
        // try context.save()       -- CoreData
            
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error Saving Category: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadCategory(){
        
        
        categoryArray = realm.objects(Category.self) // -- Realm
        
/*        let fetchrequest : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do{
//        categoryArray = try context.fetch(fetchrequest)
//
//        print("fetch Success")
//        }catch{
//            print("Error fetching category data: \(error)")
//        }
----- from coredata */
    }
    
    
    //Delete Method -- Inherited from Superclass
    
    override func updateDB(at indexPath: IndexPath) {
        
        
        
                    if let categoryForDeletion = self.categoryArray?[indexPath.row]{
                        do{
                            try self.realm.write {
                                self.realm.delete(categoryForDeletion)
                            }
                        }catch{
        
                            print("Error deleting cell: \(error)")
                        }
        
                        //tableView.reloadData()
                    }
        
    }
    
    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "Add Your Faviourite Category Here", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //let newCategory = Category(context: self.context)      -- CoreData
            let newCategory = Category()
            newCategory.name = textfield.text!
            //self.categoryArray.append(newCategory) -- for Coredata, Realm don't need to append as it automatic update
            self.saveCategory(category: newCategory)
            //self.saveCategory()

        }
        
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Category"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

    // MARK: - Table view delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: UITableView.self)
        
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            //destinVC.selectedCategory = categoryArray[indexPath.row] -- CoreData
            destinVC.selectedCategory = categoryArray?[indexPath.row] //savely unwrap fro Realm
            
            print("Segue Success")
        }
    }
        /*
 context.delete(categoryArray[indexPath.row])
        categoryArray.remove(at: indexPath.row)
        saveCategory()
        */

    
    
}


//extension CategoryViewController: SwipeTableViewCellDelegate {
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//
//
//        guard orientation == .right else {return nil}
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {action, indexPath in
//
//            if let categoryForDeletion = self.categoryArray?[indexPath.row]{
//                do{
//                    try self.realm.write {
//                        self.realm.delete(categoryForDeletion)
//                        }
//                }catch{
//
//                    print("Error deleting cell: \(error)")
//                }
//
//                //tableView.reloadData()
//            }
//
//            print("item deleted")
//
//
//        }
//
//        deleteAction.image = UIImage(named: "delete")
//        return [deleteAction]
//    }
//
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
//
//}
