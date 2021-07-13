//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by Athena Fernandes Sarantôpoulos on 13/07/21.
//

import UIKit

class StoryPromptViewController: UIViewController {

    @IBOutlet weak var storyPromptTextField: UITextView!
    
    var storyPrompt:StoryPromptEntry?
    var isNewStoryPrompt = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        storyPromptTextField.text = storyPrompt?.description
        
        if isNewStoryPrompt {
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStoryPrompt))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelStoryPrompt))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
//    // para esconder o navigation bar necessario esses dois metodos
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    @objc func cancelStoryPrompt() {
        performSegue(withIdentifier: "CancelStoryPrompt", sender: nil)
    }
    
    @objc func saveStoryPrompt() {
        NotificationCenter.default.post(name: .StoryPromptSaved, object: storyPrompt)
        performSegue(withIdentifier: "SaveStoryPrompt", sender: nil)
    }
    
}

extension Notification.Name{
    static let StoryPromptSaved = Notification.Name("StoryPromptSave")
}
