//
//  ProfileTableViewController.swift
//  Avionicus
//
//  Created by Roman Mogutnov on 28/03/2017.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit

struct cellData {
    
    let cell : Int!
    let textMain : String!
    let textInfo : String!
    
}

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var profileUserName: UILabel!
    @IBOutlet var profileLittleInfo: UILabel!
    
    var arrayOfStatusData = [cellData]()
    var arrayOfPersonalData = [cellData]()
    var arrayOfHealthData = [cellData]()

    override func viewDidLoad() {
        
        arrayOfStatusData = [cellData(cell: 1, textMain: "Status", textInfo: "example")]
        
        arrayOfPersonalData = [cellData(cell: 1, textMain: "Date of Birth", textInfo: "example"),
                           cellData(cell: 2, textMain: "Hometown", textInfo: "example"),
                           cellData(cell: 3, textMain: "eMail", textInfo: "example")]
        
        arrayOfHealthData = [cellData(cell: 1, textMain: "Weight", textInfo: "example"),
                               cellData(cell: 2, textMain: "Grouth", textInfo: "example"),
                               cellData(cell: 3, textMain: "Max Heart Rate", textInfo: "example")]
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return arrayOfPersonalData.count
        
        
        
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! ProfileTableViewCell
            
            cell.mainLabel.text = arrayOfStatusData[indexPath.row].textMain
            cell.infoLabel.text = arrayOfStatusData[indexPath.row].textInfo
        
            cell.mainLabel.text = arrayOfPersonalData[indexPath.row].textMain
            cell.infoLabel.text = arrayOfPersonalData[indexPath.row].textInfo
        
            cell.mainLabel.text = arrayOfHealthData[indexPath.row].textMain
            cell.infoLabel.text = arrayOfHealthData[indexPath.row].textInfo
        
            return cell
        
        
    }
    

    
    
    
    
    
}


//
//let section = ["Personal Data", "Health"]
//
//let items = [["Date of Birth", "Hometown", "Email"], ["Weight", "Grouwth", "Max Heart Rate"]]




//override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    
//    return self.section[section]
//    
//}
//
//override func numberOfSections(in tableView: UITableView) -> Int {
//    // #warning Incomplete implementation, return the number of sections
//    
//    return self.section.count
//    
//}
//
//
//override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return arrayOfPersonalData.count
//    //        return self.items[section].count
//    
//}
//
//override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
//    
//    // Configure the cell...
//    
//    cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
//    
//    return cell
//    
//}

    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        var view = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(tableView.frame.size.width), height: CGFloat(18)))
    //        /* Create custom view to display section header... */
    //        var label = UILabel(frame: CGRect(x: CGFloat(10), y: CGFloat(5), width: CGFloat(tableView.frame.size.width), height: CGFloat(18)))
    //        label.font = UIFont.boldSystemFont(ofSize: CGFloat(12))
    //        var string: String? = (items[section] as? String)
    //        /* Section header is in 0th index... */
    //        label.text = string
    //        view.addSubview(label)
    //        view.backgroundColor = UIColor(red: CGFloat(166 / 255.0), green: CGFloat(177 / 255.0), blue: CGFloat(186 / 255.0), alpha: CGFloat(1.0))
    //        //your background color...
    //        return view
    //    }
    
    
    


