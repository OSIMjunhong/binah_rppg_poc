import Foundation


class BinahEventChannel: NSObject, FlutterStreamHandler {
    
    static let eventChannelId = "plugins.binah.ai/sdk_events"
    private var eventSink: FlutterEventSink?
    
    init(messenger: FlutterBinaryMessenger) {
        super.init()
        let channel = FlutterEventChannel(name: BinahEventChannel.eventChannelId, binaryMessenger: messenger)
        channel.setStreamHandler(self)
    }
    
    func sendEvent(name: String, payload: Any) {
        DispatchQueue.main.async {
            self.eventSink?([
                "event": name,
                "payload": payload
            ])
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
