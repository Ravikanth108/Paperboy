//
//  TopNewsViewController.swift
//  Paperboy
//
//  Created by sai Nikhil on 2019-12-07.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage

class TopNewsViewController: UIViewController, IndicatorInfoProvider, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
   
    var itemInfo: IndicatorInfo = "News"
    var titleArr = [String]()
    var imgURLArr = [String]()
    var titleArr1 = [String]()
    var imgURLArr1 = [String]()
    var urlArr = [String]()
    var urlArr1 = [String]()
    var counter = 0
    var timer = Timer()
    
    private let refreshControl = UIRefreshControl()


    @IBOutlet weak var BannerCollectionView: UICollectionView!
    @IBOutlet weak var NewsTableView: UITableView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews()
        getHeadLines()
        NewsTableView.addSubview(refreshControl)
        refreshControl.tintColor = UIColor.systemRed
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.bannerTimer), userInfo: nil, repeats: true)
        }

    }
    @objc private func refreshNews(_ sender: Any){
           getNews()
           getHeadLines()
       }
    @objc func bannerTimer(){
         
     if counter < imgURLArr.count {
             let index = IndexPath.init(item: counter, section: 0)
             self.BannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageControl.currentPage = counter
             counter += 1
         } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.BannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             pageControl.currentPage = counter
             counter = 1
         }
     }
    
    func getNews() {
     let urlString = "https://newsapi.org/v2/top-headlines?country=ca&apiKey=7e2fa404249f4a03b625964089eaeefd"
                    
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
                            
                        guard let title = elem["title"] as? String
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
                             
                             self.urlArr1.append(url)
                             print("Titles:\(self.titleArr)")
                             self.BannerCollectionView.reloadData()
                         }
                         print("imgArrCount:\(self.imgURLArr.count)")
                         self.pageControl.numberOfPages = self.imgURLArr.count
                         self.pageControl.currentPage = 0
                         
                     } catch let parsingError {
                           print("Error", parsingError)
                      }
                         self.refreshControl.endRefreshing()
         }
                    }
                    task.resume()
         
         }
    
    func getHeadLines(){
     let urlString = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=7e2fa404249f4a03b625964089eaeefd"
        
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
                                 self.imgURLArr1.append(imgURL)
                             }
                            else{
                                self.imgURLArr1.append("https://place-hold.it/414x250/gray.jpg")
                            }
                            guard let url = elem["url"] as? String else {
                                                         return
                                                       }
                             self.titleArr1.append(title)
                             
                             self.urlArr.append(url)
                             self.NewsTableView.reloadData()
                            
                             print("Titles:\(self.titleArr)")
                         }
                     } catch let parsingError {
                           print("Error", parsingError)
                      }
         }
                    }
                    task.resume()
         
         }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titleArr1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopNewsTableViewCell", for: indexPath) as! TopNewsTableViewCell
        cell.titleLbl.text = self.titleArr1[indexPath.row]
        cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgView?.sd_setImage(with: URL(string: imgURLArr1[indexPath.row]), placeholderImage:UIImage(named:"placeholder-image.jpg"))
        cell.imgView.clipsToBounds = true
        cell.imgView.layer.masksToBounds = true
         return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.url = urlArr[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
  
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return self.imgURLArr.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopNewsCollectionViewCell", for: indexPath) as! TopNewsCollectionViewCell
        
        
//        let view = UIView(frame: cell.imgView.frame)
//
//        var gradientLayer = CAGradientLayer()
//        if let sublayers = view.layer.sublayers {
//            for sublayer in sublayers {
//                if let gLayer = sublayer as? CAGradientLayer {
//                    gradientLayer = gLayer
//                    break
//                }
//            }
//        }
//
//        gradientLayer.frame = view.frame
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
//
//          view.layer.insertSublayer(gradientLayer, at: 0)
//
//           cell.imgView.addSubview(view)
//
//           cell.imgView.bringSubviewToFront(view)
           cell.titleLbl.text = titleArr[indexPath.row]
           cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
           cell.imgView?.sd_setImage(with: URL(string: imgURLArr[indexPath.row]), placeholderImage:UIImage(named:"placeholder-image.jpg"))
           cell.setNeedsDisplay()
           return cell
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
           vc.url = urlArr1[indexPath.row]
           self.present(vc, animated: true, completion: nil)
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = BannerCollectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
    
      func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
             return itemInfo

         }
    

}
//
//extension UIView{
//    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
//        clipsToBounds = true
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
//        gradientLayer.frame = self.bounds
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//        print(gradientLayer.frame)
//        self.layer.insertSublayer(gradientLayer, at: 0)
//    }
//}
