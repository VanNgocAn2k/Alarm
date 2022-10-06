//
//  SettingAlarmViewController.swift
//  AppAlarm
//
//  Created by Van Ngoc An  on 24/09/2022.
//

import UIKit

protocol clockDelegate{
    func setTime(time: String)
}

class SettingAlarmViewController: UIViewController {
    
    var timeArray: [AlarmClock] = [AlarmClock]()
    
    @IBOutlet weak var alarmTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmTableView.tableFooterView = UIView()
        self.alarmTableView.dataSource = self
        self.alarmTableView.delegate = self
        
        self.registerTableViewCells()
    }
    
    @IBAction func editBarButtonAction(_ sender: Any) {
        alarmTableView.isEditing = !alarmTableView.isEditing
    }
    
    //MARK: - add new alarm clock
    @IBAction func addBarButtonAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVC" {
            if let vc = segue.destination as? EditAlarmViewController {
                vc.delegate = self
            }
        }
    }
    private func registerTableViewCells(){
        let alarmCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.alarmTableView.register(alarmCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
}

extension SettingAlarmViewController: clockDelegate{
    func setTime(time: String) {
        let time = AlarmClock(time: time, isEnable: true)
        timeArray.append(time)
        self.alarmTableView.reloadData()
    }
    
}
extension SettingAlarmViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell{
            cell.timeLabel.text = timeArray[indexPath.row].time
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.black
            cell.selectedBackgroundView = backgroundView
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            timeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showVC", sender: nil)
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showVC" {
                if let vc = segue.destination as? EditAlarmViewController {
                    vc.selectedMinute = timeArray[indexPath.row].time
                }
            }
        }
    }
}
