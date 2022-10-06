//
//  EditAlarmViewController.swift
//  AppAlarm
//
//  Created by Van Ngoc An  on 24/09/2022.
//

import UIKit

class EditAlarmViewController: UIViewController {

    var hour: String = ""
    var minutes: String = ""
    
    var delegate: clockDelegate?
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var labelAlarmLabel: UILabel!
    
    @IBOutlet weak var soundAlarmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerSetup()
    }
    
    @IBAction func repeatButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "repeatVC", sender: nil)
    }
       
    @IBAction func labelAlarmButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "labelVC", sender: nil)
    }
   
    @IBAction func soundButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "soundVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "labelVC" {
            if let vc = segue.destination as? LabelViewController {
                vc.delegateLabel = self
                
            }
        } else  if segue.identifier == "soundVC" {
            if let vc = segue.destination as? SoundViewController {
                vc.delegate = self
            }
        }
        
    }

    @IBAction func snoozeSwitchAction(_ sender: Any) {
        
    }
    
    
    @IBAction func dismissButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        
        //MARK: - Delegate
        if hour == "0"{
            hour = "00"
        } else{
            if (Int(hour) ?? 1) < 10 && hour != "0"{
                hour = "0" + hour
            }
        }
        if minutes == "0"{
            minutes = "00"
        } else {
            if (Int(minutes) ?? 1) < 10 && minutes != "0" {
                minutes = "0" + minutes
            }
        }
        let element: String = "\(hour):\(minutes)"
        
        delegate?.setTime(time: element)
        dismiss(animated: true, completion: nil)
    }
   
    var selectedHour: String = "00"
    var selectedMinute: String = "00"
    func pickerSetup(){
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: 50, y: 70, width: self.view.frame.width - 100, height: 200)
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.selectRow(Int(selectedHour) ?? 0, inComponent: 0, animated: true)
        picker.selectRow(Int(selectedMinute) ?? 0, inComponent: 1, animated: true)
        view.addSubview(picker)
    }

    var currentSound: String = ""
}


extension EditAlarmViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        default:
            return 0
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)"
            }
            
        case 1:
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)"
            }
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
                case 0:
                    hour = "\(row)"
                
                case 1:
                    minutes = "\(row)"
                default:
                    break;
                }
    }
}
extension EditAlarmViewController: PassLabelDelegate, PassSoundAlarmDelegate {
    func updateLabelAlarm(labelAlarm: String) {
        labelAlarmLabel.text = labelAlarm
    }
    func updateSuond(sound: String) {
        soundAlarmLabel.text = sound
        self.currentSound = sound
    }
}
