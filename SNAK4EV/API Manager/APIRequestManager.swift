//
//  APIRequestManager.swift
//  Food Order
//
//  Created by Apple on 09/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Alamofire

class APIRequestManager {
    
    static let sharedInstance = APIRequestManager()
    
    func login(param :Dictionary<String , AnyObject> , completion : @escaping(_ success : Bool , _ jsonObject : LoginModel?) -> ())
    {
        Globals.shared.dontShowmessage = false
        post(request: clientURLRequestPostMethod(path: RequestMethod.logIn.rawValue, params: param)) { (success, object) in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    completion(true, LoginModel.convertData(data: object as! Data))
                }else{
                    completion(false, LoginModel.convertData(data: object as! Data))
                }
            })
        }
    }
    
//    func testget(completion : @escaping(_ success : Bool , _ jsonObject : TestGetModel?) -> ())
//    {
//
//        let url = ""
//
//        get(request: clientURLRequestGetMethod(path: url)) { (success, object) in
//            DispatchQueue.main.async(execute: { () -> Void in
//                if success {
//                    completion(true, TestGetModel.convertData(data: object as! Data))
//                }else{
//                    completion(false, TestGetModel.convertData(data: object as! Data))
//                }
//            })
//        }
//    }
    
    private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    private func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }
    
    private func delete(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "DELETE", completion: completion)
    }
    
    private func clientURLRequestPostMethod(path: String, params: Dictionary<String , AnyObject>? = nil) -> NSMutableURLRequest {
        if params != nil {
            var paramString = ""
            var index : Int = 0
            for (key, value) in params! {
                index = index + 1
                let escapedKey = key
                let escapedValue = value
                if params!.count == index{
                    paramString += "\(escapedKey)=\(escapedValue)"
                }else{
                    paramString += "\(escapedKey)=\(escapedValue)&"
                }
            }
            return self.setRequestDatas(strUrl: baseURL+path, params: params as Any)
        }
        
        return NSMutableURLRequest()
    }
    
    private func clientURLRequestPostMethodGoogleAddress(path: String, params: Dictionary<String , AnyObject>? = nil) -> NSMutableURLRequest {
        if params != nil {
            var paramString = ""
            var index : Int = 0
            for (key, value) in params! {
                index = index + 1
                let escapedKey = key
                let escapedValue = value
                if params!.count == index{
                    paramString += "\(escapedKey)=\(escapedValue)"
                }else{
                    paramString += "\(escapedKey)=\(escapedValue)&"
                }
            }
            return self.setRequestDatas(strUrl: path, params: params as Any)
        }
        
        return NSMutableURLRequest()
    }
    
    
    func setRequestDatas(strUrl: String, params: Any)->NSMutableURLRequest{
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let jsonParams = String(data: jsonData, encoding: .utf8)!
        if PrintLog{
            print("Url:----->\(strUrl)")
            print("Params:----->\(jsonParams)")
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: strUrl)! as URL)
        if(TokenDetails.tokenModel?.responseObject?.token != nil){
            request.setValue(TokenDetails.tokenModel?.responseObject?.token, forHTTPHeaderField: "token")
            if PrintLog{
                print("token:----->\((TokenDetails.tokenModel?.responseObject?.token)!)")
            }
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params as Any, options: [])
        return request
    }
    
    private func clientURLRequestGetMethod(path: String) -> NSMutableURLRequest {
        let urlWithParams: NSString = baseURL+path as NSString
        print("Url:----->\(urlWithParams)")
        let urlStr  = urlWithParams.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        if(TokenDetails.tokenModel?.responseObject?.token != nil){
            request.setValue(TokenDetails.tokenModel?.responseObject?.token, forHTTPHeaderField: "token")
            if PrintLog{
                print("token:----->\((TokenDetails.tokenModel?.responseObject?.token)!)")
            }
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL)
        return request
    }
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        Globals.shared.dontShowmessage = true
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        DispatchQueue.main.async {
            //self.loaderDelegate?.Loader(isStart: true)
        }
        request.httpMethod = method
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 60
        urlconfig.timeoutIntervalForResource = 12
        
        //let session = URLSession(configuration: URLSessionConfiguration.default)
        let session = URLSession(configuration: urlconfig)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let  data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
                            let jsonResponse = String(data: jsonData, encoding: .utf8)!
                            if PrintLog{
                                print("Response-----> \(jsonResponse)")
                            }
                            var isMsgShow: Bool = false
                            var message = ""
                            if let msg: String = json["message"] as? String{
                                message = msg
                            }
                            if response.statusCode == 401{
                                isMsgShow = true
                            }
