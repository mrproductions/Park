//
//  FilesTableViewController.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 06.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit

class FilesTableViewController: UITableViewController {
    
    struct File {
        let name: String
        let url: URL
    }
    
    struct StoryboardConstants {
        static let cellIdentifier = "File Cell"
        static let segueIdentifier = "goToFile"
    }
    
    private var files = [File]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        reloadFiles()

        let imageForNavBar = UIImage(named: "StatusBar")
        navigationController?.navigationBar.setBackgroundImage(imageForNavBar, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstants.cellIdentifier)
        cell?.textLabel?.text = files[indexPath.row].name
        return cell!
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = (segue.destination as? FileDetailViewController) else {
            return
        }
        
        guard segue.identifier == StoryboardConstants.segueIdentifier else {
            return
        }
        
        guard let index = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        destination.file = files[index]
        
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    func loadFiles () {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            files = directoryContents.filter { $0.pathExtension == "csv" }.map { File(name: $0.lastPathComponent, url: $0) }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let action = UITableViewRowAction(style: .destructive, title: "Remove") { [weak self] (_, indexPath) in
            
            guard let welf = self else {
                return
            }
            
            let url = welf.files[indexPath.row].url
            let fm = FileManager.default
            do {
                try fm.removeItem(at: url)
                DispatchQueue.main.async {
                    welf.files.remove(at: indexPath.row)
                    welf.tableView.reloadData()
                }
            } catch {
                print("Couldn't remove file")
            }
            
        }
        
        return [action]
        
    }
    
    @IBAction func reloadFiles () {
        
        loadFiles()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
}
