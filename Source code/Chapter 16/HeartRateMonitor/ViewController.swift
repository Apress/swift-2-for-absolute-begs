//
//  ViewController.swift
//  HeartRateMonitor
//
//  Created by Gary Bennett on 9/10/15.
//  Copyright (c) 2016 xcelMe. All rights reserved.
//

import UIKit
import CoreBluetooth
import HealthKit


class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    let PULSESCALE:NSNumber = 1.2
    let PULSEDURATION:NSNumber = 0.2
    var heartRate:UInt16!
    let healthKitStore:HKHealthStore = HKHealthStore()
    var centralManager:CBCentralManager!
    var connectingPeripheral:CBPeripheral!
    var pulseTime:NSTimer!

    @IBOutlet weak var bpmOutlet: UILabel!
    @IBOutlet weak var connectedOutlet: UILabel!
    @IBOutlet weak var heartView: UIImageView!
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
        self.requestAuthorisationForHealthStore()
        self.heartRate = 0;
    }
    
    
    func centralManagerDidUpdateState(central: CBCentralManager){
        switch central.state{
        case .PoweredOn:
            print("poweredOn")
            
            let serviceUUIDs:[CBUUID] = [CBUUID(string:"180D")]
            let lastPeripherals = centralManager.retrieveConnectedPeripheralsWithServices(serviceUUIDs)
            print(lastPeripherals.count)
            if lastPeripherals.count > 0{
                connectingPeripheral = lastPeripherals.last as CBPeripheral?;
                connectingPeripheral.delegate = self
                centralManager.connectPeripheral(connectingPeripheral, options: nil)
                connectedOutlet.text = "Connected"
            }
            else {
                centralManager.scanForPeripheralsWithServices(serviceUUIDs, options: nil)
                connectedOutlet.text = "Disconnected"
            }
            
        default:
            print(central.state)
        }
        
        
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        connectingPeripheral = peripheral
        connectingPeripheral.delegate = self
        centralManager.connectPeripheral(connectingPeripheral, options: nil)
        connectedOutlet.text = "Connected"
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        
        peripheral.discoverServices(nil)
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if let actualError = error{
            print("\(actualError)")
            
        }else {
            switch characteristic.UUID.UUIDString{
            case "2A37":
                update(characteristic.value!)
            default:
                print("")
            }
        }
    }

    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        
        if let actualError = error{
            print("\(actualError)")
        }
        else {
            for service in peripheral.services as [CBService]!{
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        
        if let actualError = error{
            print("\(actualError)")
        }
        else {
            
            if service.UUID == CBUUID(string:"180D"){
                for characteristic in (service.characteristics as [CBCharacteristic]?)!{
                    switch characteristic.UUID.UUIDString{
                        
                    case "2A37":
                        // Set notification on heart rate measurement
                        print("Found a Heart Rate Measurement Characteristic")
                        peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                        
                    case "2A38":
                        // Read body sensor location
                        print("Found a Body Sensor Location Characteristic")
                        peripheral.readValueForCharacteristic(characteristic)
                        
                    case "2A39":
                        // Write heart rate control point
                        print("Found a Heart Rate Control Point Characteristic")
                        
                        var rawArray:[UInt8] = [0x01];
                        let data = NSData(bytes: &rawArray, length: rawArray.count)
                        peripheral.writeValue(data, forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithoutResponse)
                        
                    default:
                        print("")
                    }
                    
                }
            }
        }
    }
    
    func update(heartRateData:NSData){
        var buffer = [UInt8](count: heartRateData.length, repeatedValue: 0x00)
        heartRateData.getBytes(&buffer, length: buffer.count)
        
        var bpm:UInt16?
        if (buffer.count >= 2){
            if (buffer[0] & 0x01 == 0){
                bpm = UInt16(buffer[1]);
            }else {
                bpm = UInt16(buffer[1]) << 8
                bpm =  bpm! | UInt16(buffer[2])
            }
        }
        
        if let actualBpm = bpm{
            print("actualBpm \(actualBpm)")
            self.bpmOutlet.text = String(actualBpm)
            
            let rate = 60.0 / Float(self.heartRate)
            print("\(rate)")
            self.saveHeartRateIntoHealthStore(Double(bpm!));
            
            let oldBpm = self.heartRate;
            self.heartRate = bpm;
            if (oldBpm == 0) {
                pulse()
                self.pulseTime = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self,
                    selector: "pulse", userInfo: nil, repeats: false)
            }
            
        }else {
            print("bpm \(bpm)")
            self.bpmOutlet.text = "\(bpm)"
        }
    }
    
    func pulse() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        //pulseAnimation.toValue = PULSESCALE;
        pulseAnimation.toValue = NSNumber(float: 1.2)
        pulseAnimation.fromValue = NSNumber(float: 1.0)
        
        //pulseAnimation.duration = PULSEDURATION;
        pulseAnimation.duration = 0.2
        pulseAnimation.repeatCount = 1;
        pulseAnimation.autoreverses = true;
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        heartView.layer.addAnimation(pulseAnimation, forKey: "scale")
        let rate = 60.0 / Float(self.heartRate)
        self.pulseTime = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(rate), target: self, selector: "pulse", userInfo: nil, repeats: false)
    }
    
    
    //healthkit info
    private func saveHeartRateIntoHealthStore(height:Double) -> Void
    {
        // Save the user's heart rate into HealthKit.
        let heartRateUnit: HKUnit = HKUnit.countUnit().unitDividedByUnit(HKUnit.minuteUnit())
        let heartRateQuantity: HKQuantity = HKQuantity(unit: heartRateUnit, doubleValue: height)
        
        let heartRate : HKQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
        let nowDate: NSDate = NSDate()
        
        let heartRateSample: HKQuantitySample = HKQuantitySample(type: heartRate
            , quantity: heartRateQuantity, startDate: nowDate, endDate: nowDate)
        
        self.healthKitStore.saveObject(heartRateSample) { (success:Bool, error:NSError?) -> Void in
            print("done")
        }
    }
    
    private func requestAuthorisationForHealthStore() {
        
        let dataTypesToRead = Set(arrayLiteral:
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
        )
        
        //Requesting the authorization
        healthKitStore.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead) { (success, error) -> Void in
            if( success )
            {
                print("success")
            }
        }
    }
}

