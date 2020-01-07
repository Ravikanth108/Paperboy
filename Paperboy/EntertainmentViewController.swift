//
//  EntertainmentViewController.swift
//  Paperboy
//
//  Created by sai Nikhil on 2019-12-06.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit
import SDWebImage
import XLPagerTabStrip

class EntertainmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var newsLbl: UILabel!
    @IBOutlet weak var newsBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var titleArr = [String]()
       var imgURLArr = [String]()
       var urlArr =  [String]()
       var itemInfo: IndicatorInfo = "Entertainment"
    private let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView(frame: imgView.frame)

        let gradient = CAGradientLayer()

        gradient.frame = view.frame

        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]

        gradient.locations = [0.0, 1.0]

        view.layer.insertSublayer(gradient, at: 0)

        imgView.addSubview(view)

        imgView.bringSubviewToFront(view)

        getNews()
        tableView.addSubview(refreshControl)
        refreshControl.tintColor = UIColor.systemRed
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
    }
    @objc private func refreshNews(_ sender: Any){
           getNews()
       }
    @IBAction func newsClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.url = urlArr[0]
        self.present(vc, animated: true, completion: nil)
    }
    
    func getNews(){
         let urlString = "https://newsapi.org/v2/top-headlines?country=ca&category=entertainment&apiKey=7e2fa404249f4a03b625964089eaeefd"
            
                 let URL: Foundation.URL = Foundation.URL(string: urlString)!
                 let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
                     request.httpMethod = "GET"
                 let session = URLSession.shared
                        let task = session.dataTask(with: request as URLRequest){ (data, response, error) in
                         print("data:\(String(describing: data))")
                            guard data != nil else{
                                print("data nil:\(String(describing: data))")
                                return
                            }
                         
                         DispatchQueue.main.async {
                     
                         do{
                               let jsonResponse = try JSONSerialization.jsonObject(with:
                                 data!, options: []) as? [String: Any]
                             print("response:\(String(describing: jsonResponse))")
        
                             guard let articles = jsonResponse?["articles"] as? [[String: Any]]
                             else {return}
                             print("Article:\(articles)")
                             for elem in articles{
                                
                            guard let title  = elem["title"] as? String
                             else{return}
                     if let imgURL =  elem["urlToImage"] as? String  {
                                             self.imgURLArr.append(imgURL)
                                         }
                                         else {
                                             self.imgURLArr.append("https://place-hold.it/414x250/gray.jpg")
                                         }
                                guard let url = elem["url"] as? String else {
                                                             return
                                                           }
                                 self.titleArr.append(title)
    //                             self.imgURLArr.append(imgURL)
                                 self.urlArr.append(url)
                                 self.tableView.reloadData()
                                
                                 print("businessTitles:\(self.titleArr)")
                             }
                            self.newsLbl.text = self.titleArr[0]
                            let imageUrl =  NSURL(string: self.imgURLArr[0])! as URL
                            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: imageUrl, placeholderImage:UIImage(named:"placeholder-image.jpg"))
                         } catch let parsingError {
                               print("Error", parsingError)
                          }
                            self.refreshControl.endRefreshing()
             }
                        }
                        task.resume()
             }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return titleArr.count - 1
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "EntertainmentTableViewCell", for: indexPath) as! EntertainmentTableViewCell
           cell.titleLbl.text = titleArr[indexPath.row + 1]
           cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
           cell.imgView.sd_setImage(with: URL(string: imgURLArr[indexPath.row + 1]), placeholderImage:UIImage(named:"placeholder-image.jpg"))
           return cell
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
           vc.url = urlArr[indexPath.row + 1]
           self.present(vc, animated: true, completion: nil)
       }
        
        func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
            return itemInfo
        }
  

}
