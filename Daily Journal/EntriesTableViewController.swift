//
//  EntriesTableViewController.swift
//  Daily Journal
//
//  Created by SEZAX development on 12/28/20.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let entriesFromCoreData = try?
                context.fetch(Entry.fetchRequest()) as? [Entry] {
                entries = entriesFromCoreData
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell") {
            
            let entry = entries[indexPath.row]
            
            //cell.textLabel?.text = entry.text
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController {
            if let entryToBeSent = sender as? Entry {
                entryVC.entry = entryToBeSent
            }
        }
    }
}
