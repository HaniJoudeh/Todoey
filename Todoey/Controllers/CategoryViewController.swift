//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Hani Joudeh on 11/24/19.
//  Copyright © 2019 Hani Joudeh. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()

          
          loadCategories()
        
        tableView.rowHeight = 80.0
    }

    //Mark: - Add New Category


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
            var textField = UITextField()
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                
                let newCategory = Category()
                newCategory.name = textField.text!
                
//                self.categories.append(newCategory)
                self.save(category: newCategory)

            }
            alert.addTextField { (field) in
                
                textField = field
                textField.placeholder = "Add a New Category"
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
    
    //Mark: - TableView Datasource Methods
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories?.count ?? 1
        }
        

    
    
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = super.tableView(tableView, cellForRowAt: indexPath)

            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet"
            
//            cell.backgroundColor = UIColor.randomFlat
            return cell
    
    }
    
    //Mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)

            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //Mark: - Data Manipulation Methods
        
    func save(category: Category)  {
                do {
                    try realm.write {
                        realm.add(category)
                    }
                } catch {
                    print("Error Saving Category \(error)")
                }
                self.tableView.reloadData()
            }
            
            func loadCategories() {
                
                categories = realm.objects(Category.self)
            }

    //Mark: - Delete Data From Swipe
    
    override func updateModel(at indexpath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexpath.row]{
        do {
            try self.realm.write {
                self.realm.delete(categoryForDeletion)
        }
        } catch {
            print("Error Deleting categories, \(error)")
        }

        }
    }
}
