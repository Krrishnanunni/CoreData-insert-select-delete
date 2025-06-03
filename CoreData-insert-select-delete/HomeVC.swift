//
//  HomeVC.swift
//  CoreData-insert-select-delete
//
//  Created by iroid on 02/06/25.
//

import UIKit
import CoreData

class HomeVC: UIViewController {

    @IBOutlet weak var search_key: UITextField!
    @IBOutlet weak var p_price: UITextField!
    @IBOutlet weak var exp_date: UITextField!
    @IBOutlet weak var mnf_date: UITextField!
    @IBOutlet weak var p_name: UITextField!
    @IBOutlet weak var p_id: UITextField!
    
    

    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func save_btn(_ sender: Any) {
        
        let marta  = NSEntityDescription.insertNewObject(forEntityName: "Mart", into: context)
        
        
        marta.setValue(self.p_id.text, forKey: "p_id")
        marta.setValue(self.p_name.text, forKey: "p_name")
        marta.setValue(self.p_price.text, forKey: "p_price")
        marta.setValue(self.exp_date.text, forKey: "exp_date")
        marta.setValue(self.mnf_date.text, forKey: "man_date")
        
        
        do{
            try context.save()
            self.mnf_date.text = ""
            self.p_id.text = ""
            self.exp_date.text = ""
            self.p_price.text = ""
            self.p_name.text = ""
            
            
        } catch{
            print("error")
        }
        
        
    }
    

    @IBAction func Update(_ sender: Any) {
//        let marto = Mart(context: context)
//        marto.p_name = self.p_name.text
        let ManageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Mart", in: ManageContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(p_id = %@)", p_id.text!)
        request.predicate = predicate
        do{
            var results =
            try ManageContext.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValue(p_name.text, forKey: "p_name")
            objectUpdate.setValue(p_price.text, forKey: "p_price")
            objectUpdate.setValue(mnf_date.text, forKey: "man_date")
            objectUpdate.setValue(exp_date.text, forKey: "exp_date")
            do{
                try ManageContext.save()
                p_name.text = ""
               p_price.text = ""
               mnf_date.text = ""
               exp_date.text = ""
            }catch let error as NSError{
                search_key.text = error.localizedFailureReason
                
            }
            
        }catch let error as NSError{
            search_key.text = error.localizedFailureReason
            
        }
        
        
        
        
    }
    
    
    
    @IBAction func searched(_ sender: Any) {
        
        
            self.p_id.text     = ""
            self.p_name.text   = ""
            self.p_price.text  = ""
            self.mnf_date.text = ""
            self.exp_date.text = ""
            
            
        let request = NSFetchRequest <NSFetchRequestResult>(entityName: "Mart")
        
        let search_string = self.search_key.text
        request.predicate = NSPredicate(format: "p_name == %@", search_string!)
        var output_string = ""
        do{
            let result = try context.fetch(request)
            
            if result.count > 0 {
                
                
                
                for oneline in result{
//
//                    let onecode =   (oneline as AnyObject).value(forKey: "p_id") as! String
//                    let one_name =  (oneline as AnyObject).value(forKey: "p_name") as! String
//                    let one_price = (oneline as AnyObject).value(forKey: "p_price") as! String
//                    let one_mdate = (oneline as AnyObject).value(forKey: "man_date") as! String
//                  let one_expdate = (oneline as AnyObject).value(forKey: "exp_date") as! String
//
//                    output_string = output_string + onecode + " " + one_name + " " + one_price + " " + one_mdate + " " + one_expdate
                    
                    self.p_id.text = ((oneline as AnyObject).value(forKey: "p_id") as? String)
                    self.p_name.text = ((oneline as AnyObject).value(forKey: "p_name") as? String)
                    self.p_price.text = ((oneline as AnyObject).value(forKey: "p_price") as? String)
                    self.mnf_date.text = ((oneline as AnyObject).value(forKey: "man_date") as? String)
                    self.exp_date.text = ((oneline as AnyObject).value(forKey: "exp_date") as? String)
                    self.search_key.text = ""
                    
                    
                    
                }
            }else{
                self.search_key.text = "No Match Found"
            }
//            self.search_key.text = output_string
            
        }catch{
            print("error")
        }
        
        
    }
    

}
