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
    var Name: String = ""
    var Surname: String = ""
    var Image: UIImage?
    
    init(name: String, surname: String, image: UIImage) {
        self.Name = name
        self.Surname = surname
        self.Image = image
    }
    
}