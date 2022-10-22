//
//  FirestoreRepository.swift
//  ContactsCrud
//
//  Created by alex on 20/10/2022.
//

import Foundation
import FirebaseFirestore
//import FirebaseCore

class FirestoreRepository {
    
    var db = Firestore.firestore()
    var contacts = [Contact]()
//    var contact : Contact?
    
    func fetchData(){
        /*Snapshot listener has 2 parameters : querySnapshot and error
          querySnapshot holds the documents from our collection
         */
        db.collection("contacts").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No contacts")
                return
            }
            //at this point we now we've got documents
            self.contacts = documents.map { queryDocumentSnapshot -> Contact in
                return try! queryDocumentSnapshot.data(as: Contact.self)
            }
        }
    }
    
    
    func findContactById(id : String, onCompletion : @escaping (Contact?) -> Void) {
        let docRef = db.collection("contacts").document(id)
        var contactResult : Contact!
        
        docRef.getDocument(as: Contact.self) { result in
            switch result {
            case .success(let contact):
                print("\(contact.email)")
                contactResult = contact
                onCompletion(contactResult)
            case .failure(let error):
                print("Error decoding document: \(error)")
                onCompletion(nil)
            }
        }
    }
    
    


    
    /**
            
     */
    func addContact(contact: Contact) -> Bool{
        var result = true
        do{
            let _ = try db.collection("contacts").addDocument(from: contact)
            
        }catch{
            print(error)
            result = false
        }
        return result
    }
    
    func deleteContact(contact: Contact) -> Bool{
        var result = true
        db.collection("contacts").document(contact.id!).delete(){ err in
            if let err = err {
                print("Error removing document: \(err)")
                result = false
            }else{
                print("Document successfully deleted")
            }
        }
        return result;
    }
    
    func updateContact(contact: Contact) -> Bool{
        var result = true
        do{
            contact.lastUpdatedAt = nil
            try db.collection("contacts").document(contact.id!).setData(from: contact)
        }catch{
            print("Error updating document: \(error)")
            result = false
        }
        return result;
    }
    

    
    
     
}
