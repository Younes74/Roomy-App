//
//  ViewController.swift
//  RoomyApp
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 Fons. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class GetRoomViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!

    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    var roomsArray = [Rooms]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNibFile = UINib(nibName: "DetailsCell", bundle: nil)
        detailsTableView.register(cellNibFile, forCellReuseIdentifier: "DetailsCell")
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        getRooms()
        loadingView.startAnimating()
    }
    
    func getRooms() {
        RoomyRouter.getRooms.requestEndPointWithoutData(onRequestSuccess: { (roomsRes) in
            let rooms = try? JSONDecoder().decode([Rooms].self, from: roomsRes.data!)
            for room in rooms! {
                self.roomsArray.append(Rooms(id: room.id ?? 0,
                                             title: room.title ?? "" ,
                                             price: room.price ?? "",
                                             place: room.price ?? "",
                                             image: room.image ?? "",
                                             description: room.image ?? ""))
                self.detailsTableView.reloadData()
                self.loadingView.stopAnimating()
            }
        }) { (error) in
            print("Error")
            }.subscribe()
        
    }
}
extension GetRoomViewController: UITableViewDelegate,UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        cell.setup(with: roomsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
