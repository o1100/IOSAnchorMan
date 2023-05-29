////
////  bionicApi.swift
////  anchor
////
////  Created by Vincent Jin on 2022/6/22.
////
//import Foundation
//final class Bionic{                            //this class gets data from the API
//
//let headers = [
//    "content-type": "application/x-www-form-urlencoded",
//    "X-RapidAPI-Key": "f9dc88b713mshe746dab1c21c03dp1b5991jsn2f66233eca0c",
//    "X-RapidAPI-Host": "bionic-reading1.p.rapidapi.com"
//]
//
//let postData = NSMutableData(data: "content=Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.".data(using: String.Encoding.utf8)!)
//postData.append("&response_type=html".data(using: String.Encoding.utf8)!)
//postData.append("&request_type=html".data(using: String.Encoding.utf8)!)
//postData.append("&fixation=1".data(using: String.Encoding.utf8)!)
//postData.append("&saccade=10".data(using: String.Encoding.utf8)!)
//
//let request = NSMutableURLRequest(url: NSURL(string: "https://bionic-reading1.p.rapidapi.com/convert")! as URL,
//                                        cachePolicy: .useProtocolCachePolicy,
//                                    timeoutInterval: 10.0)
//request.httpMethod = "POST"
//request.allHTTPHeaderFields = headers
//request.httpBody = postData as Data
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//    if (error != nil) {
//        print(error)
//    } else {
//        let httpResponse = response as? HTTPURLResponse
//        print(httpResponse)
//    }
//})
//
//dataTask.resume()
//
//}
