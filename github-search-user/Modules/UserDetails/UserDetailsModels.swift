//
//  UserDetailsModels.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

struct UserModel: Decodable, Encodable {
    let name: String
    let role: String
}
