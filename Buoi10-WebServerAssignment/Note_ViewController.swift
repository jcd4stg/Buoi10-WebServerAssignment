//
//  Note_ViewController.swift
//  Buoi10-WebServerAssignment
//
//  Created by lynnguyen on 26/09/2023.
//

import UIKit

struct Note_AddNew: Decodable {
    var result: Int
    var message: String
}

struct Note_GetItems: Decodable {
    var result: Int
    var message: String
    var items: [Note_Item]
}

struct Note_Item: Decodable {
    var title: String
    var _id: String
    //var dateCreated: String // bỏ cũng dc
}
class Note_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var txt_Note: UITextField!
    @IBOutlet weak var tbv_Note: UITableView!
    
    var arrNote: [Note_Item]?
    override func viewDidLoad() {
        super.viewDidLoad()

        tbv_Note.delegate = self
        tbv_Note.dataSource = self
        
        arrNote = []
        
        self.getAllNotes()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNote!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbv_Note.dequeueReusableCell(withIdentifier: "NOTE_CELL") as! Note_TableViewCell
        cell.lbl_Note_Name.text = arrNote![indexPath.row].title
        return cell
    }
    func getAllNotes() {
        let url = URL(string: "http://localhost:3000/getNotes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
                
        let _ = URLSession.shared.dataTask(with: request) { data, response, err in
            guard let data = data,
                  //let response = response as? HTTPURLResponse,
                  err == nil else {
                print("Error is ", err ?? "Undefinded error")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let infoNote = try jsonDecoder.decode(Note_GetItems.self, from: data)
                if infoNote.result == 1 {
                    self.arrNote = infoNote.items
                    DispatchQueue.main.async {
                        self.tbv_Note.reloadData()
                    }
                }
            } catch {
                print("Info is invalid")
            }
        }.resume()
    }
    
    @IBAction func saveNewNote(_ sender: Any) {
        
        let url = URL(string: "http://localhost:3000/addNew")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let title: String = txt_Note.text!
        let noteData = ("title="+title).data(using: .utf8)
        request.httpBody = noteData
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, err in
            guard let data = data,
                  //let response = response as? HTTPURLResponse,
                  err == nil else {
                print("Error is ", err ?? "Undefinded error")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let infoData = try jsonDecoder.decode(Note_AddNew.self, from: data)
                if infoData.result == 1 {
                    DispatchQueue.main.async {
                        self.getAllNotes()
                        self.txt_Note.text = ""
                        let alert = UIAlertController(title: "From Nodejs", message: infoData.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        self.tbv_Note.reloadData()
                    }
                }
            } catch {
                print("Info is invalid")
            }
        }.resume()
        
    }
    
    
}
