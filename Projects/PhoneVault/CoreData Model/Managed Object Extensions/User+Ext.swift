//
//  User+Ext.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import Foundation
import CoreData

extension User {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
