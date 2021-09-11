//
//  AddReviewViewController.swift
//  LadyBeetle
//
//  Created by Masayuki Wada on 2021/09/08.
//

import UIKit

class AddReviewViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - properties
    @IBOutlet weak var reviewTextView:UITextView!
    @IBOutlet weak var reviewEditButton:UIButton!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var imageDeleteButton:UIButton!
    @IBOutlet weak var imageSelectButton:UIButton!
    @IBOutlet weak var tagTextView:UITextView!
    @IBOutlet weak var tagDeleteButton:UIButton!
    @IBOutlet weak var tagSelectButton:UIButton!
    @IBOutlet weak var reviewPostButton:UIButton!
    @IBOutlet weak var reviewCancelButton:UIButton!
    
    var selectedImage:UIImage? = nil
    
    
    // MARK: - actions
    
    @IBAction func reviewEdit(){
        self.reviewTextView.becomeFirstResponder()
    }
    
    @IBAction func imageDelete(){
        self.selectedImage = nil
        self.imageView.image = UIImage.init(named: "sample")
    }
    
    @IBAction func imageSelect(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true) {
            
        }
    }
    
    @IBAction func tagDelete(){
        self.tagTextView.text = ""
        ReviewManager.shared.currentSelectedTags = [Tag]()
    }
    
    @IBAction func tagSelect(){
        ReviewManager.shared.showTagSelectViewController(from: self)
    }
    
    @IBAction func post(){
        
    }
    
    @IBAction func cancel(){
        
    }
    
    // MARK: - UIImagePickerController delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            
        }
        
        if let image = info[.originalImage] as? UIImage {
            self.selectedImage = image
            self.imageView.image = image
        }
    }
   
    // MARK: - configure
    
    @objc func loadData(){
        
        var tagString = ""
        
        print("count(\(ReviewManager.shared.currentSelectedTags.count))")
        
        for (index, tag) in ReviewManager.shared.currentSelectedTags.enumerated() {
            tagString.append(tag.displayName)
            
            if index != ReviewManager.shared.currentSelectedTags.count-1{
                tagString.append(",")
            }
        }
        
        self.tagTextView.text = tagString
        print("tagString(\(tagString))")
    }
    
    
    // MARK: - lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: notification_selected_tag_did_change, object: nil)
        
        let size:CGFloat = 17.0
        DesignManager.themeColorButton(button: reviewEditButton, textSize: size)
        DesignManager.themeColorButton(button: imageDeleteButton, textSize: size)
        DesignManager.themeColorButton(button: imageSelectButton, textSize: size)
        DesignManager.themeColorButton(button: tagDeleteButton, textSize: size)
        DesignManager.themeColorButton(button: tagSelectButton, textSize: size)
        DesignManager.themeColorButton(button: reviewPostButton, textSize: size)
        DesignManager.themeColorButton(button: reviewCancelButton, textSize: size)
        
        self.tableView.backgroundView = UIView()
    }

}
