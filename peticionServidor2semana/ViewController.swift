//
//  ViewController.swift
//  peticionServidor2semana
//
//  Created by Seba Benavides on 25-12-15.
//  Copyright © 2015 Seba Benavides. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAutor: UILabel!
    @IBOutlet weak var alerta: UILabel!
    
    
    func sincrono(){
        let isbn = textField.text
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn!)"
        let url = NSURL(string: urls)
        let datos :NSData? = NSData(contentsOfURL: url!)
        if datos == nil {
            let alerta = UIAlertController(title: "Alerta", message: "No dispones de conexion a internet", preferredStyle: .Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }
       else if textField.text == ""{
            let alerta = UIAlertController(title: "Alerta", message: "No has ingresado un ISBN", preferredStyle: .Alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alerta, animated: true, completion: nil)
        }else{
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dic1 = json as! NSDictionary
                let dic2 = dic1["ISBN:\(isbn!)"] as! NSDictionary
                self.bookTitle.text = dic2["title"] as! NSString as String
                let dic3 = dic2["authors"] as! NSArray
                let dic4 = dic3[0] as! NSDictionary
                self.bookAutor.text = dic4["name"] as! NSString as String
                
                
            }catch _{
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buscarButton() {
        sincrono()
    }

    @IBAction func buscar(sender: AnyObject) {
        sincrono()
    }
   

}
    
    
    
        
        





