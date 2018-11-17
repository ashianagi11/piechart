//
//  PhotosViewController.swift
//  TumblrApp
//
//  Created by Ashia Nagi on 9/7/18.
//  Copyright © 2018 Ashia Nagi. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var posts: [[String: Any]] = [] //Step 2 of milestone 2 //read about properties in swift
    
    @IBOutlet weak var tableView: UITableView!     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        makeNetworkRequest(refreshControl: refreshControl)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 240
        
        //M2, S3 (Milestone 2, Step 3)
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData //same as request
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                //M3, S4 
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                //self.tableView.reloadData() //m3 s7
            }
        }
        task.resume() 

    }
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell

        let post = posts[indexPath.row] //M3 S4 post
        //M3 S5
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            
            cell.imageCell.af_setImage(withURL: url!) //M3 S7
        }
    
        return cell
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func makeNetworkRequest(refreshControl: UIRefreshControl?) {
        
    }
    
   

}
