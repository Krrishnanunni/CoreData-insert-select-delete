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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
