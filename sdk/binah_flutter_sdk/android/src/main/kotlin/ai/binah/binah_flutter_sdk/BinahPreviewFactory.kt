package ai.binah.binah_flutter_sdk

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

object BinahPreviewFactory: PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    const val cameraPreviewId = "plugins.binah.ai/camera_preview_view"
    private var cameraPreview: BinahCameraPreview? = null
    private var imageDataSource: ImageDataSource? = null

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return BinahCameraPreview(context).also {
            cameraPreview = it
            cameraPreview?.setDataSource(imageDataSource ?: return@also)
        }
    }

    fun setDataSource(imageDataSource: ImageDataSource) {
        this.imageDataSource = imageDataSource
        cameraPreview?.setDataSource(imageDataSource)
    }
}