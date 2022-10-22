//
//  ViewController.swift
//  ContactsCrud
//
//  Created by alex on 19/10/2022.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var photoTextField: UITextField!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var lastUpdatedAtLabel: UILabel!
    
    let database = Firestore.firestore()
    let service = FirestoreRepository()
    var contacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let docRef = database.collection("contacts").whereField("position", isEqualTo: "IT")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents \(error!)")
                    return
                }
                
                self.contacts = documents.compactMap({ queryDocumentSnapshot -> Contact? in
                    return try? queryDocumentSnapshot.data(as: Contact.self)
                })
                
                for con in self.contacts {
                    print(con.firstname)
                }
                print("=======")
            }
         
         
        
        
        
        
        
        /*
        var myContact : Contact!
        service.findContactById(id: "g89bhoOpILwoPK9Vbkha"){ retContact in
            if let retContact = retContact{
                myContact = retContact
                print("contact returned \(myContact.photo)")
                myContact.lastname = "Dee"
                self.service.updateContact(contact: myContact)
            }else{
                print("Unable to retrieve the contact")
            }
                
        }
         */
         
        /*

        let myContact = Contact(firstname: "Frank", lastname: "Ford", email: "cford@gmail.com", phone: "+61436767239", photo: "craigFord.png", position: "IT", favorite: true)
        
        service.addContact(contact: myContact)
        */

//        var contact = Contact(documentId: "S4uBWiGnAJ3jBbamdvEX")
//        repository.deleteContact(contact: contact)
        
        /*
        myContact.lastname = "Dee"
        myContact.lastUpdatedAt = nil
        service.updateContact(contact: myContact)
        */
        
    }

    
    @IBAction func clearDidPress(_ sender: Any) {
        idTextField.text = ""
        firstnameTextField.text = ""
        lastnameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
        positionTextField.text = ""
        photoTextField.text = ""
    }
    
    
    @IBAction func searchDidPress(_ sender: Any) {
        var myContact : Contact!
        let docId = idTextField.text
        if docId!.isEmpty {
            showAlertMessage(title: "ID is Mandatory", message: "We need the ID to search for a particular contact")
            return
        }
        
        service.findContactById(id: docId!){ retContact in
            if let retContact = retContact{
                myContact = retContact
                print("contact returned \(myContact.photo)")
                self.firstnameTextField.text = myContact.firstname
                self.lastnameTextField.text = myContact.lastname
                self.emailTextField.text = myContact.email
                self.phoneTextField.text = myContact.phone
                self.positionTextField.text = myContact.position
                self.photoTextField.text = myContact.photo
                self.favoriteSwitch.isOn = myContact.favorite
                var date = myContact.createdTime?.dateValue()
                self.createdTimeLabel.text = date?.formatted()
                
                date = myContact.lastUpdatedAt?.dateValue()
                self.lastUpdatedAtLabel.text = date?.formatted()
                
            }else{
                print("Unable to retrieve the contact")
            }
                
        }
        
        
    }
    
    
    @IBAction func saveDidPress(_ sender: Any) {
        
        var contact = Contact(firstname: self.firstnameTextField.text!
                              , lastname: self.lastnameTextField.text!
                              , email: self.emailTextField.text!
                              , phone: self.phoneTextField.text!
                              , photo: self.photoTextField.text!
                              , position: self.positionTextField.text!
                              , favorite: self.favoriteSwitch.isOn)
        
        if service.addContact(contact: contact) {
            showAlertMessage(title: "Success", message: "\(contact.firstname) \(contact.lastname) was registered")
        }else{
            showAlertMessage(title: "Failed", message: "\(contact.firstname) \(contact.lastname) could not be registered")
        }
        
    }
    
    
    @IBAction func updateDidPress(_ sender: Any) {
        
        var contact = Contact(firstname: self.firstnameTextField.text!
                              , lastname: self.lastnameTextField.text!
                              , email: self.emailTextField.text!
                              , phone: self.phoneTextField.text!
                              , photo: self.photoTextField.text!
                              , position: self.positionTextField.text!
                              , favorite: self.favoriteSwitch.isOn)
        contact.id = self.idTextField.text
        
        if service.updateContact(contact: contact) {
            showAlertMessage(title: "Success", message: "\(contact.firstname) \(contact.lastname) was udpated")
        }else{
            showAlertMessage(title: "Failed", message: "\(contact.firstname) \(contact.lastname) could not be updated")
        }
        
    }
    
    
    @IBAction func deleteDidPress(_ sender: Any) {
        let docId = idTextField.text
        if docId!.isEmpty {
            showAlertMessage(title: "ID is Mandatory", message: "We need the ID to delete contact")
            return
        }
        
        let contact = Contact(documentId: docId!)
        if service.deleteContact(contact: contact){
            showAlertMessage(title: "Success", message: "Contact was deleted")
        }else{
            showAlertMessage(title: "Failed", message: "Contact could not be deleted")
        }
        
        
    }
    
    
    func showAlertMessage(title : String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    /*
    func showAlertAction(title : String, message: String) -> Bool{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        var result = true
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){
            (action) in
            print("deleted")
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            (action) in
            result = false
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true){
            
        }
        
    }
     */
    
}

