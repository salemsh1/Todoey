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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        loadItems ()
        
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
        
        saveItems()

        
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
    
           self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField

        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveItems () {
        
        let encoder = PropertyListEncoder ()
        
        do {
            
            let data = try encoder.encode(itemArray)
            
            try data.write (to: dataFilePath! )
            
        } catch {
            print("Error encoding item array, \(error)")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems () {
        
        if let data = try? Data (contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do {
            
            itemArray = try decoder.decode([Item].self, from: data)
                
            }catch{
                
                print ("Error, \(error)")
                
            }
        }
        
        
    }
    
}

