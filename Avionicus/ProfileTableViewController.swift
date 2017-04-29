import UIKit
import SDWebImage

var heightForHeader: CGFloat = 40

class ProfileTableViewController: UITableViewController {
    
    var userProfile: UserProfile?
    
    struct StoryboardConstants {
        static let EditProfileField = ""
        static let FieldCellIdentifier = "ProfileFieldCell"
        static let ActionCellIdentifier = "ProfileActionCell"
    }

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userSportClub: UILabel!
    
    var profileItems: [ProfileItem] = [ProfileItem]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if userProfile != nil {
            setUpTableData()
            tableView.reloadData()
        } else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            fetchProfileData()
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        tableView.tableFooterView = UIView()
       

        
    }
    
    func fetchProfileData(){
        
        apiManager.getProfile { [weak welf = self] result in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success (let profile):
                welf?.userProfile = profile
                DispatchQueue.main.async {
                    welf?.setUpTableData()
                    welf?.tableView.reloadData()
                }
                
                break
            case .failure(let error):
                _ = UIAlertController.errorAlert(title: "Error", message: "\(error)", buttonTitle: "Ok")
                break
            }
        }
    }
    
    func setUpTableData() {
        
        if let profile = userProfile {
            
            userName.text = profile.name
            userAvatar.sd_setImage(with: URL(string: profile.avatar_url!))
            userName.text = profile.login
            userSportClub.text = profile.sport_club
            
            profileItems.append(ProfileItem(kind: .Field(profile.name), title: "Name"))
            if let birthDate = profile.birthday {
                let calendar = NSCalendar.current
                
                let components = calendar.dateComponents([.year], from: birthDate, to: Date())

                profileItems.append(ProfileItem(kind: .Field(String(describing: components.year!)), title: "Age"))
                
                let df = DateFormatter()
                df.dateStyle = .medium
                
                userAge.text = "\(String(describing: components.year!)), \(df.string(from: birthDate))"
            } else {
                profileItems.append(ProfileItem(kind: .Field(nil), title: "Age"))
            }
            profileItems.append(ProfileItem(kind: .Field(profile.sex?.description ?? "non"), title: "Sex"))
            profileItems.append(ProfileItem(kind: .Field(String(describing: profile.weight!)), title: "Weight, kg"))
            profileItems.append(ProfileItem(kind: .Field(String(describing: profile.max_hr)), title: "Max. heart rate"))
            profileItems.append(ProfileItem(kind: .Field(String(describing: profile.login!)), title: "Login"))
            profileItems.append(ProfileItem(kind: .Field(String(describing: profile.email!)), title: "Email"))
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profileItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = profileItems[indexPath.row]
        
        let identifier: String
        switch item.cellKind {
        case .Field:
            identifier = StoryboardConstants.FieldCellIdentifier
        case .Action:
            identifier = StoryboardConstants.ActionCellIdentifier
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as UITableViewCell!
        
        cell?.textLabel?.text = item.title
        
        if case .Field(let value) = item.cellKind {
            cell?.detailTextLabel?.text = value
        }
        
        return cell!
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // this will be non-nil if a blur effect is applied
        guard tableView.backgroundView == nil else {
            return
        }
        
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Little bit Black"))
        imageView.contentMode = .scaleAspectFill
        
        tableView.backgroundView = imageView
        
    }
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
