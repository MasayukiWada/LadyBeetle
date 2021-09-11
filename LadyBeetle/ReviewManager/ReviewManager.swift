//
//  ReviewManager.swift
//  LadyBeetle
//
//  Created by Masayuki Wada on 2021/09/08.
//

import UIKit
import FirebaseFirestore

struct Tag: Equatable {
    
    var displayName = "TagName"
    var tagID = "tag id"
    var isValid = true
    
    static func == (left: Tag, right: Tag)->Bool{
        return left.tagID == right.tagID
    }
    
    init(data:[String:Any]) {
        
        if let name = data["displayName"] as? String{
            self.displayName = name
        }
        
        if let tag = data["tagID"] as? String{
            self.tagID = tag
        }
        
        if let valid = data["isValid"] as? Bool{
            self.isValid = valid
        }
    }
}

let notification_selected_tag_did_change = Notification.Name.init("notification_selected_tag_did_change")

class ReviewManager: NSObject {
    
    // MARK: - properties
    // プロパティの名前は必ず小文字から始める
    var tags = [Tag]()
    var currentSelectedTags = [Tag]()

    
    
    // MARK: - tags
    /* firestoreにタグを作る。本来はFirebaseのコンソールから作るべきだが，firestoreの使い方チュートリアルとして，今回はアプリ側からfirebaseにdocumentを作る例として書いておく
     作った後に，Firebaseのコンソールから名前等々を変更すると作りやすいかも
 */
    func makeTags(){
        
        for i in 0...10 {
            
            // タグにするデータ
            let name = "Tag\(i)"
            let tagID = UUID().uuidString
            let isValid = true
            let data = ["displayName":name,"tagID":tagID,"isValid":isValid] as [String:Any]
            
            Firestore.firestore().collection("tags").document().setData(data) { error in
                if let error = error{
                    print("tag create error, \(error)")
                }
            }
        }
    }
    
    func fetchTags(){
        
        self.tags = [Tag]()
        
        // firestoreのtagsコレクションからdocumentを取ってくる
        Firestore.firestore().collection("tags").getDocuments { snapshots, error in
            
            if let error = error{
                print(error)
            }
            
            // 結果はquerySnapshotでもらえるので，そこからdocumentSnapshotのarrayを取り出す
            guard let docs = snapshots?.documents else { return }
            
            // arrayを列挙してdocumentを取り出す
            for doc in docs {
                
                // データの実態(dictionary)はdocumentからdata()で取り出す
                let data = doc.data()
                
                // dictionaryからTag構造体を作って保持しておく。これをタグとして使うTagの定義は上
                let tag = Tag.init(data: data)
                self.tags.append(tag)
            }
        }
    }
    
    func resetCurrentSelectedTags(){
        self.currentSelectedTags = [Tag]()
    }
    
    func isSelectedTag(tag:Tag)->Bool{
        
        if self.currentSelectedTags.contains(tag) {
            return true
        }
        else{
            return false
        }
    }
    
    func showTagSelectViewController(from:UIViewController){
        
        let board = UIStoryboard.init(name: "Review", bundle: nil)
        let vc = board.instantiateViewController(identifier: "SelectTagViewController")
        let nav = UINavigationController.init(rootViewController: vc)
        from.present(nav, animated: true) {
            
        }
    }
    
    
    // MARK: - lifecycle
    
    static let shared = ReviewManager()
    
    private override init(){
        super.init()
    }
}
