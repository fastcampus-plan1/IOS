//
//  ViewController.swift
//  MemoryDebug
//
//  Created by Lecture on 2023/12/04.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum Row: Int, CaseIterable {
        case crash
        case memoryType1
        case memoryType2
        case memoryType3
        case cacheTest
        case weak
        case unowned
        case unownedOptional
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 50
        
        TaskSample().doSomething()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = self.cellTitle(indexPath: indexPath)
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = Row(rawValue: indexPath.row) else {
            return
        }
        
        switch row {
        case .crash:
            _ = [Int]()[1]
        case .memoryType1:
            let aModule = AModule()
            _ = BModule(aModule: aModule)
            
            let circularA = CircularA()
            let circularB = CircularB()
            let circularC = CircularC()
            circularA.b = circularB
            circularB.c = circularC
            circularC.a = circularA
        case .memoryType2:
            let vc = MemoryWarningType2ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case .memoryType3:
            let vc = MemoryWarningType3ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case .cacheTest:
            SampleCache.shared.add(data: DummyGenerator.make())
        case .weak:
            let main = WeakMain()
            let sub = WeakSub()
            main.sub = sub
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                print(String(describing: main.sub?.value))
            }
        case .unowned:
            let sub = UnownedSub()
            let main = UnownedMain(sub: sub)
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                print(String(describing: main.sub.value))
            }
        case .unownedOptional:
            let main = UnownedOptionalMain()
            let sub = UnownedOptionalSub()
            main.sub = sub
            Task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                print(String(describing: main.sub?.value))
            }
        }
    }
    
    private func cellTitle(indexPath: IndexPath) -> String? {
        guard let row = Row(rawValue: indexPath.row) else {
            return nil
        }
        
        switch row {
        case .crash:
            return "크래시 발생"
        case .memoryType1:
            return "메모리 문제 발생 유형 1"
        case .memoryType2:
            return "메모리 문제 발생 유형 2"
        case .memoryType3:
            return "메모리 문제 발생 유형 3"
        case .cacheTest:
            return "MemoryWarning을 활용한 데이터정리"
        case .weak:
            return "Weak Reference 접근 테스트"
        case .unowned:
            return "Unowned Reference 접근 테스트"
        case .unownedOptional:
            return "Unowned Optional Reference 접근 테스트"
        }
    }
    
    private func printCancel() {
        print("canceled")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        print("home vc memory warning")
    }

}

