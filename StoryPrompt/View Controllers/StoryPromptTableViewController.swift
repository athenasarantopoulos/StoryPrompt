//
//  StoryPromptTableViewController.swift
//  StoryPrompt
//
//  Created by Athena Fernandes Sarantôpoulos on 13/07/21.
//

import UIKit

class StoryPromptTableViewController: UITableViewController {

    var storyPrompts = [StoryPromptEntry]()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateStoryPromptList(notification:)), name: .StoryPromptSaved, object: nil)

//        let storyPromp1 = StoryPromptEntry()
//        let storyPromp2 = StoryPromptEntry()
//        let storyPromp3 = StoryPromptEntry()
//
//        storyPromp1.noun = "toaster"
//        storyPromp1.adjective = "smelly"
//        storyPromp1.verb = "attacks"
//        storyPromp1.number = 5
//
//
//        storyPromp2.noun = "toaster"
//        storyPromp2.adjective = "smelly"
//        storyPromp2.verb = "attacks"
//        storyPromp2.number = 5
//
//
//        storyPromp3.noun = "toaster"
//        storyPromp3.adjective = "smelly"
//        storyPromp3.verb = "attacks"
//
//        storyPrompts = [storyPromp1, storyPromp2, storyPromp3]

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //somente uma sessao
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // como usando so uma sessao utilizar o tamanho do array
        return storyPrompts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
        cell.textLabel?.text = "Prompt \(indexPath.row + 1)"
        cell.imageView?.image = storyPrompts[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyPrompt = storyPrompts[indexPath.row]
        performSegue(withIdentifier: "ShowStoryPrompt", sender: storyPrompt)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStoryPrompt" {
          guard let storyPromptViewController = segue.destination as? StoryPromptViewController,
                let storyPrompt = sender as? StoryPromptEntry else {
            return
          }
          storyPromptViewController.storyPrompt = storyPrompt
        }
      }

    @IBAction func saveStoryPrompt(unwindSegue: UIStoryboardSegue) {
//        guard let storyPromptViewController = unwindSegue.source as? StoryPromptViewController,
//              let storyPrompt = storyPromptViewController.storyPrompt else {
//          return
//        }
//        storyPrompts.append(storyPrompt)
//        tableView.reloadData()
    }
    
    @IBAction func cancelStoryPrompt(unwindSegue: UIStoryboardSegue){
        
    }

    // é possivel salvar na lista usando unwind segue ou notification
    @objc func updateStoryPromptList(notification: Notification){
        guard let storyPrompt = notification.object as? StoryPromptEntry else {
            return
        }
        storyPrompts.append(storyPrompt)
        tableView.reloadData()

    }

}
