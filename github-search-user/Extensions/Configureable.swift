//
//  Configureable.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//

import Foundation

protocol Configurable {}
extension Configurable {
    @discardableResult
    func configure(completion: (Self) -> Void) -> Self {
        completion(self)
        return self
    }
}

extension NSObject: Configurable {}
