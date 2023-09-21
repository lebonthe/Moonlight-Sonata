//
//  ViewController.swift
//  Moonlight Sonata
//
//  Created by Min Hu on 2023/9/6.
//

import UIKit
import WebKit // 使用 WKWebView 需要先輸入 WebKit

class ViewController: UIViewController {

    // 顯示 YouTube 電影連結
    @IBOutlet weak var movieWebView: WKWebView!
    
    // segmentedControl
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    // 電影海報
    @IBOutlet weak var moviePicImageView: UIImageView!
    // 電影名稱
    @IBOutlet weak var movieNameLabel: UILabel!
    // Page Control
    @IBOutlet weak var pageControl: UIPageControl!
    // 將電影海報放進陣列
    let moviesPic = ["Immortal Beloved","Elephant","Total Recall","The Peanuts Movie"]
    // 將電影名稱放進陣列
    let movieName = ["永遠的愛人", "大象", "攔截記憶碼", "史努比電影"]
    // 將 YouTube 網址放進陣列
    let youtubeURL = ["https://www.youtube.com/embed/524VlYD0PVw","https://www.youtube.com/embed/F5YNsoh1L6M","https://www.youtube.com/embed/CqDkDyA7QHE","https://www.youtube.com/embed/dKA-NOQBdH0"]
    // 計算陣列的 index 先預設為 0
    var index = 0
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 第一部電影是永遠的愛人，因此先放他的電影海報
        moviePicImageView.image = UIImage(named: "Immortal Beloved")
        // 先放電影名稱
        movieNameLabel.text = "永遠的愛人"
        // App 點進來看到所有的內容都是第一頁，因此 segmentedControl 與 pageControl 都設在 0
        segmentedControl.selectedSegmentIndex = 0
        pageControl.currentPage = 0
        // YouTube 影片播放設定
        // 創建一個URL對象，用於指定網頁的URL地址
        let url = URL(string: "https://www.youtube.com/embed/524VlYD0PVw")!
        // 使用URL來創建一個URLRequest對象，這個請求將用於WKWebView
        let request = URLRequest(url: url)
        // 使用WKWebView的load方法來加載指定的URLRequest，顯示網頁內容
        movieWebView.load(request)
        
        
        
    }
    // 點右鍵 buttun 往後一部電影
    @IBAction func turnRight(_ sender: UIButton) {
        // 每點選一次 index 就會 +1，直到數字可被總電影數(4)整除，就會將 index 變成 0 ，回到第一部
        index = (index + 1) % moviesPic.count
        // 帶入陣列中相應 index 的海報、名稱與 YouTube 連結
        let pic = moviesPic[index]
        let name = movieName[index]
        let url = URL(string: youtubeURL[index])!
        
        // 輸入海報、名稱
        moviePicImageView.image = UIImage(named: pic)
        movieNameLabel.text = name
        //輸入 YouTube 連結並載入
        let request = URLRequest(url: url)
        movieWebView.load(request)
        
        // Page Control 切換到當頁圓點
        pageControl.currentPage = index
        // Segmented Control 切換到當頁頁籤
        segmentedControl.selectedSegmentIndex = index
        
        
    }
    // 點左鍵 buttun 往前一部電影
    @IBAction func turnLeft(_ sender: UIButton) {
        // moviesPic.count - 1 = 3 ，每點選一次 index 就會 + 3，index 變成數字被總電影數(4)整除後的餘數
        index = (index + moviesPic.count - 1) % moviesPic.count
        let pic = moviesPic[index]
        let name = movieName[index]
        let url = URL(string: youtubeURL[index])!
        
        moviePicImageView.image = UIImage(named: pic)
        movieNameLabel.text = name
        let request = URLRequest(url: url)
        movieWebView.load(request)
        pageControl.currentPage = index
        segmentedControl.selectedSegmentIndex = index
    }
    // segmentedControl
    @IBAction func choosePage(_ sender: UISegmentedControl) {
        // sender 將點的動作傳給 index，selectedSegmentIndex 看選了哪個頁籤，改變 index
        index = sender.selectedSegmentIndex
        let pic = moviesPic[index]
        let name = movieName[index]
        let url = URL(string: youtubeURL[index])!
        
        moviePicImageView.image = UIImage(named: pic)
        movieNameLabel.text = name
        let request = URLRequest(url: url)
        movieWebView.load(request)
        pageControl.currentPage = index
    }
    // 點骰子可以隨機選電影
    @IBAction func randomChoosePage(_ sender: UIButton) {
        var indexNew = index
        while indexNew == index {
            indexNew = Int.random(in: 0...3)
            }
        let pic = moviesPic[indexNew]
        let name = movieName[indexNew]
        let url = URL(string: youtubeURL[indexNew])!
          
        index = indexNew // 更新 index
        moviePicImageView.image = UIImage(named: pic)
        movieNameLabel.text = name
        let request = URLRequest(url: url)
        movieWebView.load(request)
        pageControl.currentPage = indexNew
        segmentedControl.selectedSegmentIndex = indexNew
        }
        
    // 點 Page Control 可以跳到前一部或後一部電影
    @IBAction func clickPageControl(_ sender: UIPageControl) {
        // sender 將點的動作傳給 index，currentPage 看是往前點還是往後點，改變 index
        index = sender.currentPage
        let name = movieName[index]
        let pic = moviesPic[index]
        let url = URL(string: youtubeURL[index])!
        
        movieNameLabel.text = name
        moviePicImageView.image = UIImage(named: pic)
        let request = URLRequest(url: url)
        movieWebView.load(request)
        
        segmentedControl.selectedSegmentIndex = index
    }
    
    @IBAction func swipeChangePage(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left{
            index = (index + 1) % moviesPic.count
            let pic = moviesPic[index]
            let name = movieName[index]
            let url = URL(string: youtubeURL[index])!
            
            moviePicImageView.image = UIImage(named: pic)
            movieNameLabel.text = name
            let request = URLRequest(url: url)
            movieWebView.load(request)
            
            pageControl.currentPage = index
            segmentedControl.selectedSegmentIndex = index
            
        } else if sender.direction == .right{
            index = (index + moviesPic.count - 1) % moviesPic.count
            let pic = moviesPic[index]
            let name = movieName[index]
            let url = URL(string: youtubeURL[index])!
            
            moviePicImageView.image = UIImage(named: pic)
            movieNameLabel.text = name
            let request = URLRequest(url: url)
            movieWebView.load(request)
            
            pageControl.currentPage = index
            segmentedControl.selectedSegmentIndex = index
            
        }
                    
    
        
    }
    
    @IBAction func longPressRandomChangePage(_ sender: UILongPressGestureRecognizer) {
        // 設定最短長按時間（秒）
        sender.minimumPressDuration = 3
        var indexNew = index
        while indexNew == index {
            indexNew = Int.random(in: 0...3)
            }
        let pic = moviesPic[indexNew]
        let name = movieName[indexNew]
        let url = URL(string: youtubeURL[indexNew])!
          
        index = indexNew // 更新 index
        moviePicImageView.image = UIImage(named: pic)
        movieNameLabel.text = name
        let request = URLRequest(url: url)
        movieWebView.load(request)
        pageControl.currentPage = indexNew
        segmentedControl.selectedSegmentIndex = indexNew
    }
}

