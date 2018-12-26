//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Tom Iancovici on 12/26/18.
//  Copyright © 2018 Tom Iancovici. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    //1. Local Create array
    var categories : [Category] = []
    //2. Get Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //5. load entries
        loadCategories()
    }

    // MARK: - Table view data source



    
    //MARK: - TableView Datasource Methods
    //3. Return the Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    //3. and make count based on array list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    //MARKL - Add New Categories
    //4. Create a action on buton pressed, and save new entry
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categories.append(newCategory)
            self.saveCategories()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated:true, completion: nil)
    }
    //4b. Save entry
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //5. Load entries
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest())
    {
        do {
            categories = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        self.tableView.reloadData()
    }
}
