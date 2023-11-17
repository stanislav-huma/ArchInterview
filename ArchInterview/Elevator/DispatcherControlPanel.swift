//
//  AnyDispatcherControlPanel.swift
//  ArchInterview
//
//  Created by Ash Censo on 17.11.2023.
//

import Foundation

protocol AnyPublicDispatcherControlPanel: AnyObject {
    var powerState: PowerState { get }
    func turnPowerState()
}

protocol AnyDispatcherControlPanel: AnyObject {
    var powerState: PowerState { get set }
}

final class DispatcherControlPanel: AnyDispatcherControlPanel {
    var powerState: PowerState = .on
    
    private let elevatorController: AnyElevatorController
    
    init(elevatorController: AnyElevatorController) {
        self.elevatorController = elevatorController
    }
    
    func turnPowerState() {
        elevatorController.turnPowerState()
    }
}
