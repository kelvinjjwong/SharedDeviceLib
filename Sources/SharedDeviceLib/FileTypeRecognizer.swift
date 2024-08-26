//
//  FileTypeRecognizer.swift
//
//  Created by Kelvin Wong on 2019/10/19.
//  Copyright © 2019 nonamecat. All rights reserved.
//

import Foundation

public enum ImageType : Int {
    case photo
    case video
    case other
}

// MARK: - FILE TYPE

public struct FileTypeRecognizer {
    
    public static let photoExts:[String] = ["jpg", "jpeg", "png", "heic"]
    static let videoExts:[String] = ["mov", "mp4", "mpeg", "mts", "m2ts"]
    
    public let allowed:Set<String> = ["jpg", "jpeg", "mp4", "mov", "mpg", "mpeg", "png", "heic", "mts", "m2ts", "pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "vcf", "amr"]
    
    public func recognize(from url:URL) -> ImageType {
        var type = self.recognize(from: url.lastPathComponent)
        
        if type == .other {
            do {
                let properties = try url.resourceValues(forKeys: [.typeIdentifierKey])
                guard let fileType = properties.typeIdentifier else { return type }
                if UTTypeConformsTo(fileType as CFString, kUTTypeImage) {
                    type = .photo
                }else if UTTypeConformsTo(fileType as CFString, kUTTypeMovie) {
                    type = .video
                }
            }
            catch {
                print("Unexpected error occured when recognizing image type: \(error).")
            }
        }
        
        return type
    }
    
    public func recognize(from filename: String) -> ImageType {
        let fileExt:String = (filename.split(separator: Character(".")).last?.lowercased()) ?? filename
        if FileTypeRecognizer.photoExts.contains(fileExt) {
            return.photo
        }else if FileTypeRecognizer.videoExts.contains(fileExt) {
            return.video
        }
        return .other
    }
}
