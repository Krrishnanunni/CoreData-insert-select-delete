//
//  ItemDataVC.swift
//  CoreData-insert-select-delete
//
//  Created by iroid on 02/06/25.
//

import UIKit

class ItemDataVC: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.fetchdata()
        self.myTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    var martarray: [Mart] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    
    func fetchdata(){
        do{
            martarray = try context.fetch(Mart.fetchRequest())
        }catch{
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
extension ItemDataVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        martarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemdata") as! ItemTableViewCell
        let record = martarray[indexPath.row]
        cell.textLabel?.text = record.p_name! 
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let mtd = martarray[indexPath.row]
            context.delete(mtd)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            fetchdata()
        }
        myTable.reloadData()
    }

    
    
}
