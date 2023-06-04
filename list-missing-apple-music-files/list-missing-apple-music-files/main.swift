//
//  main.swift
//  list-missing-apple-music-files
//
//  Created by charlie on 31/05/2023.
//

import Foundation
import iTunesLibrary

if CommandLine.arguments.count == 1
{
    do
    {
        let library = try ITLibrary.init(apiVersion: "1.1")
        
        let fileManager = FileManager.default
        
        let items = library.allMediaItems
        
        for item: ITLibMediaItem in items
        {
            if item.location == nil
            {
                print(item.title, item.artist?.name ?? "", item.album.title ?? "", separator: " - ")
            }
            else
            {
                let location: URL = item.location ?? URL.init(string: "")!
                
                if !fileManager.fileExists(atPath: location.path)
                {
                    print(item.title, item.artist?.name ?? "", item.album.title ?? "", location.path, separator: " - ")
                }
            }
        }
    }
    catch let error as NSError
    {
        print(error.code)
        print(error.description)
        print(error.localizedDescription)
    }
}
else
{
    let path = CommandLine.arguments[1]
    
    let music = NSDictionary(contentsOfFile: path)
    let tracks: NSDictionary = music?.value(forKey: "Tracks") as! NSDictionary
    
    for (_, value) in tracks
    {
        let track : NSDictionary = value as! NSDictionary
        
        let title = track.value(forKey: "Name")
        let artist = track.value(forKey: "Artist")
        let album = track.value(forKey: "Album")
        
        let location = track.value(forKey: "Location")
        
        if location == nil
        {
            print(title ?? "", artist ?? "", album ?? "", separator: " - ")
        }
        else
        {
            let url: URL = URL.init(string: location as! String) ?? URL.init(string: "")!
            
            if !FileManager.default.fileExists(atPath: url.path)
            {
                print(title ?? "", artist ?? "", album ?? "", url.path, separator: " - ")
            }
        }
    }
}
