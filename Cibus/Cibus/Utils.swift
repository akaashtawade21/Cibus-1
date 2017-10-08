//
//  Utils.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Utils {
    static let googleCloudVisionApiKey: String = "AIzaSyCJcNHRyp1dggd6gipOE5NdLbbRBrWEOkY"
    static let googleCloudVisionApiRoot: String = "https://vision.googleapis.com/v1/images:annotate"
    static let googleCloudVisionRootWithKey: String = "\(Utils.googleCloudVisionApiRoot)/?key=\(Utils.googleCloudVisionApiKey)"
    static let flickrApiKey: String = "605614800129c1a70e3ef5ce7c9c1b06"
    static let flickrApiSecret: String = "4773c59a31026a61"
    static let rootFlaskUrl: String = "http://food-saver-vmcool09.c9users.io:8080"
    
    static func postIngredientImage(uid: String, image: UIImage, callback: @escaping () -> ()) {
        let encodedImageString = UIImagePNGRepresentation(image)?.base64EncodedString(options: .lineLength64Characters)
        
        let body = [
            "requests": [
                [
                    "image":[
                        "content": encodedImageString
                    ], "features": [
                        [
                            "type":"LABEL_DETECTION"
                        ]
                    ],
                    "imageContext" : [
                        "languageHints" : [
                            "en"
                        ]
                    ]
                ]
            ]
        ]
        
        let headers = [
            "Content-Type": "application/json"
        ]

        var req: URLRequest!
        do {
            req = try URLRequest(url: googleCloudVisionRootWithKey, method: HTTPMethod.post, headers: headers)
            req.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print(error)
        }
        
        Alamofire.request(req).responseJSON { (response) in
            if let data = response.result.value {
                do {
                    let endpoint = rootFlaskUrl + "/item/recognize/\(uid)"
                    var parsedData = JSON(data).rawString()
                    var req2: URLRequest! = try URLRequest(url: endpoint, method: HTTPMethod.post, headers: headers)
                    req2.httpBody = parsedData?.data(using: .utf8)
                    
                    Alamofire.request(req2).response(completionHandler: { (response) in
                        callback()
                    })
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func postReceiptImage(uid: String, image: UIImage, callback: @escaping (_ newIngredientsList: [Ingredient]) -> (Void)) {
        
        // Get Google Vision's OCR API to process the image and pass it on to the flask server.
        let encodedImageString = UIImagePNGRepresentation(image)?.base64EncodedString(options: .lineLength64Characters)
        
        let body = [
            "requests": [
                [
                    "image":[
                        "content": encodedImageString
                    ], "features": [
                        [
                        "type":"TEXT_DETECTION",
                        "maxResults":1
                        ]
                    ]
                ]
            ]
        ]
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        
        var req: URLRequest!
        do {
            req = try URLRequest(url: googleCloudVisionRootWithKey, method: HTTPMethod.post, headers: headers)
            req.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print(error)
        }
        
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // send the data to Google to be handled
        Alamofire.request(req).responseData { (response) in
            if let data = response.result.value {
                do {
                    var parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    var newDataOne = parsedData["responses"] as! [Any]
                    var newDataTwo = newDataOne[0] as! [String:Any]
                    var newDataThree = newDataTwo["textAnnotations"] as! [Any]
                    var newDataFour = newDataThree[0] as! [String:Any]
                    let description = newDataFour["description"] as! String
                    print(description)
                    
                    let endpoint = rootFlaskUrl + "/receipt/add/\(uid)"
                    let body2 = description
                    var req2: URLRequest!
                    do {
                        req2 = try URLRequest(url: endpoint, method: HTTPMethod.post, headers: headers)
                        // working
                        // req2.httpBody = try JSONSerialization.data(withJSONObject: body2, options: [])
                        req2.httpBody = body2.data(using: .utf8)
                    } catch {
                        print(error)
                    }
                    req2.setValue("application/json", forHTTPHeaderField: "Content-Type")

                    // this api call gets the data from the flask server and sends it back. recipe and ingredient data.
                    Alamofire.request(req2).responseJSON { response in
                        print(response.data ?? "no data")
                        if let json = response.result.value {
                            print("JSON: \(json)")
                            var ingredientsList: [Ingredient] = []
                            
                            var newJson = JSON(json)
                            for ingredient in newJson["ingredient"] {
                                var ingredArr = ingredient
                                
                                // ingredientsList.append(Ingredient(ingredientJson: ingredient))
                            }
                            callback(ingredientsList)
                        }
                        print(response.description)
                        print(response.debugDescription)
                    }
                    
                } catch {
                    print(error)
                }
                

            }
        }
    }
    
    static func getIngredientsList(uid: String, callback: @escaping ([Ingredient]) -> ()) {
        Alamofire.request(rootFlaskUrl + "/ingredients/list/\(uid)").responseJSON { (response) in
            if let json = response.result.value {
                var swiftyJson = JSON(json)
                var ingredientsJsons = swiftyJson["ingredients"].arrayObject as! [[String:Any]]
                var newIngredients: [Ingredient] = []
                for obj in ingredientsJsons {
                    newIngredients.append(
                        Ingredient(
                            ingredientName: obj["ingredient_name"] as! String,
                            ingredientPhotoUrl: obj["image_url"] as! String,
                            expirationDays: obj["expiry_days"] as! Int
                        )
                    )
                }
                callback(newIngredients)
            }
        }
    }
    
    static func getRecipesList(uid: String, callback: @escaping ([Recipe]) -> ()) {
        Alamofire.request(rootFlaskUrl + "/recipes/list/\(uid)").responseJSON { (response) in
            if let json = response.result.value {
                var swiftyJson = JSON(json)
                var recipesJsons = swiftyJson["recipes"].arrayObject as! [[String:Any]]
                var newRecipes: [Recipe] = []
                for obj in recipesJsons {
                    newRecipes.append(Recipe(json: obj))
                }
                callback(newRecipes)
            }
        }
    }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
