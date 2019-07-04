//
//  TAStorage.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 08/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation

class TAStorage {

private let kTAMainFolder = "TAMainFolder"
private let kClientsInfoFolder = "TAClientsInfo"
private let kClientIdsFile = "TAClients.json"
private let kClientsKey = "clients"
    
    
    static let instance = TAStorage()
    
    private init(){
        createClientDirectoryIfNeed()
    }
    
    private func createClientDirectoryIfNeed() {
        
        let directory = self.clientDirectory()

        if (!FileManager.default.fileExists(atPath: directory.absoluteString)) {
            do {
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Create dir failed: \(error)")
            }
        }
        
    }

    func setClients(_ clients: Array<Client>) {
        
        let clientsFileUrl = self.clientDirectory().appendingPathComponent(kClientIdsFile, isDirectory: false)
        
        //When will drop ObjC TestApp support - swich to archiving with Codable interface
//        do {
//            let data = try PropertyListEncoder().encode(clients)
//            let success = NSKeyedArchiver.archiveRootObject(data, toFile: clientsFileUrl.path)
//            print("Clients Save : ", success ? "Succeeded" : "Failed")
//        } catch {
//            print("Clients Save : Failed")
//        }
        
        let params = NSMutableDictionary()
        params[kClientsKey] = clients;
        
        let success = NSKeyedArchiver.archiveRootObject(params, toFile: clientsFileUrl.path)
        print("Clients Save : ", success ? "Succeeded" : "Failed")
    }

    func getClients() -> Array<Client> {
        
        let path = self.clientDirectory().appendingPathComponent(kClientIdsFile, isDirectory: false)
        let unarchivedObj = NSKeyedUnarchiver.unarchiveObject(withFile: path.path)
        
        //When will drop ObjC TestApp support - swich to archiving with Codable interface
        // Check if was archived with Codable as Array
//        if let data = unarchivedObj as? Data {
//            do {
//                let decoder = PropertyListDecoder()
//                clients = try decoder.decode(Array<Client>.self, from: data)
//            } catch {
//                print("Retrieve Failed")
//            }
//        }
        // Fallback to NSCoding with Dict
//        else
        
        if let dict = unarchivedObj as? Dictionary<String, Any>,
            let clients = dict[kClientsKey] as? Array<Client> {
            return clients
        
        } else {
            return Array()
        }
    }

    func addClient(_ newClient: Client)  {
        
        var clients = self.getClients()
        clients.append(newClient)
        self.setClients(clients)
    }
    
    func removeClient(_ clientToRemove: Client)  {
        
        var clients = self.getClients()
        
        let indexToRemove = clients.firstIndex(of: clientToRemove)
        if (indexToRemove != nil) {
            clients.remove(at: indexToRemove!)
        }
        
        self.setClients(clients)
    }

    // MARK: - Folders

    func appDirectory() -> URL {
        let appPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        
        return URL(fileURLWithPath: appPath)
    }
    
    func thrDirectory() -> URL {
        return self.appDirectory().appendingPathComponent(kTAMainFolder)
    }
    
    func clientDirectory() -> URL {
        return self.directory(withFolder: kClientsInfoFolder, inRoot: true)
    }
    
    func directory(withFolder: String) -> URL  {
        return self.directory(withFolder: withFolder, inRoot: false)
    }
    
    func directory(withFolder: String, inRoot: Bool) -> URL {
        
        let directory = inRoot ? self.thrDirectory() : self.clientDirectory()
        
        let directoryPath = directory.appendingPathComponent(withFolder, isDirectory: true)
        
        do {
            try FileManager.default.createDirectory(at: directoryPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Create directory error: \(error)")
        }
        
        return directoryPath;
    }
    
    
    // MARK: - Helpers
    
    func logContents(of: URL) {
        
        do {
            let dirContents = try FileManager.default.contentsOfDirectory(at: of, includingPropertiesForKeys: nil, options: [])
            for item in dirContents {
                
                print("Item = \(item)")
                
                if (item.hasDirectoryPath) {
                    logContents(of: item)
                }
            }
        } catch {
            print("Could not get dir contents: \(error)")
        }
    }
}
