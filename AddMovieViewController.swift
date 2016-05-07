//
//  AddMovieViewController.swift
//  Movie_Demo
//
//  Created by Nrmeen Tomoum on 4/30/16.
//  Copyright © 2016 Nrmeen Tomoum. All rights reserved.
//

import UIKit
import CoreData

class AddMovieViewController: UIViewController , UITextFieldDelegate {

    var myDelegat : Mydelegat?
    @IBOutlet weak var imageText: UITextField!
    @IBOutlet weak var titleImage: UITextField!
    @IBOutlet weak var ratingText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var genre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addMovieAction(sender: AnyObject) {
//        let movie : Movie = Movie.init(title: titleImage.text, image: imageText.text, rating: Float(ratingText.text!), releaseYear: Int(yearText.text!), genre: [genre.text!])
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let mangedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Movies", inManagedObjectContext: mangedContext)
        
        let movie = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:mangedContext)
        
        movie.setValue(titleImage.text, forKey: "title")
        movie.setValue(imageText.text, forKey: "image")
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
        myDelegat?.addMovieDelegate(movie)
        self.navigationController?.popViewControllerAnimated(true)
        
        
        // hna h3ml insert fe db save movie  *************************************************insert to DB
    }
    
    
  
}
