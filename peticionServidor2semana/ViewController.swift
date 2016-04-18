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
    @IBOutlet weak var cover: UIImageView!
    
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
        }else if datos != nil{
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dic1 = json as! NSDictionary
                    if dic1.count == 0 {
                    cover.image = nil
                    bookTitle.text = "No se encontró el libro"
                    return
                    }
                let dic2 = dic1["ISBN:\(isbn!)"] as! NSDictionary
                self.bookTitle.text = dic2["title"] as! NSString as String
                let dic3 = dic2["authors"] as! NSArray
                let dic4 = dic3[0] as! NSDictionary
                self.bookAutor.text = dic4["name"] as! NSString as String
                
                let imageURL = NSURL(string: "http://covers.openlibrary.org/b/isbn/\(isbn!)-L.jpg")!
                let image = NSData(contentsOfURL: imageURL)!
                cover.image = UIImage(data: image)
                
            }catch _{
                    }
                }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     //trate de utilizar este metodo pero no funciono
    @IBAction func textFieldReturn(sender: AnyObject) {
        self.resignFirstResponder()
        sincrono()
    }
    
    //por eso he creado este boton
    @IBAction func buscarButton() {
        sincrono()
    }
}
    
    
    
        
        





