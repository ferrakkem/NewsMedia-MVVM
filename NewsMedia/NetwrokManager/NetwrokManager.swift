//
//  NetwrokManager.swift
//  NewsMedia
//
//  Created by Ferrakkem Bhuiyan on 2020-12-04.
//

import Foundation

struct EndPointDetails {
    static let newEndPoint = ""
}

class NetwrokManager{
    private var dataTask: URLSessionDataTask?
    //AFNet
    //Alomfire
    
    func getNewsData(completion: @escaping(Result<[NewsModel], Error>) -> Void){
        let basicUrl = EndPointDetails.newEndPoint
    
        guard let url = URL(string: basicUrl) else{
            return
        }
        
        //print("URL****** \(url)")
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Now Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([NewsModel].self, from: data)
                //print(jsonData)
                // Back to the main thread
                DispatchQueue.main.async {
                    //print("error***")
                    completion(.success(jsonData))
                }
            } catch let error {
                print("##error")
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
        
}
