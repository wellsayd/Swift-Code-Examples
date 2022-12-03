//
//  ViewController.swift
//  googleReviews
//
//  Created by bwells on 11/22/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var googleApiKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            if let reviewData = await self.getGoogleReviews() {
                self.setReviewSubview(content: GoogleReviews(reviewData: reviewData))
            } else {
                self.setReviewSubview(content: NoReviews())
            }
        }
        
    }

    
    func getGoogleReviews() async -> ResultData? {
        
        var data: (status: ApiStatus,  data: Any)
        
        if(googleApiKey != "") {
            let apiCall = ApiCall()
            data = await apiCall.makeCall("https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJ7aZjk3uVuokRV-RK8J0MIOw&key=" + googleApiKey)

        } else {
            data = readLocalJSONFile()
        }

        if(data.status == .success) {
            do {
                let json = try JSONDecoder().decode(ResultData.self, from: data.data as! Data)
                return  (json)
            } catch {
                return (nil)
            }
                      
        }
        return (nil)
    }
    
    func setReviewSubview(content: some View){
        let child = UIHostingController(rootView: content)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(child.view)
        child.view.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10).isActive = true
        child.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18).isActive = true
    }
    
    
    func readLocalJSONFile() -> (status: ApiStatus,  data: Any)  {
        do {
            if let filePath = Bundle.main.path(forResource: "./GoogleReviewsData", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return (status: ApiStatus.success,  data: data)
            }
        } catch {
            return (status: ApiStatus.error,  data: "")
        }
        return (status: ApiStatus.error,  data: "")
    }
    
    
}

