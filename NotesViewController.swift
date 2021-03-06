//
//  NotesViewController.swift
//  NoteTakingApp
//
//  Created by Fariha Binte Mahmud on 3/22/17.
//  Copyright © 2017 bcc. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController, AddNoteDelgate {

    var notesArray:[NoteModel] =  []
    
    func CancelTapped(_ controller: AddNoteTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func DoneTapped(_ controller: AddNoteTableViewController, newNote: NoteModel) {
        dismiss(animated: true, completion: nil)
        //self.tableView.reloadData()
        
        let rowsToInsertIndexPath = IndexPath(row: self.notesArray.count, section: 0)
        self.notesArray.append(newNote)
        self.tableView.insertRows(at: [rowsToInsertIndexPath], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(getDocumentDirectory())
//      Creating datasource
//        
//        let note1 = NoteModel(title: "Structture", message: "Structtures are like classes in swift")
//        
//        let note2 = NoteModel(title: "Class", message: "One more type in swift where we can use object oriented principles")
//        
//        let note3 = NoteModel(title: "Protocol", message: "One more very important type in swift")
//        
//        
//        notesArray.append(note1)
//        notesArray.append(note2)
//        notesArray.append(note3)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //cell object created
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell

        
        //label object searched in view hierarchy
     //  let titleLabel = cell.viewWithTag(111) as! UILabel// here we are downcasting the UILAbel because view with tag gives us UIView, but we need the UILabel
        
      //  let messageLabel = cell.viewWithTag(222) as! UILabel
       
        
        //set the data for both labels
        //get the model object for this row
        
        let noteModel = notesArray[indexPath.row]
        
        cell.title.text = noteModel.title
        cell.messageCell.text = noteModel.message
        
        // calling this method for hide and show c
        configureCheckmark(for: cell, withModel: noteModel)

        return cell
    }
 
    func configureCheckmark(for cell:NoteTableViewCell, withModel model:NoteModel) {
        
        if model.isDone {
            
            cell.checkMarkLabel.isHidden = false
            cell.title.textColor = UIColor.blue
            
        }
        else{
            cell.checkMarkLabel.isHidden = true
            cell.title.textColor = UIColor.brown
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let noteModelSelected = self.notesArray[indexPath.row]
        noteModelSelected.toggleDone()
        
        let cell = tableView.cellForRow(at: indexPath) as! NoteTableViewCell
        
        configureCheckmark(for: cell, withModel: noteModelSelected)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            self.notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        swap(&notesArray[fromIndexPath.row], &notesArray[to.row])
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoAdd" {
            // add something
            print("Show add note")
            
            let navigationController = segue.destination as! UINavigationController
            
            let addNoteController = navigationController.topViewController as! AddNoteTableViewController
            
            addNoteController.delegate = self
            
            
        } else if segue.identifier == "gotoDetails" {
            //showing the details view
            
            //get the cell object first
            // sender is cell object in this case
            let cell = sender as! UITableViewCell
            
            //get the indexpath for the cell selected
            let indexPath = tableView.indexPath(for: cell)
            
            //get position for the row selected
            let rowSelected = indexPath?.row
            print("row selected --> ", rowSelected!)
            
            let rowModelSelected = self.notesArray[rowSelected!]
            
            let detailsController = segue.destination as! DetailsTableViewController
            
            
            detailsController.notePassing = rowModelSelected
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    // MARK: - Archiving the data
    func getDocumentDirectory() -> URL{
        let paths  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func getFilePath() -> URL {
        return getDocumentDirectory().appendingPathComponent("Notes.plist")
        
    }
    
    
    
}
