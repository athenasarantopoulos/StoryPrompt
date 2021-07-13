//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Athena Fernandes Sarantôpoulos on 12/07/21.
//

import UIKit
import PhotosUI

class AddStoryPromptViewController: UIViewController, UITextFieldDelegate{

    let storyPrompt = StoryPromptEntry()
    
    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var adjectiveTextField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var storyPromptImageView: UIImageView!
    
    
    @IBAction func changeNumber(_ sender: UISlider) {
        numberLabel.text = "Number: \(Int(sender.value))"
        storyPrompt.number = Int(sender.value)
    }
    
    @IBAction func generateStoryPrompt(_ sender: Any) {
        updateStoryPrompt()
        if storyPrompt.isValid(){
// utilizado quando é view controller para view controller
            performSegue(withIdentifier: "StoryPrompt", sender: nil)
        }else{
            let alert = UIAlertController(title: "Invalid Story Prompt", message: "Please fill out all of the fields", preferredStyle: .alert)
                  let action = UIAlertAction(title: "OK", style: .default, handler: { action in

                  })
                  alert.addAction(action)
                  present(alert, animated:  true)
        	}
        
        removeText()
    }
    
    @IBAction func changeStoryType(_ sender: UISegmentedControl) {
        if let genre = StoryPrompts.Genre(rawValue: sender.selectedSegmentIndex) {
            storyPrompt.genre = genre
        }else {
            storyPrompt.genre = .scifi
        }
    }
    
    @objc  func updateStoryPrompt(){
        storyPrompt.noun = nounTextField.text ?? ""
        storyPrompt.adjective = adjectiveTextField.text ?? ""
        storyPrompt.verb = verbTextField.text ?? ""
    }
    
    func removeText(){
        nounTextField.text = ""
        adjectiveTextField.text = ""
        verbTextField.text = ""
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func textFieldShouldReturn(_  textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func changeImage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        present(controller, animated: true)
      }
    
    
    // utilizado quando é ação de algum outlet
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StoryPrompt" {
            guard let storyPromptViewController = segue.destination as? StoryPromptViewController else {
                return
            }
            storyPromptViewController.storyPrompt = storyPrompt
            storyPromptViewController.isNewStoryPrompt = true
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // utilizado quando é ação button
//        storyPrompt.noun = "toaster"
//        storyPrompt.adjective = "smelly"
//        storyPrompt.verb = "burps"
        numberSlider.value = 7.5
        storyPrompt.number = Int(numberSlider.value)
        //print(storyPrompt)
        
        nounTextField.delegate = self
        verbTextField.delegate = self
        adjectiveTextField.delegate = self
        
        storyPromptImageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
            storyPromptImageView.addGestureRecognizer(gestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(updateStoryPrompt), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
extension AddStoryPromptViewController: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    if !results.isEmpty {
      let result = results.first!
      let itemProvider = result.itemProvider
      if itemProvider.canLoadObject(ofClass: UIImage.self) {
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
          guard let image = image as? UIImage else {
            return
          }
          DispatchQueue.main.async {
            self?.storyPromptImageView.image = image
          }
        }
      }
    }
  }
}
