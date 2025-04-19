//
//  ProductListVC.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import UIKit

class ProductListVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: ProductListVM
    
    // MARK: - SetUp
    init(viewModel: ProductListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Product List"
        configureDataSource()
        viewModel.fetchProducts()
    }
    
    // MARK: - Custom Methods
    func configureDataSource() {
        viewModel.dataSource = UpdateDataSource(tableView: tableView,
                                                cellProvider: { tableView, indexPath, model -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.contentView.backgroundColor = .viewBackground
            cell.textLabel?.text = model.name
            cell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 14)
            
            cell.selectionStyle = .none
            return cell
        })
    }
    
    func deletePhoneAlert(id: String) {
        guard let index = viewModel.phones.firstIndex(where: { $0.id == id }) else { return }
        let phone = viewModel.phones[index]
        let alertController = UIAlertController(title: "Delete",
                                                message: "Are you sure want to delete this \(phone.name.value) phone?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            guard let self else { return }
            self.viewModel.deletePhone(index)
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: .cancel))
        navigationController?.present(alertController, animated: true)
    }
}

// MARK: - UITableView Delegate
extension ProductListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phone = viewModel.phones[indexPath.row]
        let productDetailVM = ProductDetailVM(phone: phone, dataController: viewModel.dataController)
        
        productDetailVM.completion = { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
        
        let productDetailVC = ProductDetailVC(viewModel: productDetailVM)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let self else { return }
            self.viewModel.deletePhone(indexPath.row)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
