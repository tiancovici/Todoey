//
//  ViewController.swift
//  Todoey
//
//  Created by Tom Iancovici on 12/25/18.
//  Copyright © 2018 Tom Iancovici. All rights reserved.
//

import UIKit

func print(_ type: String,_ message: String) {
    print("[\(type)]: \(message)")
}
func printd(_ message: String) {
    print("myLog", message)
}
class TodoListViewController: UITableViewController {

    var itemArray : [Item] = [
        Item("Find Mike"),
        Item("Buy Eggos"),
        Item("Destroy Demogorgon")
    ]
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        let item = itemArray[indexPath.row]
        item.done.toggle()
        saveItems()
        
        tableView.cellForRow(at: indexPath)?.accessoryType = item.done ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
    }
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What willhappen onex the user clicks the Add Item buton
            let newItem = Item(textField.text!)
            self.itemArray.append(newItem)
            self.saveItems()

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated:true, completion: nil)
    }
    //MARK - Model Manpipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
}

