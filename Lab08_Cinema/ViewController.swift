//
//  ViewController.swift
//  Lab08_Cinema
//
//  Created by abensefia on 02/03/2022.
//

import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    
    // Variables
    var name:String = ""
    var vip:Bool = true
    var nbr_tickets:Int = 0
    
    // Outlets
    @IBOutlet weak var lbl_tickets: UILabel!
    @IBOutlet weak var txt_name: UITextField!
    
    // Actions
    @IBAction func stp_Tickets(_ sender: UIStepper) {
        nbr_tickets = Int(sender.value)
        lbl_tickets.text = "\(sender.value)"
    }
    //*--------------------------------------
    
    @IBAction func sw_vip(_ sender: UISwitch) {
        vip = sender.isOn
    }
    //*--------------------------------------
    

    @IBAction func btn_calculate(_ sender: Any) {
        name = txt_name.text!
        
        var total = 0
        if vip {
            total = 150*nbr_tickets
        }
        else {
            total = 100*nbr_tickets
        }
        
        // Create the alert an display the information
        createAlert(amount: total)
        
        // Call a notification to remind the user to pay
        createNotification()
        
    }
    //*--------------------------------------
    
    func createAlert(amount:Int){
        
        var myMessage:String = "Mr. \(name)  your total amount is: \(amount)"
        
        let myAlert = UIAlertController(title: "Amount", message: myMessage, preferredStyle: .alert)
        
        let myOK = UIAlertAction(title: "OK", style: .default) { myaction in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(myOK)
        
        present(myAlert, animated: true, completion: nil)
        
        
    }
    //*--------------------------------------
    
    func createNotification(){
        
        let myContent = UNMutableNotificationContent()
        myContent.title = "VOX Cinema"
        myContent.subtitle = "Payment Reminder"
        myContent.body = "You need to pay the tickets soon to secure seats for this wonderful movie"
        myContent.badge = 1
        
        let myTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let myRequest = UNNotificationRequest(identifier: "Notif1", content: myContent, trigger: myTrigger)
        
        UNUserNotificationCenter.current().add(myRequest) { myError in
            if let error = myError {
                print ("Error sending notification: ", error.localizedDescription)
            }
        }
        
        
    }
    
    //*--------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request authorisation to send notifications
        let myCenter = UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, myError in
            
            if let error=myError {
                print("Error request authorisation ", error.localizedDescription)
            }
            else{
                UNUserNotificationCenter.current().delegate = self
            }
        }
        
    }


}

