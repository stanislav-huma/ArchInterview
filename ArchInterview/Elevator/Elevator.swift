//
//  Elevator.swift
//  ArchInterview
//
//  Created by Ash Censo on 17.11.2023.
//

import Foundation

enum ElevatorState {
    case idle
    case openingDoors
    case idleWithOpenDoors
    case closingDoors
    case moving(floorsCount: Int)
}

protocol AnyElevator: AnyObject {
    var elevatorState: ElevatorState { get }
    var elevatorStateDidChange: ((ElevatorState) -> Void)? { get set }
    
    func openDoor()
    func stop()
}

final class Elevator: AnyElevator {
    var elevatorState: ElevatorState = .idle {
        didSet {
            switch elevatorState {
            case .idle:
                break
            case .openingDoors:
                timer = .scheduledTimer(withTimeInterval: TimeInterval(doorsMovementSpeed), repeats: true, block: { [weak self] _ in
                    self?.timer?.invalidate()
                    self?.timer = nil
                    self?.elevatorState = .idleWithOpenDoors
                })
                timer?.fire()
            case .idleWithOpenDoors:
                timer = .scheduledTimer(withTimeInterval: TimeInterval(floorStayingTime), repeats: false, block: { [weak self] _ in
                    self?.timer?.invalidate()
                    self?.timer = nil
                    self?.elevatorState = .closingDoors
                })
                timer?.fire()
            case .closingDoors:
                timer = .scheduledTimer(withTimeInterval: TimeInterval(doorsMovementSpeed), repeats: false, block: { [weak self] _ in
                    self?.timer?.invalidate()
                    self?.timer = nil
                })
                timer?.fire()
            case .moving(let floorsCount):
                timer = .scheduledTimer(withTimeInterval: TimeInterval(doorsMovementSpeed * floorsCount), repeats: false, block: { [weak self] _ in
                    self?.timer?.invalidate()
                    self?.timer = nil
                    self?.elevatorState = .idle
                })
                timer?.fire()
            }
            
            elevatorStateDidChange?(elevatorState)
        }
    }
    
    var elevatorStateDidChange: ((ElevatorState) -> Void)?
    
    private let elevatorController: AnyElevatorController
    
    init(elevatorController: AnyElevatorController) {
        self.elevatorController = elevatorController
    }
    
    private let movementSpeed = 3
    private let floorStayingTime = 10
    private let doorsMovementSpeed = 5
    
    private var timer: Timer?
    
    func openDoor() {
        elevatorState = .openingDoors
    }
    
    func move(countofFloors: Int) {
        
    }
}
