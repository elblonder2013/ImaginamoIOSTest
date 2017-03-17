//
//  Util.swift
//  MyStore
//
//  Created by Developer on 13/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import Foundation

class Util: NSObject {
    static func SaveData(dictionary:NSDictionary)->Bool
    {
        var theJSONText = ""
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
             theJSONText = String(data: theJSONData,
                                     encoding: .ascii)!
            
        }
        else
        {
            return false
        }
        
        let file = "apps.txt" //this is the file. we will write to and read from it
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            do {
                try theJSONText.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                //try diccionario.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {
                return false;
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        return true;
    }
    class func GetApps()->NSArray
    {
        var arregloApps:NSArray = []
       
        let file = "apps.txt" //this is the file. we will write to and read from it
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent("apps.txt")?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
            print("FILE AVAILABLE")
        } else {
            return arregloApps;
        }

        
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            
            do {
                let stringDict = try String(contentsOf: path, encoding: String.Encoding.utf8)
                if let data = stringDict.data(using: String.Encoding.utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                         arregloApps = json?.value(forKey: "children") as! NSArray
                       
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
            catch {/* error handling here */}
        }
        
        return arregloApps;
    }
    
   
}
