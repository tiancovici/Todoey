//
//  ViewController.swift
//  Todoey
//
//  Created by Tom Iancovici on 12/25/18.
//  Copyright © 2018 Tom Iancovici. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray  = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        let selected = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? true : false
        tableView.cellForRow(at: indexPath)?.accessoryType = selected ? .none : .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

