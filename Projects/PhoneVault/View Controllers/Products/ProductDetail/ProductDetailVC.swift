//
//  ProductDetailVC.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import UIKit

class ProductDetailVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var phoneNameTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: ProductDetailVM
    
    // MARK: - SetUp
    init(viewModel: ProductDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.phone.name
        updateViews()
    }
    
    func updateViews() {
        phoneNameTextField.text = viewModel.phone.name
    }
    
    // MARK: - UIButton Actions
    @IBAction func updateAction(_ sender: UIButton) {
        viewModel.phone.name = phoneNameTextField.text ?? ""
        viewModel.dataController.save()
        viewModel.completion?()
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Update", message: "Update Completed", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        navigationController?.present(alertController, animated: true)
    }
}
