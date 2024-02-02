//
//  BinahPreviewFactory.swift
//  binah_flutter_sdk
//
//  Created by Giora Vered on 26/03/2023.
//

import Foundation


class BinahPreviewFactory: NSObject, FlutterPlatformViewFactory {
    
    static let shared: BinahPreviewFactory = BinahPreviewFactory()
    static let cameraPreviewId = "plugins.binah.ai/camera_preview_view"
    
    private var cameraPreview: BinahCameraPreview?
    private var imageDataSource: ImageDataSource?
    
    private override init() { }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let preview = BinahCameraPreview()
        preview.setDataSource(imageDataSource: imageDataSource)
        return preview
    }
    
    func setDataSource(imageDataSource: ImageDataSource) {
        self.imageDataSource = imageDataSource
        cameraPreview?.setDataSource(imageDataSource: imageDataSource)
    }
    
    
    
}
