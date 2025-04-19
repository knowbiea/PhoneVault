//
//  ProductDetailVM.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import SwiftUI
import CoreData
import Combine

protocol ProductDetailViewModelInput {
    var phone: Phone { get set }
    var dataController: DataController { get }
    var completion: (() -> Void)? { get set }
}

class ProductDetailVM: ProductDetailViewModelInput {
    
    // MARK: - Properties
    var phone: Phone
    var dataController: DataController
    var completion: (() -> Void)?
    
    init(phone: Phone, dataController: DataController) {
        self.phone = phone
        self.dataController = dataController
    }
}
