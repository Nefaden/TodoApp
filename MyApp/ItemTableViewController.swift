//
//  ItemTableViewController.swift
//  MyApp
//
//  Created by Yann Durand on 24/09/2020.
//

import UIKit


class ItemTableViewController: UITableViewController {
    
    var items  = [Item]()
    
    func loadSampleItems() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleItems()
        navigationItem.leftBarButtonItem = editButtonItem
        // Load saved items
        if let savedItems = loadItems() {
          items += savedItems
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        // Configure the cell...
        let item = items[indexPath.row]
        cell.nameLabel.text = item.name
        return cell
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        let srcViewCon = sender.source as? ViewController
        guard let safeItem = srcViewCon?.item else {return}
        if srcViewCon != nil && safeItem.name != ""{
            // Add a new item
            let newIndexPath = IndexPath(row: items.count, section: 0)
            items.append(safeItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
        } else {
          // Add a new meal.
          let newIndexPath = NSIndexPath(row: items.count, section: 0)
          items.append(safeItem)
          tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
        }
        saveItems()
    }
    
    func saveItems() {
       let isSaved = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
       if !isSaved {
         print("Failed to save items...")
       }
    }
    
    func loadItems() -> [Item]? {
       return NSKeyedUnarchiver.unarchiveObject(
          withFile: Item.ArchiveURL.path) as? [Item]
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            items.remove(at: indexPath.row)
            saveItems()
            tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetail" {
        let detailVC = segue.destination as! ViewController
            
        // Get the cell that generated this segue.
        if let selectedCell = sender as? ItemTableViewCell {
          let indexPath = tableView.indexPath(for: selectedCell)!
          let selectedItem = items[indexPath.row]
          detailVC.item = selectedItem
         }
       }
      else if segue.identifier == "AddItem" {
        
       }
    }
     
    
}