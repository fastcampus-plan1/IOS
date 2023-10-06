//
//  ViewController.swift
//  Task
//
//  Created by Lecture on 2023/09/11.
//

import UIKit

enum AlertError: Error {
    case cancel
}

class ViewController: UIViewController {

    private var count: Int = 0
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func sleepDidTap(_ sender: Any) {
        self.numberLabel.isHidden = true
        Task {
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            self.count += 1
            self.numberLabel.isHidden = false
            self.numberLabel.text = "\(self.count)"
        }
    }

    @IBAction func alertDidTap(_ sender: Any) {
        self.alertLabel.isHidden = true
        Task {
            do {
                try await self.alertResult()
                self.alertLabel.isHidden = false
                self.alertLabel.text = "ok"
            } catch {
                self.alertLabel.isHidden = false
                self.alertLabel.text = "cancel"
            }
        }
    }
    
    func alertResult() async throws -> Void {
        try await withCheckedThrowingContinuation { continuation in
            let alertController = UIAlertController(title: "Alert", message: "select ok/cancel", preferredStyle: .alert)
            alertController.addAction(
                .init(
                    title: "ok",
                    style: .default,
                    handler: { _ in
                        continuation.resume()
                    }
                )
            )
            alertController.addAction(
                .init(
                    title: "cancel",
                    style: .cancel,
                    handler: { _ in
                        continuation.resume(throwing: AlertError.cancel)
                    }
                )
            )
            self.present(alertController, animated: true)
        }
    }
    
    @IBAction func actorDidTap(_ sender: Any) {
        let counter: Counter = .init()
        counter.printText()

        // 최상위 레벨 Task 생성
        Task.detached {
            for _ in 0..<50 {
                try? await Task.sleep(nanoseconds: 1_000_000_000 / 10)
//                print("count : \(await counter.increment())")
                print("count : \(await counter.increment())")
            }
        }
        Task.detached {
            for _ in 0..<50 {
                try? await Task.sleep(nanoseconds: 1_000_000_000 / 10)
//                print("count1 : \(await counter.increment())")
                print("count1 : \(await counter.increment())")
            }
        }
        
    }
    
}

