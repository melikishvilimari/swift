//
//  FormModel.swift
//  iiiiioooooo
//
//  Created by Cleaner on 2/10/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import Foundation
import UIKit

class FormModel {
    var Name: String?
    var Image: String?
    var Desc: String?
    var Lng: String?
    var Ltd: String?
    
    init() {
        
    }
    
    init(name: String, image: String, Desc: String, Lng: String, Ltd: String) {
        self.Name = name
        self.Image = image
        self.Desc = Desc
        self.Lng = Lng
        self.Ltd = Ltd
    }
    
}