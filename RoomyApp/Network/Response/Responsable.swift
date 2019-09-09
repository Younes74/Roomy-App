//
//  Responsable.swift
//  Tourism
//
//  Created by mac  on 4/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol Responsable {
    var code: Int {get set}
    var data: Data? {get set}
    func isResponseValid()->Bool
    func getError()->RequestError
}
