//
//  LoginVC.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import UIKit
import GoogleSignIn
import SDWebImage

class SocialLoginVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - Properties
    var viewModel: SocialLoginVM
    
    // MARK: - SetUp
    init(viewModel: SocialLoginVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Social Google Login"
        Task {
            await checkUserLoggedIn()
        }
    }
    
    func checkUserLoggedIn() async {
        do {
            let user = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
            viewModel.fetchUserData(userID: user.userID.value)
            userFullNameLabel.text = viewModel.user?.fullName
            userImageView.sd_setImage(with: URL(string: (viewModel.user?.pictureURL).value))
            signInButton.setTitle("Google SignOUT", for: .normal)
        } catch {
            signInButton.setTitle("Google SignIN", for: .normal)
            print("Error: \(error)")
        }
    }
    
    // MARK: - UIButton Actions
    @IBAction func googleSignINOUTAction(_ sender: UIButton) {
        if sender.currentTitle == "Google SignOUT" {
            viewModel.deleteUser()
            GIDSignIn.sharedInstance.signOut()
            userFullNameLabel.text = ""
            userImageView.image = nil
            sender.setTitle("Google SignIN", for: .normal)
            
        } else {
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                if let user = result?.user {
                    self.viewModel.storeUser(user)
                    self.userFullNameLabel.text = "\((user.profile?.name).value)"
                    self.userImageView.sd_setImage(with: user.profile?.imageURL(withDimension: 500))
                    sender.setTitle("Google SignOUT", for: .normal)
                }
            }
        }
    }
}
