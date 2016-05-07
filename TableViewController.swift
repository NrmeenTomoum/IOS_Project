//
//  TableViewController.swift
//  Movie_Demo
//
//  Created by Nrmeen Tomoum on 5/4/16.
//  Copyright © 2016 Nrmeen Tomoum. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController , UITextFieldDelegate ,UIPickerViewDelegate,UIPickerViewDataSource{
      var names :[String]=["Action", "Drama", "Sci-Fi","Drama", "Thriller"]
    var picker = UIPickerView()
    var toolBar: UIToolbar!
    var myDelegat : Mydelegat?
    @IBOutlet weak var imageText: UITextField!
    @IBOutlet weak var titleImage: UITextField!
    @IBOutlet weak var ratingText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var genre: UITextField!
    
    override func viewDidLoad() {
        picker.delegate = self
        picker.dataSource = self
        genre.inputView = picker
        var toolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.bounds.size.width, 44))
        
        var item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                   target: self, action: "doneAction")
        
        toolbar.setItems([item], animated: true)
        self.genre.inputAccessoryView = toolbar
        self.toolBar = toolbar
         super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

func doneAction() {
    genre.resignFirstResponder()
    print("done!")
}


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    @IBAction func addMovieAction(sender: AnyObject) {
        //        let movie : Movie = Movie.init(title: titleImage.text, image: imageText.text, rating: Float(ratingText.text!), releaseYear: Int(yearText.text!), genre: [genre.text!])
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let mangedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Movies", inManagedObjectContext: mangedContext)
        
        let movie = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:mangedContext)
        print("titleImage.text \(titleImage.text!)")
        movie.setValue(titleImage.text!, forKey: "title")
        movie.setValue(imageText.text!, forKey: "image")
        movie.setValue(Float(ratingText.text!), forKey: "rating")
        movie.setValue(Int(yearText.text!), forKey: "releaseYear")
        
        //  var error :NSError?
        do{
            try mangedContext.save()
        }
        catch
        {
            print("No Insertion done ")
        }
        
        //hna 3yz 7aga mn nw3 NSManagedObjectContext
        ///  let mangeMovie = movie as! NSManagedObject
        myDelegat?.addMovieDelegate(movie)
        self.navigationController?.popViewControllerAnimated(true)
        
        
        // hna h3ml insert fe db save movie  *************************************************insert to DB
    }
    
    
    //    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row]
        
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genre.text = names[row]
    }
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
