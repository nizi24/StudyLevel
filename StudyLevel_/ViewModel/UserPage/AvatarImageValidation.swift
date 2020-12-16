//
//  AvatarImageValidation.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/13.
//

import Foundation
import SwiftUI

struct AvatarImageValidation {
    
    func isValidImage(image: UIImage?) -> ValidationError? {
        guard let image = image else {
            return .notSelected
        }
        let imageData: Int = NSData(data: image.jpegData(compressionQuality: 1)!).count
        let dataToKB = Double(imageData) / 1000.0
        if dataToKB > 5000.0 {
            return .imageSizeIsTooBig
        }
        return nil
    }
    
    enum ValidationError: Error {
        case notSelected
        case imageSizeIsTooBig
    }
}
