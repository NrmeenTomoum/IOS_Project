//
//  MyTable.swift
//  Movie_Demo
//
//  Created by Nrmeen Tomoum on 4/29/16.
//  Copyright © 2016 Nrmeen Tomoum. All rights reserved.
//

import UIKit
import CoreData

class MyTable: UITableViewController , Mydelegat {
    
    var firstTime : Bool = true
    var jsonOrCoreData : Bool = true
   
    var arrayJson: [Movie] = []
    var arrayCD: [NSManagedObject] = []
    override func viewDidLoad() {
        
        if Reachability.isConnectedToNetwork() == true {
            jsonOrCoreData = true
            
            
            firstTime  = false
            print("Internet connection OK")
            let url = NSURL (string: "http://api.androidhive.info/json/movies.json")
            
            let request = NSURLRequest(URL:  url!)
            
            let session = NSURLSession (configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            let task = session.dataTaskWithRequest(request) { (data, response, error) in
              //  var jsonn : Array<NSManagedObject>!
                do
                {
                    let  jsonn = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSArray
                    var counter :Int = jsonn.count
                    for i : Int in 1..<counter {
                        let dic = jsonn[i]
                        let title : String? = dic.objectForKey("title") as? String
                        let imageURL : String? = dic.objectForKey("image") as? String
                        let rating : Float? = dic.objectForKey("rating") as? Float
                        let releaseYear : Int? = dic.objectForKey("releaseYear") as? Int
                        let genre : [String]? = dic.objectForKey("genre") as? [String]
                        
                        let movie1: Movie = Movie(title: title, image: imageURL, rating:rating , releaseYear: releaseYear, genre: genre!)
                        self.arrayJson.append(movie1)
                        //****************************************Save in Core  DATA
                        
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        let mangedContext = appDelegate.managedObjectContext
                        
                        let entity = NSEntityDescription.entityForName("Movies", inManagedObjectContext: mangedContext)
                        
                        let movie = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:mangedContext)
                       // print("titleImage.text \(titleImage.text!)")
                        movie.setValue(movie1.title!, forKey: "title")
                        movie.setValue(movie1.image!, forKey: "image")
                        movie.setValue(movie1.rating!, forKey: "rating")
                        movie.setValue(Int(movie1.releaseYear!), forKey: "releaseYear")
                        
                        //  var error :NSError?
                        do{
                            try mangedContext.save()
                        }
                        catch
                        {
                            print("No Insertion done ")
                        }

                        
                        dispatch_async(dispatch_get_main_queue(), {
                            //   self.myLabel.text = title!
                            //      self.loader.stopAnimating()
                            self.tableView.reloadData()
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        })
                    }
                    
                } catch {
                    print("Error")
                }
                
            }
            task.resume()
            ///////////////////////hna mfroud 2zwd fe DB 23ml inser all movies fe DB Caching y3ny //////////////////////////////////////////
        }
            //        } else if (firstTime){
            //            print("Internet connection FAILED")
            //            let alert = UIAlertView(title: "No Internet Connection and no data stored ", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            //            alert.show()
            //        }
        else
        {
            
            jsonOrCoreData = false
            // hna 23ml fetching from DB*********************SelectFromDB**********************************
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let mangedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Movies")
            
            var error : NSError?
            do{
                let results = try mangedContext.executeFetchRequest(fetchRequest)
                arrayCD = results as! [NSManagedObject]
                
            }
            catch
            {
                print("Cann't do selection fro DB ")
            }
 
        
        }
        
    }
    
    // NSMAnged Object array
    func addMovieDelegate(movie: NSManagedObject) {
        arrayCD.append(movie)
        self.tableView.reloadData()
    }
    func addMovieDelegate(movie: Movie) {
        arrayJson.append(movie)
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jsonOrCoreData
        {
            return arrayJson.count
        }
        else{
            return arrayCD.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        cell =  tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if let cellOop = cell as? MyCell
        {
            if jsonOrCoreData
            {
                //return arrayJson.count
                let movie = arrayJson[indexPath.row]
                cellOop.titleLabel.text = movie.title
                cellOop.rateLabel.text = String(movie.rating!)
                cellOop.yearLabel.text = String(movie.releaseYear!)
                
                //   cellOop.myImage.image = UIImage.imageWithData(data)
                
                //  NSData * imageData = initWiithContentOFURL
                //UIImage imageWithData
                
                //   cellOop.myImage.image = UIImage(named:movie.image!)
                
                let url = NSURL(string: movie.image!)!
                
                // Download task:
                // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
                    // if responseData is not null...
                    if let data = responseData{
                        
                        // execute in UI thread
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            cellOop.myImage.image = UIImage(data: data)
                        })
                    }
                }
                
                // Run task
                task.resume()
                
            }
            else{
               // return arrayCD.count
                let movie = arrayCD[indexPath.row]
                cellOop.titleLabel.text = movie.valueForKey("title") as! String
                cellOop.titleLabel.text = movie.valueForKey("title") as! String
                
                var  rate  :Float  = movie.valueForKey("rating") as! Float
                cellOop.rateLabel.text = "\(rate)"
                
                var year : Int = movie.valueForKey("releaseYear") as! Int
                cellOop.yearLabel.text = "\(year)"
                
                
                let url = NSURL(string:movie.valueForKey("image") as! String)!
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
                    // if responseData is not null...
                    if let data = responseData{
                        
                        // execute in UI thread
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            cellOop.myImage.image = UIImage(data: data)
                        })
                    }
                }
                
                // Run task
                task.resume()
            }
           
           
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("next") as! MyNextView
        if jsonOrCoreData
        {
           // return arrayJson.count
             view.movieE = arrayJson[indexPath.row]
        }
        else{
           // return arrayCD.count
           //    view.movieE = arrayCD[indexPath.row]
        }
      
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            // delete here mn DB***********************************************deleteFromDB************************************
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let mangedContext = appDelegate.managedObjectContext
            if jsonOrCoreData
            {
//                //return arrayJson.count
//                mangedContext.deleteObject(arrayJson[indexPath.row] as NSManagedObject)
//                do{
//                    try mangedContext.save()
//                }
//                catch
//                {
//                    print("No Insertion done ")
//                }
//                
//                arrayJson.removeAtIndex(indexPath.row)
                

            }
            else{
               // return arrayCD.count
                mangedContext.deleteObject(arrayCD[indexPath.row] as NSManagedObject)
                do{
                    try mangedContext.save()
                }
                catch
                {
                    print("No Insertion done ")
                }
                
                arrayCD.removeAtIndex(indexPath.row)
                

                
            }
            
                       tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="addMovieSegue"
        {
            var view = segue.destinationViewController as! TableViewController
            view.myDelegat = self
        }
    }
    
}
