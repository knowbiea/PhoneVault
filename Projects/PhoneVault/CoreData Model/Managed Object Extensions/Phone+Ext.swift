//
//  Phone+Ext.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import SwiftUI
import CoreData

struct PhoneDTO: Codable {
    let id: String
    let name: String
    let data: PhoneDataDTO?
}

extension Phone {
    @discardableResult
    static func create(from dto: PhoneDTO, in context: NSManagedObjectContext) -> Phone {
        let phone = Phone(context: context)
        phone.id = dto.id
        phone.name = dto.name
        
        // Create PhoneData entity
        if let data = dto.data {
            let phoneData = PhoneData.create(from: data, in: context)
            phoneData.phone = phone
            phone.data = phoneData
        }
        
        return phone
    }
    
    func toDTO() -> PhoneDTO {
        return PhoneDTO(
            id: self.id ?? "",
            name: self.name ?? "",
            data: self.data?.toDTO() ?? PhoneDataDTO(color: nil,
                                                     capacity: nil,
                                                     capacityGB: 0,
                                                     price: 0,
                                                     generation: nil,
                                                     year: 0,
                                                     cpuModel: nil,
                                                     hardDiskSize: nil,
                                                     strapColor: nil,
                                                     caseSize: nil,
                                                     descriptionText: nil,
                                                     screenSize: 0)
        )
    }
}
