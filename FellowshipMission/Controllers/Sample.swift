//
//  Sample.swift
//  FellowshipMission
//
//  Created by Akinsete Sunday on 11/21/17.
//  Copyright © 2017 FMC. All rights reserved.
//

import UIKit

class SampleController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var audioMessage = [AudioMedia]()
    
    @IBOutlet weak var ourTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as! MediaCell
        
        return cell
    }
    
}
