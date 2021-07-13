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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        storyPromptTextField.text = storyPrompt?.description
    }
    // para esconder o navigation bar necessario esses dois metodos
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func cancelStoryPrompt(_ sender: Any) {
        performSegue(withIdentifier: "CancelStoryPrompt", sender: nil)
    }
    
}
