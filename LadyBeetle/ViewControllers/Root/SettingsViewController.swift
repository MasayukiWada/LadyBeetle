//
//  SettingsViewController.swift
//  LadyBeetle
//
//  Created by Masayuki Wada on 2021/09/08.
//

import UIKit

class SettingsViewController: UITableViewController {

    
    
    
    // MARK: - tableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
