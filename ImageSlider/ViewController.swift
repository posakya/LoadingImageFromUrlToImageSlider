//
//  ViewController.swift
//  ImageSlider
//
//  Created by Bibek on 12/21/17.
//  Copyright © 2017 Roshan. All rights reserved.
//

import UIKit
import SDWebImage

struct jsonData : Decodable {
    let Image : String
}

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var jsonDatas = [jsonData]()
    
//   var iconArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.frame = view.frame
        
       // iconArray = [UIImage(named:"image1")!,UIImage(named:"image2")!,UIImage(named:"image4")!,UIImage(named:"image3")!]
        
        
        
        let jsonUrl = "http://appybite.com/Vedis/Vedis/gallery_api.php"
        let url = URL(string: jsonUrl)

        print("URL :", url!)

        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in

            do {


                self.jsonDatas = try JSONDecoder().decode([jsonData].self, from: data!)

                print("Array ", self.jsonDatas.count)

                for i in 0..<self.jsonDatas.count {


                    let imageView = UIImageView()
                    let xPos = self.view.frame.width * CGFloat(i)
                    let imageUrl: String = "http://appybite.com/Vedis/Vedis/Image/"+self.jsonDatas[i].Image
                    print("DownloadImage",imageUrl)
                    imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                    imageView.contentMode = .scaleAspectFit
                    imageView.frame = CGRect(x: xPos, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
                    
                    self.scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(i + 1)
                    self.scrollView.addSubview(imageView)

                }

            }
            catch {

                print("Error")

            }

            }.resume()

        
//        for i in 0..<iconArray.count {
//
//            let imageView = UIImageView()
//            imageView.image = iconArray[i]
//            imageView.contentMode = .scaleAspectFit
//            let xPos = self.view.frame.width * CGFloat(i)
//            imageView.frame = CGRect(x: xPos, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
//            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
//            scrollView.addSubview(imageView)
//
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

