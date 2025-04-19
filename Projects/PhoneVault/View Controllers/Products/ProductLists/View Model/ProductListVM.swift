//
//  ProductListVM.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import SwiftUI
import CoreData
import Combine

typealias UpdateDataSource = UITableViewDiffableDataSource<PhoneSection, Phone>
typealias UpdateSnapshot = NSDiffableDataSourceSnapshot<PhoneSection, Phone>

enum PhoneSection: CaseIterable {
    case main
    
    var value: String {
        return "\(self)"
    }
}

protocol ProductListViewModelInput {
    var phones: [Phone] { get set }
    var networkManager: NetworkManagerType { get }
    var dataController: DataController { get }
}

class ProductListVM: ObservableObject, ProductListViewModelInput {
    
    // MARK: - Properties
    var networkManager: NetworkManagerType
    var dataController: DataController
    private var cancellable = Set<AnyCancellable>()
    @Published var phones: [Phone] = []
    
    var dataSource: UpdateDataSource!
    
    init(networkManager: NetworkManagerType, dataController: DataController) {
        self.networkManager = networkManager
        self.dataController = dataController
    }
    
    func fetchProducts() {
        let fetchRequest: NSFetchRequest<Phone> = Phone.fetchRequest()
        let phoneArray = try? dataController.viewContext.fetch(fetchRequest)
        phones = phoneArray ?? []
        
        if phones.count == 0 {
            networkManager.apiModelRequest([PhoneDTO].self, .phone)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let err):
                        if case .unknown(let err) = err {
                            print("Error1 is \(err)")
                        }
                        print("Error is \(err.localizedDescription)")
                    case .finished:
                        print("Finished")
                    }
                } receiveValue: { [weak self] value in
                    guard let self else { return }
                    print("Value is \(value)")
                    let phones = value.map { Phone.create(from: $0, in: self.dataController.viewContext) }
                    self.phones = phones
                    self.dataController.save()
                    self.configureDataSnapshot()
                }
                .store(in: &cancellable)
        } else {
            configureDataSnapshot()
            
        }
    }
    
    func deletePhone(_ row: Int) {
        let phone = phones[row]
        phones.removeAll { $0 == phone }
        
        dataController.viewContext.delete(phone)
        dataController.save()
        
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([phone])
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func configureDataSnapshot() {
        DispatchQueue.main.async {
            var snapshot = UpdateSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.phones)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
