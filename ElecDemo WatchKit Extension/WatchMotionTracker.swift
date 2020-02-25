import Foundation
import CoreMotion

protocol WatchMotionTrackingDelegate: class {
    func needsSendData(_ motionData: String)
}

class MotionTracking: NSObject {
    static let shared = MotionTracking()
    let motionManager = CMMotionManager()
    let sampleInterval = 1.0/50
    let queue = OperationQueue()
    weak var delegate: WatchMotionTrackingDelegate?
    
    override init() {
        super.init()
    }
    
    func configMotionTracker(){
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
        motionManager.deviceMotionUpdateInterval = TimeInterval(exactly: sampleInterval)!
    }
    
    func startTracking() {
        motionManager.startDeviceMotionUpdates(to: queue) { (motion, error) in
            print("Attitude Roll : \(String(describing: motion?.attitude.roll))")
            
            self.delegate?.needsSendData("Attitude Roll : \(String(describing: motion?.attitude.roll))")
            self.delegate?.needsSendData("Attitude Pitch : \(motion!.attitude.pitch)")
        }
    }
    
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        // TODO
    }
}
