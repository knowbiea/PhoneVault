//
//  LoginVM.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import SwiftUI
import GoogleSignIn
import CoreData

protocol SocialLoginVMInput {
    var user: User? { get set }
    var dataController: DataController { get }
}

class SocialLoginVM: SocialLoginVMInput {
    
    // MARK: - Properties
    var user: User?
    private(set) var dataController: DataController
    
    // MARK: - Initializers
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func storeUser(_ googleUser: GIDGoogleUser) {
        user = User(context: dataController.viewContext)
        user?.userID = googleUser.userID
        user?.idToken = googleUser.idToken?.tokenString
        user?.emailID = googleUser.profile?.email
        user?.fullName = googleUser.profile?.name
        user?.givenName = googleUser.profile?.givenName
        user?.familyName = googleUser.profile?.familyName
        user?.pictureURL = googleUser.profile?.imageURL(withDimension: 500)?.absoluteString
        dataController.save()
        
        let userData = """
            Google SignIN User Details
            userID: \((user?.userID).value)
            emailID: \((user?.emailID).value)
            FullName: \((user?.fullName).value)
            GivenName: \((user?.givenName).value)
            FamilyName: \((user?.familyName).value)
            ProfileUrl: \((user?.pictureURL).value)
            ID Token: \((user?.idToken).value)
            """
        
        print(userData)
    }
    
    func fetchUserData(userID: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userID == %@", userID)
        fetchRequest.fetchLimit = 1
        let users = try? dataController.viewContext.fetch(fetchRequest)
        user = users?.first
        print("User: \((user?.fullName).value)")
    }
    
    func deleteUser() {
        if let user {
            dataController.viewContext.delete(user)
            dataController.save()
        }
    }
}
