//
//  ListVC.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import UIKit

class ListVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Properties
    var dataController: DataController
    var lists = [ButtonModel(title: "Google SignIn", selector: #selector(showGoogleSignIn)),
                 ButtonModel(title: "Report", selector: #selector(showPDFViewerScreen)),
                 ButtonModel(title: "Image", selector: #selector(showImageGalleryScreen)),
                 ButtonModel(title: "API Integration", selector: #selector(showPhoneListScreen)),]
    
    // MARK: - SetUp
    init(dataController: DataController) {
        self.dataController = dataController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Lists"
        lists.forEach { button in
            stackView.addArrangedSubview(self.createButton(button: button))
        }
    }
    
    @objc func showGoogleSignIn() {
        let loginViewModel = SocialLoginVM(dataController: dataController)
        let loginVC = SocialLoginVC(viewModel: loginViewModel)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func showPDFViewerScreen() {
        showDocumentURL("https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf",
                        title: "Balance Sheet",
                        isShare: true)
    }
    
    @objc func showImageGalleryScreen() {
        let imageGalleryVC = ImageGalleryVC()
        navigationController?.pushViewController(imageGalleryVC, animated: true)
    }
    
    @objc func showPhoneListScreen() {
        let viewModel = ProductListVM(networkManager: NetworkManager(), dataController: dataController)
        let productListVC = ProductListVC(viewModel: viewModel)
        navigationController?.pushViewController(productListVC, animated: true)
    }
    
    func createButton(button: ButtonModel) -> UIButton {
        let customButton = UIButton(type: .custom)
        customButton.setTitle(button.title, for: .normal)
        customButton.setTitleColor(.white, for: .normal)
        customButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 15)
        customButton.layer.cornerRadius = 8
        customButton.layer.borderWidth = 0.8
        customButton.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        customButton.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        customButton.addTarget(self, action: button.selector, for: .touchUpInside)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ customButton.heightAnchor.constraint(equalToConstant: 45) ])
        
        return customButton
    }
}

struct ButtonModel {
    let title: String
    let selector: Selector
}
