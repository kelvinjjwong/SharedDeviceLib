//
//  CameraModelRecognizer.swift
//
//  Created by Kelvin Wong on 2019/10/19.
//  Copyright © 2019 nonamecat. All rights reserved.
//

import Foundation

public class CameraModelRecognizer {
    
    public static let models:[String : [String : String]] = [
        "HUAWEI" : [
            "H60" : "Honor 6",
            "FRD" : "Honor 8",
            "KNT" : "Honor V8",
            "STF" : "Honor 9",
            "DUK" : "Honor V9",
            "COL" : "Honor 10",
            "BKL" : "Honor V10",
            "EVA" : "Perfect 9",
            "VIE" : "Perfect 9 Plus",
            "VTR" : "Perfect 10",
            "VKY" : "Perfect 10 Plus",
            "EML" : "Perfect 20",
            "CLT" : "Perfect 20 Plus",
            "MHA" : "Mate 9",
            "LON" : "Mate 9 Pro",
            "ALP" : "Mate 10",
            "BLA" : "Mate 10 Pro",
            "WAS" : "Nova Young"
        ]
    ]
    
    public static func recognize(maker:String, model:String) -> String{
        guard maker != "" && model != "" else {return model}
        for m in models.keys {
            if maker == m {
                //self.logger.log("Recognized maker \(m), trying to get name of model \(model)")
                for mm in models[m]! {
                    if model.starts(with: mm.key) {
                        return mm.value + " (" + model + ")"
                    }
                }
                break
            }
        }
        return model
    }
    
    public static func getMarketName(maker:String, model:String) -> String{
        guard maker != "" && model != "" else {return model}
        for m in models.keys {
            if maker == m {
                //self.logger.log("Recognized maker \(m), trying to get market name of model \(model)")
                for mm in models[m]! {
                    if model.starts(with: mm.key) {
                        //self.logger.log("Got market name [\(mm.value)] of [\(m) \(model)]")
                        return mm.value
                    }
                }
                break
            }
        }
        return ""
    }
}
