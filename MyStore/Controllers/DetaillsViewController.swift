//
//  DetaillsViewController.swift
//  MyStore
//
//  Created by Developer on 13/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class DetaillsViewController: UIViewController {

    @IBAction func GoBack(_ sender: Any) {
        if let navController = self.navigationController {
            
            
            var stack = navController.viewControllers
            stack.remove(at: stack.count - 1)       // remove current VC
            
            navController.setViewControllers(stack, animated: true) // boom!
        }
    }
    
    @IBOutlet weak var lblSubscribes: UILabel!
    @IBOutlet weak var scrollContainer: UIScrollView!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    weak var dictApp:NSDictionary!
    @IBOutlet weak var tvwDescripcion: UITextView!
    
    @IBOutlet weak var lblName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController?.navigationBar.isHidden = true
        //self.navigationController?.isNavigationBarHidden = true
        
        
        
        //vies
        imgIcon.layer.cornerRadius = 20
        lblSubscribes.clipsToBounds = true
        lblSubscribes.layer.cornerRadius = 4
        lblSubscribes.layer.borderWidth = 1;
        lblSubscribes.layer.borderColor = lblSubscribes.textColor.cgColor
        
        //loading data
        var title =  dictApp.value(forKey: "title") as! String
        title = title.replacingOccurrences(of: "/r", with: "")
        title = title.replacingOccurrences(of: "/", with: "")
        let headerImageURL = dictApp.value(forKey: "header_img")
        let iconURL = dictApp.value(forKey: "icon_img") as! String
        let descripcion = dictApp.value(forKey: "description") as! String
        let subscriber = dictApp.value(forKey: "subscribers") as! NSNumber
        
        self.title = title
        lblName.text = title
     
        tvwDescripcion.text =  descripcion.characters.count > 500 ? descripcion.substring(to: descripcion.index(descripcion.startIndex, offsetBy: 500))
 : descripcion
        tvwDescripcion.sizeToFit()
        
        lblSubscribes.text = String(format: " Subscribers:   %i   ", arguments: [subscriber.intValue])
        lblSubscribes.sizeToFit()
        
        
        imgHeader.sd_setImage(with: NSURL(string:headerImageURL as! String ) as URL?, placeholderImage: UIImage(named: "header_default"), options: []) { (image, error, imageCacheType, imageUrl) in
            print("Image with url \(imageUrl?.absoluteString) is loaded")
        }
        
        
       
        
        imgIcon.sd_setImage(with: NSURL(string:iconURL) as URL? as URL?, placeholderImage: UIImage(named: "AppIcon-1"), options: []) { (image, error, imageCacheType, imageUrl) in
            print("Image with url \(imageUrl?.absoluteString) is loaded")
        }
        
        //preparando elementos para animacions 
        imgHeader.frame.origin.y -= imgHeader.frame.size.height
        imgIcon.frame.origin.x -= imgIcon.frame.width
        imgHeader.alpha = 0
        imgIcon.alpha = 0
        let endIndex = scrollContainer.subviews.count-1
        for index in 3...endIndex {
            let view = scrollContainer.subviews[index] as UIView
            view.frame.origin.y += 60
            view.alpha = 0
            
        }
        
       
        
        scrollContainer.contentSize = CGSize(width: scrollContainer.frame.size.width, height: (tvwDescripcion.frame.maxY)+20)
        
        //i
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
       // let transition = CircularRevealTransition(layer: imgHeader.layer, center: imgHeader.center)
        //transition.start()
        //iniciando animaciones
        AnimandoItemsFromDown(index: 3)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
          self.imgHeader.frame.origin.y+=60
            self.imgHeader.alpha  = 1
       }, completion: { (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.imgIcon.frame.origin.x += self.imgIcon.frame.width
                self.imgIcon.alpha  = 1
            })
       })
        
    }
    func AnimandoItemsFromDown(index:Int)
    {
       
        
        let view = scrollContainer.subviews[index]
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            view.alpha = 1
            view.frame.origin.y-=60
            
            
        }, completion: { (finished: Bool) -> Void in
             if(index<self.scrollContainer.subviews.count-1)
             {
                let newIndex = index+1
                self.AnimandoItemsFromDown(index: newIndex)
            }
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   

}
