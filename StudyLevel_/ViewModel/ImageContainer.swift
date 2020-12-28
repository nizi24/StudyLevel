//
//  ImageContainer.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation
import UIKit
import RealmSwift

final class ImageContainer: ObservableObject {
    @Published var image = UIImage(systemName: "photo")!
    var userId: Int

    init(from resource: URL, userId: Int) {
        self.userId = userId
        let session = URLSession(configuration: .default)
        let realm = try! Realm()
        if let realmData = realm.objects(UserAvatarDB.self).filter("userId == %@", userId).first {
            if realmData.imageURL == resource.absoluteString {
                if let uiImage = UIImage(data: realmData.imageData) {
                    let resizedImage = uiImage.resized(withPercentage: 0.1)
                    self.image = resizedImage ?? uiImage
                    return
                }
            }
        }
        let task = session.dataTask(with: resource, completionHandler: { [weak self] data, _, _ in
            guard let imageData = data,
                let networkImage = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                self?.image = networkImage
                if let userId = self?.userId {
                    let avatar = UserAvatarDB().create(userId: userId, imageData: imageData, imageURL: resource.absoluteString)
                    let realm = try! Realm()
                    try! realm.write {
                        realm.delete(realm.objects(UserAvatarDB.self).filter("userId == %@", userId))
                        realm.add(avatar)
                    }
                }
            }
            session.invalidateAndCancel()
        })
        task.resume()
    }
}

extension UIImage {
    //データサイズを変更する
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
