//
//  SelectTagViewController.swift
//  LadyBeetle
//
//  Created by Masayuki Wada on 2021/09/08.
//

import UIKit

class SelectTagViewController: UITableViewController {
    
    
    // MARK: - actions
    
    @objc func add(){
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: notification_selected_tag_did_change, object: nil)
        }
    }
    
    @objc func cancel(){
        self.dismiss(animated: true) {
            
        }
    }
    

    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完了", style: .plain, target: self, action: #selector(add))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "キャンセル", style: .plain, target: self, action: #selector(cancel))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    // セクションの数を返す。必須
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // 各セクションの行数を返す。必須
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReviewManager.shared.tags.count
    }
    
    // セルを返す。必須。セルはtableviewからdequeueで取ってくる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectTagCell") else { return UITableViewCell() }
        
        return cell
    }
    
    // セルが表示する直前に呼ばれる。ここでセルの表示内容を設定する
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? SelectTagCell{
            let tag = ReviewManager.shared.tags[indexPath.row]
            cell.configure(tag: tag)
        }
    }

    // セルが選択された直後に呼ばれる
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath){
            
            let tag = ReviewManager.shared.tags[indexPath.row]
            
            if ReviewManager.shared.isSelectedTag(tag: tag){
                ReviewManager.shared.currentSelectedTags.remove(at: ReviewManager.shared.currentSelectedTags.firstIndex(of: tag)!)
                cell.accessoryType = .none
            }
            else{
                ReviewManager.shared.currentSelectedTags.append(tag)
                cell.accessoryType = .checkmark
            }
        }
    }
}
