//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Wei Ho on 2019/3/3.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import Foundation
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //TableView Data Source
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
       
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        
        guard orientation == .right else {return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {action, indexPath in

            self.updateDB(at: indexPath)
            
//            if let categoryForDeletion = self.categoryArray?[indexPath.row]{
//                do{
//                    try self.realm.write {
//                        self.realm.delete(categoryForDeletion)
//                    }
//                }catch{
//
//                    print("Error deleting cell: \(error)")
//                }
//
//                //tableView.reloadData()
//            }
            
            print("item deleted")
            
            
        }
        
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    
    
    }
    
    func updateDB(at indexPath: IndexPath){
        //peform deletion in subclass
        
        print("update db function")
    }
}
