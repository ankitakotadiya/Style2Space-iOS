//
//  PlaceBidViewController.swift
//  Style2Space
//
//  Created by Ankita Kotadiya on 28/04/24.
//

import UIKit
import Combine

class PlaceBidViewController: UIViewController, Nib {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bidTableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    private var bidViewModel: PlaceBiDViewModel?
    @Published private var textfieldData: [PropertyPlaceholder: String] = [:]
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bidViewModel = PlaceBiDViewModel()
        self.setupViewModelBinding()
        self.setUpUI()
        self.configureTableView()
    }
    
    private func setupViewModelBinding() {
        $textfieldData.receive(on: DispatchQueue.main)
            .sink { textdic in
                self.updateUIwithTextfield(textfieldData: textdic)
            }.store(in: &self.cancellable)
    }
    
    private func updateUIwithTextfield(textfieldData: [PropertyPlaceholder: String]) {
        
        textfieldData.forEach { (key,value) in
            
            if let idx = self.bidViewModel?.tableData.firstIndex(where: { $0.placeHolder == key}) {
                self.bidViewModel?.tableData[idx].textfieldTitle = value
            }
        }
    }
    
    private func setUpUI() {
        self.titleLabel.configure(text: "Place A BID", textColor: Colors.AppColour, font: UIFont.systemFont(ofSize: 17.0, weight: .bold), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
        
        self.descriptionLabel.configure(text: "Let's embark on a journey to connect, design, and create your dream interiors!", textColor: .black, font: UIFont.systemFont(ofSize: 15.0), backgroundColor: .clear, numberOfLines: 0, alignment: .left)
    }
    
    private func configureTableView() {
        self.bidTableView.dataSource = self
        self.bidTableView.delegate = self
        self.bidTableView.separatorStyle = .none
        
        self.bidTableView.register(cellType: PropertyTypeTableViewCell.self)
        self.bidTableView.register(cellType: PropertyClassificationTableViewCell.self)
        self.bidTableView.register(cellType: WorkAreaTableViewCell.self)
        self.bidTableView.register(cellType: PlaceBidButtonTableViewCell.self)
    }
    
    private func handleCellEvent(product: PlaceBiDRows, indexPath: IndexPath, event: PropertyClassificationCellEvent) {
        switch event {
        case .buttonDidChange(rowType: let value, selected: let selected):
            
            if self.bidViewModel?.tableData[indexPath.row].title == value {
                if value == .classification {
                    self.bidViewModel?.tableData[indexPath.row].PropertyOptionsSelected = Set(arrayLiteral: selected)
                } else {
                    if (self.bidViewModel?.tableData[indexPath.row].PropertyOptionsSelected.contains(selected)) == true {
                        self.bidViewModel?.tableData[indexPath.row].PropertyOptionsSelected.remove(selected)
                    } else {
                        self.bidViewModel?.tableData[indexPath.row].PropertyOptionsSelected.insert(selected)
                    }
                    if self.bidViewModel?.tableData[indexPath.row].PropertyOptionsSelected.count == 0 {
                        self.bidViewModel?.tableData[indexPath.row].PropertyOptionsSelected.insert(.none)
                    }
                }
            }
        }
        self.bidTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension PlaceBidViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bidViewModel?.tableData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let modelData = self.bidViewModel?.tableData[indexPath.row] as? PlaceBiDRows {
            if modelData.title == .name || modelData.title == .type || modelData.title == .projectType || modelData.title == .budget {
                if let cell = tableView.dequeueReusableCell(withIdentifier: String.className(for: PropertyTypeTableViewCell.self)) as? PropertyTypeTableViewCell {
                    cell.textField.delegate = self
                    cell.configure(for: modelData)
                    return cell
                }
            } else if modelData.title == .classification || modelData.title == .details {
                if let workcell = tableView.dequeueReusableCell(withIdentifier: String.className(for: PropertyClassificationTableViewCell.self)) as? PropertyClassificationTableViewCell {
                    workcell.configure(for: modelData)
                    workcell.eventPublisher.sink { event in
                        self.handleCellEvent(product: modelData, indexPath: indexPath, event: event)
                    }.store(in: &workcell.cancellables)
                    return workcell
                }
            } else if modelData.title == .workarea {
                if let areaCell = tableView.dequeueReusableCell(withIdentifier: String.className(for: WorkAreaTableViewCell.self)) as? WorkAreaTableViewCell {
                    areaCell.configure(for: modelData)
                    return areaCell
                }
            } else if modelData.title == .submit {
                if let submitCell = tableView.dequeueReusableCell(withIdentifier: String.className(for: PlaceBidButtonTableViewCell.self)) as? PlaceBidButtonTableViewCell {
                    submitCell.configure(for: modelData)
                    return submitCell
                }
            }
        }
        
        return UITableViewCell()
    }
}

extension PlaceBidViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let placeHolder = textField.placeholder {
            self.textfieldData[PropertyPlaceholder(rawValue: placeHolder)!] = textField.text ?? ""
        }
    }
}

extension PlaceBidViewController: UITableViewDelegate {
    
}
