import UIKit

var heightForHeader: CGFloat = 40

class ProfileTableViewController: UITableViewController {
    
    var profile: UserProfile?
    
    @IBOutlet weak var username: UILabel!
    
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()
    
    @IBAction fileprivate func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.getProfile { [weak welf = self] result in
            switch result {
            case .success (let profile):
                if profile != nil {
                    welf?.profile = profile
                    DispatchQueue.main.async {
                        welf?.username.text = self.profile?.name
                    }
                }
                break
            case .failure(let error):
                
                break
            }
        }
        
        objectsArray = [Objects(sectionName: "Personal Information", sectionObjects: ["birthday", "hometown", "email"]), Objects(sectionName: "Health", sectionObjects: ["Weight", "Grouwth", "Max Heart Rate"])]
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return objectsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objectsArray[section].sectionObjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        
        cell?.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        cell?.detailTextLabel?.text = "Subtitle #\(indexPath.row)"
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return heightForHeader
    }
    
    
}
