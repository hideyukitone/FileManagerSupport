//
//  FileManagerSupport.swift
//  FileManagerSupport
//
//  Created by 大國嗣元 on 2017/06/15.
//  Copyright © 2017年 hideyuki okuni. All rights reserved.
//

import Foundation
import UIKit

class FileManagerSupport {
    static func image(folderNameInDocumentDirectory folderName: String, fileName: String) -> UIImage? {
        guard let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }
        
        let filePath = dir + "/\(folderName)/" + fileName
        
        return UIImage(contentsOfFile: filePath)
    }
    
    static func save(image: UIImage, folderNameInDocumentDirectory folderName: String, fileName: String) -> Bool {
        guard let data = UIImagePNGRepresentation(image)
            , let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                return false
        }
        
        let fileManager = FileManager.default
        
        let folderPath = dir + "/" + folderName
        
        if !fileManager.fileExists(atPath: folderPath) {
            do {
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            }catch {
                return false
            }
        }
        
        let filePath = folderPath + "/" + fileName
        
        do {
            try data.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
            return true
        }catch {
            return false
        }
    }
    
    static func delete(folderNameInDocumentDirectory folderName: String, fileName: String) -> Bool {
        do {
            guard let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                return false
            }
            
            let filePath = dir + "/\(folderName)/" + fileName
            
            try FileManager.default.removeItem(atPath: filePath)
            
            return true
        }catch {
            return false
        }
    }
}
