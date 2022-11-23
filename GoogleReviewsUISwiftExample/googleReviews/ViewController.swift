//
//  ViewController.swift
//  googleReviews
//
//  Created by bwells on 11/22/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            let reviewData = await self.getGooglePlacesId()
            let rating:Double = reviewData.rating
            let wholeNum:Int = Int(reviewData.rating.rounded(.towardZero))
            let remainderNum: Double = reviewData.rating.truncatingRemainder(dividingBy: 1)
            let ratingStars = RatingStars(rating: rating, wholeNum: wholeNum, remainderNum: remainderNum, reviews: reviewData.reviews)
            let child = UIHostingController(rootView: ratingStars)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(child.view)
            child.view.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10).isActive = true
            child.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 18).isActive = true
        }
        
        
    }

    
    func getGooglePlacesId() async -> (rating: Double, reviews: [Reviews]) {
        
            let apiCall = ApiCall()
            let data = try await apiCall.makeCall("https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJ7aZjk3uVuokRV-RK8J0MIOw&key=" + yourGoogleApiKeyHere)

            if(data.status == .success) {
                do {
                    let json = try JSONDecoder().decode(Result.self, from: data.data as! Data)
                    return  (rating: json.result.rating, reviews: json.result.reviews)
                } catch {
                    return (rating: 0, reviews: [])
                }
                          
            }

        
        
        return (rating: 0, reviews: [])

    }
    
    

}

