//
//  ViewController.swift
//  Buoi10-WebServerAssignment
//
//  Created by lynnguyen on 25/09/2023.
//

import UIKit

struct Student: Decodable {
    var _id: String
    var name: String
    var age: Int
}

struct StudentList: Decodable {
    var result: Int
    var message: String
    var data: [Student]
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbv_Student: UITableView!
    
    var arrStudent: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbv_Student.dataSource = self
        tbv_Student.delegate = self
        
        let url = URL(string: "http://localhost:3000/data")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                  //let response = response,
                  error == nil else {
                print("Error: ", error ?? "Undefined error")
                return
            }
            print(data)

            let jsonDecoder = JSONDecoder()
            do {
                
                let studentData = try jsonDecoder.decode(StudentList.self, from: data)
                if studentData.result == 1 {
                    self.arrStudent.append(contentsOf: studentData.data)
                    DispatchQueue.main.async {
                        self.tbv_Student.reloadData()
                    }
                }
                
            } catch {
                print("Data is invalid")
            }
            
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudent.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbv_Student.dequeueReusableCell(withIdentifier: "STUDENT_CELL") as! Student_TableViewCell
        cell.idLbl.text = arrStudent[indexPath.row]._id
        cell.nameLbl.text = arrStudent[indexPath.row].name
        cell.ageLbl.text = String(arrStudent[indexPath.row].age)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 3
    }
}

