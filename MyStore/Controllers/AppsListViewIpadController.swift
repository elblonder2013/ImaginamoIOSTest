//
//  AppsListViewIpadController.swift
//  MyStore
//
//  Created by Developer on 16/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MyCell"

class AppsListViewIpadController: UICollectionViewController {

    @IBAction func GoBack(_ sender: Any) {
        if let navController = self.navigationController {
            
            
            var stack = navController.viewControllers
            stack.remove(at: stack.count - 1)       // remove current VC
            
            navController.setViewControllers(stack, animated: true) // boom!
        }
    }
    weak var listApps:NSArray!
    var categoryName:String!
    fileprivate let reuseIdentifier = "MyCell"
    fileprivate let itemsPerRow: CGFloat = 4
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

       

        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
extension AppsListViewIpadController {//data source
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return listApps.count;
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as!  CellAppsIPad
        let dict = (listApps.object(at: indexPath.row) as! NSDictionary).value(forKey: "data") as! NSDictionary
        
        let remoteImageUrlString = dict.value(forKey: "icon_img") as! String
        var name = dict.value(forKey: "title") as! String
        name = name.replacingOccurrences(of: "/r", with: "")
        name = name.replacingOccurrences(of: "/", with: "")
        let imageUrl = NSURL(string:remoteImageUrlString)
        cell.lblTitleApp.text = name
       
        
        cell.imgApp.sd_setImage(with: imageUrl as URL?, placeholderImage: UIImage(named: "cell_icon"), options: []) { (image, error, imageCacheType, imageUrl) in
            print("Image with url \(imageUrl?.absoluteString) is loaded")
        }
        
        return cell
    }
    
}
extension AppsListViewIpadController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let dict = (listApps.object(at: indexPath.row) as! NSDictionary).value(forKey: "data") as! NSDictionary
        let detailsVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcDetails") as! DetaillsViewController
        detailsVC.dictApp = dict;
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
        return false
    }
}

extension AppsListViewIpadController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

