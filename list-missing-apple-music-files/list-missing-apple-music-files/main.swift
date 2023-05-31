//
//  main.swift
//  list-missing-apple-music-files
//
//  Created by charlie on 31/05/2023.
//

import Foundation
import iTunesLibrary

CommandLine.arguments.removeFirst()

if CommandLine.arguments.count == 0
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
        print(error.description, error.localizedDescription)
    }
}
else
{
    for argument in CommandLine.arguments
    {
        print(argument)
    }
    
    // here I am going to assume that the argument will be the path to an Apple Music exported XML file
}
