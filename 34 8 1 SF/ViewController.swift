//
//  ViewController.swift
//  34 8 1 SF
//
//  Created by Ксения Борисова on 09.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func getPosts(from url: URL?) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let dataString = String(data: data, encoding: .utf8),
                (response as? HTTPURLResponse)?.statusCode == 200,
                error == nil else { return }
            DispatchQueue.main.async {
                self.textView.text = dataString
            }
        }
        task.resume()
    }
    
    @IBAction func okBtn(_ sender: UIButton) {
        let numberOfPost = textField.text
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(numberOfPost ?? "1")")
        getPosts(from: url)
        
    }
    
}

