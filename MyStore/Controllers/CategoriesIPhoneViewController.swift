//
//  CategoriesIPhoneViewController.swift
//  MyStore
//
//  Created by Developer on 17/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class CategoriesIPhoneViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var listCategories = [NSDictionary]()
    var listApps:NSArray = NSArray()
    var startted:Bool = false
    let myActivityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var LoaderImaginamos: ImaginamosLoader!
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var tableCategories: UITableView!
    @IBOutlet weak var viewOffline: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        listApps = Util.GetApps()
        listCategories = [["name":"Salud","image":"salud.png"],["name":"Negocios","image":"negocio.png"],["name":"Comida","image":"comida.png"],["name":"Compras","image":"compras.png"],["name":"Finanzas","image":"finanzas.png"],["name":"Moda","image":"moda.png"],["name":"Booking","image":"booking.png"],["name":"Viajes","image":"viajes.png"],["name":"Música","image":"musica.png"],["name":"TV","image":"TV.png"],["name":"Noticias","image":"noticias.png"],["name":"Games","image":"games.png"],["name":"Documentos","image":"documentos.png"],["name":"Fotos","image":"fotos.png"],["name":"Videos","image":"videos.png"],["name":"Deportes","image":"deportes.png"]]
        self.viewOffline.frame.origin.y = self.view.frame.size.height
        self.tableCategories.delegate = self
        
        
        
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listCategories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! CellCategory
        
        //myCell.myImageView.image = UIImage(named: "no_image-128")
        let name = (listCategories[indexPath.row] as NSDictionary).value(forKey: "name")
        let photo = (listCategories[indexPath.row] as NSDictionary).value(forKey: "image")
        
        myCell.lblCategoryName.text = name as! String
        myCell.imgCAtegory.image = UIImage(named: photo as! String)
        
        
        
        return myCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let name = (listCategories[indexPath.row] as NSDictionary).value(forKey: "name")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListIphone") as! AppsListVViewController
        vc.listApps = listApps
        vc.categoryName = name as! String!
         self.navigationController?.pushViewController(vc, animated: true)
        
       
        
        
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
                
                
                // UIAlertView(title: <#T##String?#>, message: <#T##String?#>, delegate: <#T##Any?#>, cancelButtonTitle: <#T##String?#>)
                
                
                let alertController = UIAlertController(title: "My Store", message: "Ha ocurrido un error al cargar los datos.", preferredStyle: .alert)
                self.startted = true
                var okAction = UIAlertAction(title: "Reintentar", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    self.LoadApps()
                }
                
                if(self.listApps.count>0)
                {
                    alertController.message = alertController.message?.appending(" Se cargaran los datos almacenados de forma offline.")
                    
                    okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.tableCategories.reloadData()
                            self.LoaderImaginamos.DetenerAnimaciones()
                            self.LoaderImaginamos.superview?.superview?.removeFromSuperview()
                            self.navigationController?.setNavigationBarHidden(false, animated: true)
                            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                                
                                self.tableCategories.frame.size.height = self.tableCategories.frame.size.height-self.viewOffline.frame.size.height;
                                self.viewOffline.frame.origin.y-=self.viewOffline.frame.size.height
                            })
                        }
                        
                    }
                    
                    
                }
                alertController.addAction(okAction)
                
                
                
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
                        self.tableCategories.reloadData()
                        self.LoaderImaginamos.DetenerAnimaciones()
                        self.LoaderImaginamos.superview?.superview?.removeFromSuperview()
                        self.navigationController?.setNavigationBarHidden(false, animated: true)
                        
                    }
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
        }
        task.resume()
        
        
        
        
    }
    
   

    

}
