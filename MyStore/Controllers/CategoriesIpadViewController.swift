//
//  CategoriesIpadViewController.swift
//  MyStore
//
//  Created by Developer on 16/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class CategoriesIpadViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    fileprivate let reuseIdentifier = "MyCell"
    fileprivate let itemsPerRow: CGFloat = 5
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var listApps:NSArray = NSArray()
    var startted:Bool = false
    
    @IBOutlet weak var viewOffline: UIView!
    var listCategories = [NSDictionary]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var LoaderImaginamos: ImaginamosLoader!
    @IBOutlet weak var loadingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        listCategories = [["name":"Salud","image":"salud.png"],["name":"Negocios","image":"negocio.png"],["name":"Comida","image":"comida.png"],["name":"Compras","image":"compras.png"],["name":"Finanzas","image":"finanzas.png"],["name":"Moda","image":"moda.png"],["name":"Booking","image":"booking.png"],["name":"Viajes","image":"viajes.png"],["name":"Música","image":"musica.png"],["name":"TV","image":"TV.png"],["name":"Noticias","image":"noticias.png"],["name":"Games","image":"games.png"],["name":"Documentos","image":"documentos.png"],["name":"Fotos","image":"fotos.png"],["name":"Videos","image":"videos.png"],["name":"Deportes","image":"deportes.png"]]
        listApps = Util.GetApps()
        collectionView.dataSource = self
        collectionView.delegate = self
       
        collectionView.reloadData()
        
        self.viewOffline.frame.origin.y = self.view.frame.size.height
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if(startted==false)
        {
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                
                self.LoaderImaginamos.alpha=1
                
                
            }, completion: { (finished: Bool) -> Void in
               
                self.LoaderImaginamos.InicarComponentes()
                self.LoadApps()
                self.startted = true
                
                
            })
           
            
        }
    }
    
    func LoadApps()
    {
        let sourceUrl = "https://www.reddit.com/reddits.json"
        let myUrl = NSURL(string: sourceUrl);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
               
                let alertController = UIAlertController(title: "My Store", message: "Ha ocurrido un error al cargar los datos.", preferredStyle: .alert)
                var okAction = UIAlertAction(title: "Reintentar", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    self.LoaderImaginamos.isHidden = false
                    self.LoadApps()
                }
               
                if(self.listApps.count>0)
                {
                    alertController.message = alertController.message?.appending(" Se cargaran los datos almacenados de forma offline.")
                    
                    okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.collectionView.reloadData()
                            self.LoaderImaginamos.DetenerAnimaciones()
                            self.LoaderImaginamos.superview?.superview?.removeFromSuperview()
                            self.navigationController?.setNavigationBarHidden(false, animated: true)
                            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                                
                                self.collectionView.frame.size.height = self.collectionView.frame.size.height-self.viewOffline.frame.size.height;
                                self.viewOffline.frame.origin.y-=self.viewOffline.frame.size.height
                            })
                        }
                    }
                    
                    
                }
                alertController.addAction(okAction)
                
                // Create the actions
                
                
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            do {
                
                if let convertedJsonIntoDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    let dictresponse = convertedJsonIntoDictionary.value(forKey: "data") as! NSDictionary
                    let result =  Util.SaveData(dictionary: dictresponse)
                    self.listApps = dictresponse.value(forKey: "children") as! NSArray
                    DispatchQueue.main.async() {
                        print("Llegaron los datos")
                       
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.collectionView.reloadData()
                            self.LoaderImaginamos.DetenerAnimaciones()
                            self.LoaderImaginamos.superview?.superview?.removeFromSuperview()
                            self.navigationController?.setNavigationBarHidden(false, animated: true)
                        }
                        
                    }
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
        }
        task.resume()
        
        
        
        
    }
    
    
    
    
    
    
    
    
    //MARK: - DATASOURCE
    //1
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //2
     func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return listCategories.count
    }
    //3
     func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CellCategoryIpad
        
        let name = (listCategories[indexPath.row] as NSDictionary).value(forKey: "name")
        let photo = (listCategories[indexPath.row] as NSDictionary).value(forKey: "image")
        
        cell.lblTitle.text = name as? String
        cell.imgCategory.image = UIImage(named: photo as! String)
        cell.lblSubTitle.text =  String(format: " %i Apps", arguments: [Int(arc4random_uniform(50)  + 10)])
        //et random = Int(arc4random_uniform(3))
        
        
        return cell
    }
    
     //MARK: - DELEGATE
     func collectionView(_ collectionView: UICollectionView,
                                 shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let name = (listCategories[indexPath.row] as NSDictionary).value(forKey: "name")
        let appsVC  = UIStoryboard(name: "StoryboardiPad", bundle: nil).instantiateViewController(withIdentifier: "AppsVC") as! AppsListViewIpadController
        appsVC.listApps = listApps;
        appsVC.categoryName = name as! String
        self.navigationController?.pushViewController(appsVC, animated: true)
        return false
    }
    
    //MARK: - DELEGATEFLOWLAYOUT
    
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



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
