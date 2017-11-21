//
//  ViewController.swift
//  FellowshipMission
//
//  Created by Akinsete Sunday on 11/21/17.
//  Copyright © 2017 FMC. All rights reserved.
//

import UIKit
import JGProgressHUD
import SharkORM
import Jukebox

class MediaController: UIViewController,UITableViewDelegate,UITableViewDataSource,JukeboxDelegate{


    @IBOutlet weak var tableView: UITableView!
    var audios = [AudioMedia]()
    var progressHUD:JGProgressHUD!
    let notificationCenter = NotificationCenter.default
    var jukebox:Jukebox!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        notificationCenter.addObserver(self, selector: #selector(audioUpdated), name:.AudioCompleted, object: nil)


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDataLocally()

    }
    
    @objc func audioUpdated(_ notification:Notification){
        hideLoading()
        //let status = notification.userInfo?["status"] as? Bool
//        if(status)!{
//            audios = AudioMedia.query().fetch() as! [AudioMedia]
//            print(audios)
//        }
        var items = [JukeboxItem]()
        Store.shared.audios.forEach { (audio) in
            let path = audio.getPath()
            let urlString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            items.append(JukeboxItem(URL: NSURL(string:urlString!)! as URL))
        }
        
        jukebox = Jukebox(delegate: self, items: items)
        tableView.reloadData()
    }
    
    func fetchDataLocally(){
//        audios = AudioMedia.query().fetch() as! [AudioMedia]
//        print(audios.count)
//        if(audios.count == 0){
        
//        }
        showLoading()
        tableView.reloadData()
        Backend.shared.fetchAudioMedia()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Store.shared.audios.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as! MediaCell
        let audio = Store.shared.audios[indexPath.row]
        cell.label_title.text = audio.getName()
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jukebox.play(atIndex: indexPath.row)

        //playAudio(audio: Store.shared.audios[indexPath.row])
    }
    
    func playAudio(audio:AudioMedia) {
        //print(audio)
        let path = audio.getPath()
        let urlString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(urlString)


        jukebox = Jukebox(delegate: self, items: [
            JukeboxItem(URL: NSURL(string:urlString!)! as URL)
            ])
        jukebox.play()
        
   
    }
    
    func showLoading(){
        progressHUD = JGProgressHUD(style: JGProgressHUDStyle.dark)
        progressHUD.show(in: view, animated: true)
        //progressHUD.dismissAfterDelay(3.0)
    }

    func hideLoading(){
        if(progressHUD != nil){
            progressHUD.dismiss(animated: true)
        }
    }
    

    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        //print(jukebox)
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        //print(jukebox)

    }
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        //print(jukebox.currentItem?.currentTime)

    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        //forItem.currentTime
       // print(jukebox)

    }
    
}

