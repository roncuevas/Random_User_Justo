//
//  SavedUsersController.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/27/22.
//

import Foundation
import UIKit

class SavedUsersController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var cdManager = CoreDataManager()
    private var data: [UserEntity] = []
    
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        usersTableView.delegate = self
        usersTableView.dataSource = self
        
    }
    
    func loadUsers() {
        cdManager.fetchUsers()
        data = cdManager.savedEntities
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = data[indexPath.row]
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.userNameLabel.text = user.name
        cell.userImageView.load(url: URL(string: user.url ?? "")!)
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.height / 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          cdManager.deleteUser(entity: self.data[indexPath.row])
          self.data.remove(at: indexPath.row)
          self.usersTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = self.data[indexPath.row]
        let defaults = UserDefaults.standard //Instance for UserDefaults access
        defaults.set(entity.name, forKey: "Name")
        defaults.set(entity.header, forKey: "Header")
        defaults.set(entity.data, forKey: "Data")
        defaults.set(entity.url, forKey: "Image")
        _ = navigationController?.popViewController(animated: true)
        
    }
}
