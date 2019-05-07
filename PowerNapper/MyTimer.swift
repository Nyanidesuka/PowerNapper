//
//  MyTimer.swift
//  PowerNapper
//
//  Created by Haley Jones on 5/7/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class MyTimer: NSObject {
    
    var timeRemaining: TimeInterval?
    var timer: Timer?
    var isOn: Bool {
        return timeRemaining != nil
    }
    
    var timeAsString: String {
        let timeLeft = Int(self.timeRemaining ?? 20 * 60)
        let minutesRemaining = timeLeft / 60
        let secondsRemaining = timeLeft - (minutesRemaining * 60)
        return String(format: "%02d : %02d", arguments: [minutesRemaining, secondsRemaining])
    }
    
    func startTimer(time: TimeInterval){
        if !isOn{
            timeRemaining = time
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                    self.secondTick()
                })
            }
        }
    }
    
    func stopTimer(){
        if isOn{
            timeRemaining = nil
        }
    }
    
    func secondTick(){
        guard let timeLeft = timeRemaining else {return}
        if timeLeft > 0{
            self.timeRemaining = timeLeft - 1
            print(self.timeRemaining ?? 0)
        } else {
            timer?.invalidate()
            self.timeRemaining = nil
        }
    }
}
