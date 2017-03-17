//
//  AppsListVViewController.swift
//  MyStore
//
//  Created by Developer on 13/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class AppsListVViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBAction func GoBack(_ sender: Any) {
        if let navController = self.navigationController {
           
            
            var stack = navController.viewControllers
            stack.remove(at: stack.count - 1)       // remove current VC
           
            navController.setViewControllers(stack, animated: true) // boom!
        }
    }

    @IBOutlet weak var tableApps: UITableView!
     weak var listApps:NSArray!
    var categoryName:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        tableApps.estimatedRowHeight = 250

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listApps.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! CellApp
        
        let dict = (listApps.object(at: indexPath.row) as! NSDictionary).value(forKey: "data") as! NSDictionary
         
        let remoteImageUrlString = dict.value(forKey: "icon_img") as! String
        var name = dict.value(forKey: "title") as! String
        name = name.replacingOccurrences(of: "/r", with: "")
        name = name.replacingOccurrences(of: "/", with: "")
        let imageUrl = NSURL(string:remoteImageUrlString)
        myCell.lblTitleApp.text = name
        
        myCell.imgApp.sd_setImage(with: imageUrl as URL?, placeholderImage: UIImage(named: "cell_icon"), options: []) { (image, error, imageCacheType, imageUrl) in
            print("Image with url \(imageUrl?.absoluteString) is loaded")
        }
        
        
        
        return myCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true);
       
        let dict = (listApps.object(at: indexPath.row) as! NSDictionary).value(forKey: "data") as! NSDictionary
        let detailsVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcDetails") as! DetaillsViewController
        detailsVC.dictApp = dict;
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
       
    }
    
    

    

}
