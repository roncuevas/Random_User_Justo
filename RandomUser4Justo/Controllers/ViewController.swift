//
//  ViewController.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/26/22.
//

import UIKit

class ViewController: UIViewController {
    
    //Outlets to Main storyboard elements
    @IBOutlet weak var newUserButton: UIButton!
    @IBOutlet weak var savedUsersButton: UIButton!
    @IBOutlet weak var userHeaderInfo: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userDataLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    //Declaration of variables
    private var userArray: [UserDataModel] = [] //Array of users gotten from API and initializer
    private var cdManager = CoreDataManager()  //Core Data manager
    private var userConection = RandomUserAPIConection() //Conection to API
    private let defaults = UserDefaults.standard //Instance for UserDefaults access
    private var imageURL = "https://cdn-icons-png.flaticon.com/512/4123/4123763.png"  //Variable to save temporary url string
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearLabels()
        getNewUser()
        loadDataFromDefaults()
    }
    
    //Button action to get a new user and display it on the screen
    @IBAction func newUserButtonAction(_ sender: Any) {
        clearLabels()
        getNewUser()
        for user in userArray {
            setDataToLabels(user: user)
            saveDataToDefaults()
        }
    }
    
    //Button action to get save the actual displayed user with CoreData
    @IBAction func saveButtonAction(_ sender: Any) {
        if !(userNameLabel.text == "Welcome" && userHeaderInfo.text == "") {  //If the information is not the instructions (initial) screen then save it
            cdManager.addUser(name: userNameLabel.text!,
                              header: userHeaderInfo.text!,
                              data: userDataLabel.text!,
                              url: imageURL)
            showMessage(string: "Saved \(userNameLabel.text!)")
        } else {
            showMessage(string: "Cannot save welcome screen")
        }
    }
    
    //Displays a brief message on infoLabel
    func showMessage(string: String) {
        infoLabel.text = string
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.infoLabel.text = ""
        }
    }
    
    //Receives the userDataModel and displays some information on the Labels
    func setDataToLabels(user: UserDataModel) {
        userNameLabel.text = user.name.first + " " + user.name.last + ""
        userHeaderInfo.text = "Age: \(user.dob.age)\t" +
        "Gender: \(user.gender)\n" +
        "Country: \(user.location.country)"
        userDataLabel.text = "Birthday: \(user.dob.date)\n" +
        "Email: \(user.email)\n" +
        "Phone: \(user.phone)\n" +
        "Location: \(user.location.street.name), \(user.location.street.number), \(user.location.city), \(user.location.state)\n" +
        "Username: \(user.login.username)\n" +
        "Password: \(user.login.password)"
        imageURL = user.picture.thumbnail
        loadUserImage()
    }
    
    //Loads a new image to the userImage from the actual imageURL
    func loadUserImage() {
        userImage.load(url: URL(string: imageURL)!)
        userImage.layer.cornerRadius = userImage.frame.height / 2
        
    }
    
    //Clears the text from the labels to defult text that will override from Userdefaults
    func clearLabels() {
        userNameLabel.text = "Welcome"
        userHeaderInfo.text = ""
        userDataLabel.text = "Welcome, \nPress the 'New User' button to generate a new random user\nPress on 'Save' to save it \nPress on 'Saved users' to see the saved users"
        infoLabel.text = ""
    }
    
    //Gets a new user from the API and saves it on the userArray variable
    func getNewUser() {
        userArray = userConection.getData()
    }
    
    //Stores the last User displayed on UserDefaults
    func saveDataToDefaults() {
        defaults.set(userNameLabel.text ?? "", forKey: "Name")
        defaults.set(userHeaderInfo.text ?? "", forKey: "Header")
        defaults.set(userDataLabel.text ?? "", forKey: "Data")
        defaults.set(imageURL, forKey: "Image")
    }
    
    //Loads the last User displayed from Userdefaults to Labels
    func loadDataFromDefaults() {
        if let label = defaults.string(forKey: "Name") {
            userNameLabel.text = label
        }
        if let header = defaults.string(forKey: "Header") {
            userHeaderInfo.text = header
        }
        if let data = defaults.string(forKey: "Data") {
            userDataLabel.text = data
        }
        if let url = defaults.string(forKey: "Image") {
            imageURL = url
            loadUserImage()
        }
    }
}

//Extension from internet into UIImageView != nil
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


