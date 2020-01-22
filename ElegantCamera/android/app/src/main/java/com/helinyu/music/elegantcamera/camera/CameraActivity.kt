package com.helinyu.music.elegantcamera.camera

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.helinyu.music.elegantcamera.R

class CameraActivity : AppCompatActivity() {
    companion object {
        const val TYPE_TAG = "type"
        const val TYPE_CAPTURE = 0
        const val TYPE_RECORD = 1
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_camera)
    }
}
