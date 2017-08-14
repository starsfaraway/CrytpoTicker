//
//  MRObjectArchive.swift
//  CrytpoTicker
//
//  Created by Matthew Riley on 8/13/17.
//  Copyright © 2017 Matthew Riley. All rights reserved.
//

import Foundation

class MRObjectArchive: NSObject {

    class func filePath(withExtension: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDirectory = paths[0]
        let path = docDirectory + "/" +  withExtension
        return path
    }
    
    class func saveDataInArchive(data : Data, withExtension: String) {
        let path = MRObjectArchive.filePath(withExtension: withExtension)
        NSKeyedArchiver.archiveRootObject(data, toFile: path)
    }
    
    class func retrieveDataFromArchive(fromExtension : String) -> Data? {
        let path = MRObjectArchive.filePath(withExtension: fromExtension)
        if let retval =  NSKeyedUnarchiver.unarchiveObject(withFile: path) as? Data {
            return retval
        }else{
            return nil
        }
        
    }
}
