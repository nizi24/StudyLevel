//
//  ImageContainer.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation
import UIKit

final class ImageContainer: ObservableObject {
    @Published var image = UIImage(systemName: "photo")!

    init(from resource: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: resource, completionHandler: { [weak self] data, _, _ in
            guard let imageData = data,
                let networkImage = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                self?.image = networkImage
            }
            session.invalidateAndCancel()
        })
        task.resume()
    }
}