//                            if((dict.value(forKey: "email") as! String) == 1){
//                                if((dict.value(forKey: "message") as! String) == "Session Expired."){
//                                    DispatchQueue.main.async {
//                                        //Globals.shared.shareViewController.logout()
//                                    }
//                                }else{
//                                    isMsgShow = true
//                                }
//                                message = (dict.value(forKey: "message") as! String)
//                            }else{
//                                isMsgShow = true
//                                message = (dict.value(forKey: "message") as! String)
//                            }
                            if(isMsgShow && !Globals.shared.dontShowmessage && !Globals.shared.isloaderWithinButton){
                                DispatchQueue.main.async {
                                    Globals.shared.message = message
                                    Globals.shared.dontShowmessage = false
                                }
                            }
                        }
                    }
                    catch let error as NSError{
                        print("Error", error.localizedDescription)
                    }
                    completion(true, data as AnyObject?)
                    DispatchQueue.main.async {
                        //self.loaderDelegate?.Loader(isStart: false)
                    }
                }else
                {
                    if((response as? HTTPURLResponse)?.statusCode == 401){
                        DispatchQueue.main.async {
                            //self.loaderDelegate?.Loader(isStart: true)
                        }
                    }
                }
            }
        }.resume()
        
    }
    
}

extension APIRequestManager{
    // MARK: User Image Upload
    
    func userimgUpload(dict: NSDictionary,imgArray: NSMutableArray,type:HTTPMethod, completionHandler: @escaping (_ JSON : Any,_ error : NSString) -> ())
    {
        print(dict.value(forKey: "url") as! String)
        Alamofire.upload(
            multipartFormData: { multipartFormData in for i in 0..<imgArray.count{
                if(imgArray.count != 0){
                    let randomDouble = Double.random(in: 2.71828...3.14159)
                    multipartFormData.append((imgArray[i] as! UIImage).jpegData(compressionQuality: 0.7)!, withName: "file", fileName: "\(randomDouble).jpg", mimeType: "image/jpeg")
                }
            }
            
            },
            to: dict.value(forKey: "url") as! String,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let jsonResponse = response.result.value as? [String: Any] {
                            completionHandler(jsonResponse, "SUCCESS")
                        }else{
                            completionHandler((response.result.value as? [String: Any]), "Failure")
                        }
                        //Globals.shared.shareViewController.view.willRemoveSubview(self.circularProgressView)
                    }
                    upload.uploadProgress { progress in
                        self.imageUploadProgressing(progressValue: progress.fractionCompleted)
                    }
                case .failure( _):
                    completionHandler("FAILURE", "Failed")
                }
                
            })
    }
    
    func multipleimgUpload(dict: NSDictionary,images: [UIImage],type:HTTPMethod, isVideo: Bool = false, completionHandler: @escaping (_ JSON : Any,_ error : NSString) -> ())
    {
        print(dict.value(forKey: "url") as! String)
        //print(dict)
        Alamofire.upload(
            multipartFormData: { multipartFormData in for i in 0..<images.count{
                if(images.count != 0){
                    //                        var image = images[i]
                    //                        var imgData: NSData = NSData(data: UIImageJPEGRepresentation((image), 1)!)
                    //                        var imageSize: Int = imgData.count
                    //                        print("size of image in KB: \(Double(imageSize) / 1000.0) ")
                    let randomDouble = Double.random(in: 2.71828...3.14159)
                    
                    if(isVideo){
                        multipartFormData.append(images[i].jpegData(compressionQuality: 0.7)!, withName: "image[]", fileName: "\(randomDouble).jpg", mimeType: "image/jpeg")
                        multipartFormData.append(Globals.shared.videoPath, withName: "file[]", fileName: "\(Globals.shared.getCurrentDateTimeToImageUpload()).mp4", mimeType: "video/mp4")
                    }else{
                        
                        multipartFormData.append(images[i].jpegData(compressionQuality: 0.7)!, withName: "file[]", fileName: "\(randomDouble).jpg", mimeType: "image/jpeg")
                    }
                }
            }
            },
            to: dict.value(forKey: "url") as! String,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let jsonResponse = response.result.value as? [String: Any] {
                            completionHandler(jsonResponse, "SUCCESS")
                        }else{
                            completionHandler((response.result.value as? [String: Any]), "Failure")
                        }
                        //Globals.shared.shareViewController.view.willRemoveSubview(self.circularProgressView)
                    }
                    upload.uploadProgress { progress in
                        self.imageUploadProgressing(progressValue: progress.fractionCompleted)
                    }
                case .failure( _):
                    completionHandler("FAILURE", "Failed")
                }
                
            })
    }
    
    func imageUploadProgressing(progressValue: Double) {
        let count = progressValue.round(to: 2)
        //self.imgProgressDelegate?.imageUploadProgress(isStart: true, count: CGFloat(count*100))
        //progressRing.progress = CGFloat(count*100)
    }
}
