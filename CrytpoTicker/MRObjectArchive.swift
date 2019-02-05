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

        do {
            let securedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            if let url = URL(string: path) {
                try securedData.write(to: url)}
        }catch {
            //Data could not be saved. Not a fatal error
        }
    }
    
    class func retrieveDataFromArchive(fromExtension : String) -> Data? {
        let path = MRObjectArchive.filePath(withExtension: fromExtension)
        guard let url = URL(string: path) else {
            return nil}
        do {
            let securedData = try Data.init(contentsOf: url)
            if let retval =  try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(securedData) as? Data {
                return retval}
        }
        catch {
            return nil
        }
        
        return nil
        
    }
}
