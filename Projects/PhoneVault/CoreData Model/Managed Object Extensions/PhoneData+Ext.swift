//
//  PhoneData+Ext.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import SwiftUI
import CoreData

struct PhoneDataDTO: Codable {
    let color: String?
    let capacity: String?
    let capacityGB: Int64?
    let price: Double?
    let generation: String?
    let year: Int16?
    let cpuModel: String?
    let hardDiskSize: String?
    let strapColor: String?
    let caseSize: String?
    let descriptionText: String?
    let screenSize: Double?
    
    enum CodingKeys: String, CodingKey {
        case color = "color"
        case capacity = "capacity"
        case capacityGB = "capacity GB"
        case price = "price"
        case generation = "generation"
        case year = "year"
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
        case strapColor = "Strap Colour"
        case caseSize = "Case Size"
        case descriptionText = "Description"
        case screenSize = "Screen size"
    }
}

extension PhoneData {
    static func create(from dto: PhoneDataDTO, in context: NSManagedObjectContext) -> PhoneData {
        let phoneData = PhoneData(context: context)
        
        phoneData.color = dto.color
        phoneData.capacity = dto.capacity
        phoneData.capacityGB = dto.capacityGB ?? 0
        phoneData.price = dto.price ?? 0
        phoneData.generation = dto.generation
        phoneData.year = dto.year ?? 0
        phoneData.cpuModel = dto.cpuModel
        phoneData.hardDiskSize = dto.hardDiskSize
        phoneData.strapColor = dto.strapColor
        phoneData.caseSize = dto.caseSize
        phoneData.descriptionText = dto.descriptionText
        phoneData.screenSize = dto.screenSize ?? 0
        
        return phoneData
    }
    
    func toDTO() -> PhoneDataDTO {
        return PhoneDataDTO(
            color: self.color,
            capacity: self.capacity,
            capacityGB: self.capacityGB,
            price: self.price,
            generation: self.generation,
            year: self.year,
            cpuModel: self.cpuModel,
            hardDiskSize: self.hardDiskSize,
            strapColor: self.strapColor,
            caseSize: self.caseSize,
            descriptionText: self.descriptionText,
            screenSize: self.screenSize
        )
    }
}
