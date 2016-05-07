//
//  MyNextView.swift
//  Movie_Demo
//
//  Created by Nrmeen Tomoum on 4/30/16.
//  Copyright © 2016 Nrmeen Tomoum. All rights reserved.
//

import UIKit
import CoreData

class MyNextView: UIViewController {
   
    var  movieE : Movie?
  
    @IBOutlet weak var imagev: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
   
    @IBOutlet weak var rate: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // if let movie = movieE
        guard let movie = movieE else
        {
            imagev.image = nil
            titleL.text = "dafult"
            rate.text = "dafult"
            year.text = "dafult"
            return
        }
        //imagev.image = UIImage(named: movie.image!)
        
        titleL.text = movie.title
        rate.text = "\(movie.rating!)"
        year.text = "\(movie.releaseYear!)"
        let url = NSURL(string: movie.image!)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
             self.imagev.image = UIImage(data: data)
                })
            }
        }
        
        // Run task
        task.resume()
      //  var genreList = movie.valueForKey("genre") as? [String]
                for i in 0..<movie.genre.count {
                let obLabel = UILabel()
                obLabel.text = movie.genre[i]
                    let frame: CGRect = CGRectMake(50, 400 + (CGFloat(i) * 20), 400, 50)
                    obLabel.frame = frame
                self.view.addSubview(obLabel)
                }
        
            //movie.valueForKey("title") as? String
       //// rate.text = String(movie.rating!)
        // year.text = String(movie.releaseYear!)
       // genre.text = movie.genre[0]
        
//        var genreList = movie.valueForKey("genre") as? [String]
//        for i in 0..<genreList!.count {
//        let obLabel = UILabel()
//        obLabel.text = genreList![i]
//            let frame: CGRect = CGRectMake(50, 400 + (CGFloat(i) * 20), 400, 50)
//            obLabel.frame = frame
//        self.view.addSubview(obLabel)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
