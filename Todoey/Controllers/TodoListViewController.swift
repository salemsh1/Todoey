//
//  ViewController.swift
//  Todoey
//
//  Created by Salem Shami on 3/3/19.
//  Copyright © 2019 Salem Shami. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Milk1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Milk2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Milk3"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {

            itemArray = items

        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
       
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary Operator ==>
        //Value = Condition  ? ValueIfTrue : ValueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//
//            cell.accessoryType = .checkmark
//
//        } else {
//
//            cell.accessoryType = .none
//
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        //print(itemArray[indexPath.row])
        
        itemArray [indexPath.row].done = !itemArray [indexPath.row].done
        
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        }
        
        tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            //What will happen once the user clicks the add Item button
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
           self.itemArray.append(newItem)
        
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
            self.tableView.reloadData()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField

        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}

