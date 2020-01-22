package com.helinyu.music.elegantcamera

import android.Manifest
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.helinyu.music.elegantcamera.Util.PermissionUtils
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private val permissionList = arrayOf(Manifest.permission.READ_PHONE_STATE, Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        system_camera_btn.setOnClickListener {
            PermissionUtils.checkPermission(this, permissionList, Runnable {
                val intent = Intent(this, TakePhotoActivity::class.java)
                intent.putExtra(TakePhotoActivity.TYPE_TAG, TakePhotoActivity.TYPE_CAPTURE)
                startActivity(intent)
            })
        }

        
    }
}
