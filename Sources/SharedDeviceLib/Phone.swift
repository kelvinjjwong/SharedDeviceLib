//
//  Phone.swift
//
//  Created by Kelvin Wong on 2018/7/20.
//  Copyright © 2018年 nonamecat. All rights reserved.
//

import Foundation

public enum ChecksumMode : Int {
    case Rough
    case Deep
}

public struct PhoneFile {
    
    public var filename:String = ""
    public var path:String = ""
    public var onDevicePath:String = ""
    public var fileMD5:String = "" {
        didSet {
            matched = ( fileMD5 == storedMD5 && fileDateTime == storedDateTime && fileSize == storedSize )
            matchedWithoutMD5 = ( fileDateTime == storedDateTime && fileSize == storedSize )
        }
    }
    public var fileDateTime:String = ""
    public var fileSize:String = ""
    public var storedMD5:String = ""
    public var storedDateTime:String = ""
    public var storedSize:String = ""
    public var importDate:String = ""
    public var importToPath:String = ""
    public var importAsFilename:String = "" {
        didSet {
            stored = (importAsFilename != "")
            
            if fileDateTime == "" { // from mac os
                matched = ( fileSize == storedSize )
                matchedWithoutMD5 = matched
                //stored = matched
            } else { // from android device
                matched = ( fileMD5 == storedMD5 && fileDateTime == storedDateTime && fileSize == storedSize )
                matchedWithoutMD5 = ( fileDateTime == storedDateTime && fileSize == storedSize )
            }
        }
    }
    
    public var matched:Bool = false
    public var matchedWithoutMD5:Bool = false
    public var checksumMode:ChecksumMode = .Rough
    public var stored:Bool = false
    public var deviceFile:Codable?
    public var folder:String = ""
    
    public init(filename:String, path:String){
        self.filename = filename
        self.path = path
    }
    
    public init(filename:String, path:String, md5:String){
        self.filename = filename
        self.path = path
        self.fileMD5 = md5
    }
}

public enum MobileType:Int {
    case Android
    case iPhone
    case Unknown
}

public struct PhoneDevice {
    public var type:MobileType
    public var deviceId:String = ""
    public var manufacture:String = ""
    public var model:String = ""
    public var name:String = ""
    public var iccid:String = ""
    public var meid:String = ""
    public var totalSize:String = ""
    public var availSize:String = ""
    public var usedPercent:String = ""
    
    public init(type:MobileType, deviceId:String, manufacture:String, model:String) {
        self.type = type
        self.deviceId = deviceId
        self.manufacture = manufacture
        self.model = model
    }
    
    // present as title in tree node
    public func represent() -> String {
        return PhoneDevice.represent(deviceId: deviceId, name: name, manufacture: manufacture, model: model, type: type)
    }
    
    public static func represent(deviceId:String, name:String, manufacture:String, model:String, type:MobileType) -> String {
        var summary = ""
//        if totalSize != "" {
//            summary = "\(availSize) / \(totalSize), used \(usedPercent)"
//        }else {
            summary = deviceId
//        }
        if name != "" {
            let recognizedModel = CameraModelRecognizer.recognize(maker: manufacture, model: model)
            return "\(name) (\(manufacture) \(recognizedModel)) [\(summary)]"
            
        }
        if model != "" && manufacture != "" {
            let recognizedModel = CameraModelRecognizer.recognize(maker: manufacture, model: model)
            return "\(manufacture) \(recognizedModel) [\(summary)]"
        }
        if deviceId != "" {
            if type == .Android {
                return "Android \(deviceId)"
            }
            if type == .iPhone {
                return "iPhone \(deviceId)"
            }
        }
        return "Unknown \(deviceId)"
    }
    
}
