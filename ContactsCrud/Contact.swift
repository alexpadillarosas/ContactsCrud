//
//  Contact.swift
//  ContactsCrud
//
//  Created by alex on 20/10/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public class Contact : Codable{
    
    @DocumentID var id : String?
    var firstname : String
    var lastname : String
    var email : String
    var phone : String
    var photo : String
    var position : String
    var favorite : Bool
    @ServerTimestamp var createdTime : Timestamp?   //If an object being written contains null, it will be replaced with a server-generated timestamp
    @ServerTimestamp var lastUpdatedAt : Timestamp?
    
    init(firstname: String, lastname: String, email: String, phone: String, photo: String, position: String, favorite: Bool, createdTime: Timestamp? = nil, lastUpdatedAt: Timestamp? = nil) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phone = phone
        self.photo = photo
        self.position = position
        self.favorite = favorite
        self.createdTime = createdTime
        self.lastUpdatedAt = lastUpdatedAt
    }
    
    convenience init(documentId : String) {
        self.init(firstname: "", lastname: "", email: "", phone: "", photo: "", position: "", favorite: false)
        self.id = documentId
    }
    
//    convenience init(documentId : String, firstname: String, lastname: String, email: String, phone: String, photo: String, position: String, favorite: Bool, createdTime: Timestamp? = nil, lastUpdatedAt: Timestamp? = nil){
//        self.init(firstname: firstname, lastname: lastname, email: email, phone: phone, photo: photo, position: position, favorite: favorite)
//        self.id = documentId
//
//    }
    
    
    
}
