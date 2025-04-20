//
//  ImageCacheManager.swift
//  Kado
//
//  Created by Suraj kahar on 24/03/25.
//

import UIKit


//class ImageCacheManager {
//    static let shared = ImageCacheManager()
//    private init() {}
//
//    private let cache = NSCache<NSString, UIImage>()
//
//    func getImage(for urlString: String) -> UIImage? {
//        return cache.object(forKey: urlString as NSString)
//    }
//
//    func setImage(_ image: UIImage, for urlString: String) {
//        cache.setObject(image, forKey: urlString as NSString)
//    }
//    
//    
//    func clearCache() {
//        cache.removeAllObjects() // Clears all cached images
//    }
//    
//}

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    private var keys: Set<String> = []
    
    // Get documents directory path
    private var cacheDirectory: URL {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent("ImageCache")
    }
    
    // MARK: - Save Image in Cache & Disk
    func setImage(_ image: UIImage, for urlString: String) {
        cache.setObject(image, forKey: urlString as NSString)
        keys.insert(urlString) // Track keys
        
        // Save image to disk
        saveImageToDisk(image, for: urlString)
    }
    
    // MARK: - Get Image from Cache or Disk
    func getImage(for urlString: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            return cachedImage
        } else if let diskImage = loadImageFromDisk(for: urlString) {
            cache.setObject(diskImage, forKey: urlString as NSString) // Restore to cache
            return diskImage
        }
        return nil
    }
    
    // MARK: - Save Image to Disk
    private func saveImageToDisk(_ image: UIImage, for urlString: String) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let fileURL = cacheDirectory.appendingPathComponent(urlString.toSafeFileName())
            try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
            try? data.write(to: fileURL)
        }
    }
    
    // MARK: - Load Image from Disk
    private func loadImageFromDisk(for urlString: String) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(urlString.toSafeFileName())
        if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    // MARK: - Get All Cached Images
    func getAllCachedImages() -> [String: UIImage] {
        var allImages: [String: UIImage] = [:]
        for key in keys {
            if let image = getImage(for: key) {
                allImages[key] = image
            }
        }
        return allImages
    }
    
    
    // MARK: - Clear All Cached Images
    func clearCache() {
        // 1. Clear NSCache
        cache.removeAllObjects()

        // 2. Delete all images from disk
        try? FileManager.default.removeItem(at: cacheDirectory)

        // 3. Clear stored keys
        keys.removeAll()

        print("All cached images have been removed!")
    }

}


// Helper: Convert URL string to a valid filename
extension String {
    func toSafeFileName() -> String {
        return self.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: ":", with: "_")
    }
}

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder // Set a placeholder to avoid flicker

        // Check cache first
        if let cachedImage = ImageCacheManager.shared.getImage(for: urlString) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageCacheManager.shared.setImage(image, for: urlString)
                    self.image = image
                }
            }
        }
    }
}
