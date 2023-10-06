//
//  main.swift
//  ServerSimulator
//

import Foundation
import Swifter


let semaphore = DispatchSemaphore(value: 0)
do {
//    let server = demoServer(Bundle.main.resourcePath!)
    let server = HttpServer()
    
    // image file
    let imagePath = (#file as NSString).deletingLastPathComponent.appending("/images")
    server["/image/:path"] = shareFilesFromDirectory(imagePath)
    server["/video/:path"] = shareFilesFromDirectory(imagePath)
    
    // 홈 탭
    server.GET["/home"] = { request in
        guard let json = jsonObject(for: Home.make()) else {
            return .notFound
        }
        
        return .ok(.json(json))
    }
    
    server.GET["/live"] = { request in
        guard
            let json = jsonObject(for: Live.make(sortByPopular: request.params["sort"] == "start")) else {
            return .notFound
        }
        
        return .ok(.json(json))
    }
    
    // 영상
    server.GET["/video"] = { request in
        guard let json = jsonObject(for: Video.make()) else {
            return .notFound
        }
        
        return .ok(.json(json))
    }
    
    // my 탭
    server.GET["/my/bookmark"] = { request in
        guard let json = jsonObject(for: Bookmark.make()) else {
            return .notFound
        }
        
        return .ok(.json(json))
    }
    
    server.GET["/my/favorite"] = { request in
        guard let json = jsonObject(for: Favorite.make()) else {
            return .notFound
        }
        
        return .ok(.json(json))
    }
    try server.start()
    semaphore.wait()
} catch {
    print("error", error.localizedDescription)
    semaphore.signal()
}
















//func test() {
//
//    Task {
//        let paths = [
//            "/home",
//            "/live",
//            "/video",
//            "/my/bookmark",
//            "/my/favorite"
//        ]
//
//        for path in paths {
//            do {
//                let request = URLRequest(url: .init(string: "http://localhost:8080\(path)")!)
//                let (data, _) = try await URLSession.shared.data(for: request)
//                let path = (#file as NSString).deletingLastPathComponent.appending("/").appending((path as NSString).lastPathComponent).appending(".json")
//                try data.write(to: .init(filePath: path))
//                let jsonString = String.init(data: data, encoding: .utf8)
//                print("success \(jsonString)")
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//
//    }
//}
//
