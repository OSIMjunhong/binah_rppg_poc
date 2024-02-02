package ai.binah.binah_flutter_sdk

import ai.binah.sdk.api.images.ImageData
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.SharedFlow

interface ImageDataSource {

    val images: Flow<ImageData>
}