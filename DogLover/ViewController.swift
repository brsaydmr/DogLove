//
//  ViewController.swift
//  DogLover
//
//  Created by Barış Aydemir on 3.11.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var response:DogModel?
    var dogAPIURL = "https://dog.ceo/api/breeds/image/random"
    
    @IBOutlet weak var clickLabel: UILabel!
    var clickCounter:Int = 0
    
    @IBOutlet weak var dogImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        clickLabel.isHidden = true
        fetchDogImage()
    }
    
        // MARK: - ALAMOFİRE RESPONSEDECODABLE

    func fetchDogImage() {
        AF.request(dogAPIURL).responseDecodable(of: DogModel.self) { response in
            switch response.result {
            case .success(let dogData):
                if let imageUrl = URL(string: dogData.message) {
                    AF.request(imageUrl).responseData { response in
                        if let imageData = response.data {
                            self.dogImg.image = UIImage(data: imageData)
                        }
                    }
                }
            case .failure(let error):
                print("Network request failed with error: \(error)")
            }
        }
    }

    // MARK: - ALAMOFİRE RESPONSEJSON
//    func fetchDogImage() {
//        AF.request(dogAPIURL).responseJSON { response in
//            switch response.result {
//            case .success:
//                if let data = response.data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let dogData = try decoder.decode(DogModel.self, from: data)
//
//                        if let imageUrl = URL(string: dogData.message) {
//                            AF.request(imageUrl).responseData { response in
//                                if let imageData = response.data {
//                                    self.dogImg.image = UIImage(data: imageData)
//                                }
//                            }
//                        }
//                    } catch {
//                        print("JSON decoding error: \(error)")
//                    }
//                }
//            case .failure(let error):
//                print("Network request failed with error: \(error)")
//            }
//        }
//    }
    // MARK: - URLSESSİON

 //   func fetchDogImage() {
 //       if let url = URL(string: dogAPIURL) {
 //           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
 //               if let error = error {
 //                   print("Error: \(error)")
 //               } else if let data = data {
 //                   do {
 //                       let decoder = JSONDecoder()
 //                       let dogData = try decoder.decode(DogModel.self, from: data)
 //
 //                       if let imageUrl = URL(string: dogData.message) {
 //                           // Köpek fotoğrafını ekranda göster
 //                           if let imageData = try? Data(contentsOf: imageUrl) {
 //                               DispatchQueue.main.async {
 //                                   self.dogImg.image = UIImage(data: imageData)
 //                               }
 //                           }
 //                       }
 //                   } catch {
 //                       print("JSON decoding error: \(error)")
 //                   }
 //               }
 //           }
 //           task.resume()
 //       }
 //   }
 //
    
    @IBAction func buttonTapped(_ sender: Any) {
        clickCounter += 1
        if clickCounter < 5 {
            fetchDogImage()
        }else{
            print("Maximum tıklanma sayısına ulaşıldı.")
            clickLabel.text = "Bu kadar köpek sevgisi yeter :)"
            clickLabel.isHidden = false
        }
    }
}
