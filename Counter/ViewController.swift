//
//  ViewController.swift
//  Counter
//
//  Created by Ivan Ryabov on 18/05/2023.
//

import UIKit

extension UITextView {
    func simple_scrollToBottom() {
        let textCount: Int = text.count
        guard textCount >= 1 else { return }
        scrollRangeToVisible(NSRange(location: textCount - 1, length: 1))
    }
}
class ViewController: UIViewController {
    private var newCount:Int = 0
    private var count:Int = 0
    private var arrayEditHistory:[String] = ["История изменений:"]
    func addTime() -> String {
        let now = Date()
        let dtFormatter = DateFormatter()
        dtFormatter.dateStyle = .short
        dtFormatter.timeStyle = .short
        let formattedDateTime = dtFormatter.string(from: now)
        return formattedDateTime
    }
    func addText () -> String {
        var sum:String = ""
        for arrayEditHistorys in arrayEditHistory {
            sum += arrayEditHistorys + "\n"
            }
        return sum
        }
    
    @IBOutlet weak var counterReadings: UILabel!
    @IBAction func buttonCounter(_ sender: Any) {
        newCount = count + 1
        count = newCount
        self.counterReadings.text = "Значение счётчика: \(newCount)"
        self.arrayEditHistory.append("\(addTime()): значение изменено на +1")
        self.editHistory.text = "\(addText())"
        editHistory.simple_scrollToBottom()
    }
    
    @IBOutlet weak var editHistory: UITextView!

    @IBAction func buttonCounterMinus(_ sender: Any) {
        newCount = count - 1
        if newCount < 0 {
            self.arrayEditHistory.append("\(addTime()): попытка уменьшить значение счётчика ниже 0")
            self.editHistory.text = "\(addText())"
            editHistory.simple_scrollToBottom()
        }
        else {
            count = newCount
            self.counterReadings.text = "Значение счётчика: \(newCount)"
            self.arrayEditHistory.append("\(addTime()): значение изменено на -1")
            self.editHistory.text = "\(addText())"
            editHistory.simple_scrollToBottom()
            return
        }
    }
    
  @IBAction func buttonRefresh(_ sender: Any) {
      if newCount > 0 {
          newCount = 0
          count = newCount
        self.counterReadings.text = "Значение счётчика: \(newCount)"
        self.arrayEditHistory.append("\(addTime()): значение сброшено")
        self.editHistory.text = "\(addText())"
        editHistory.simple_scrollToBottom()
      } else {}
    }
    
    @IBAction func buttonDeleteHistory(_ sender: Any) {
        if let first = arrayEditHistory.first {
            arrayEditHistory = [first]
        }
        self.editHistory.text = "\(addText())"
        editHistory.simple_scrollToBottom()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        editHistory.isEditable = false
        self.counterReadings.text = "Значение счётчика: \(newCount)"
        self.editHistory.text = "\(addText())"
        editHistory.simple_scrollToBottom()
        }
    }
