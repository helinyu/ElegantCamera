package com.helinyu.music.elegantcamera.Util

import android.app.AlertDialog
import android.app.AlertDialog.*
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Settings
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.cs.camerademo.log
import kotlin.math.log

object PermissionUtils  {
    const val PERMISSION_REQUEST_CODE = 100
    const val PERMISSION_SETTING_CODE = 101

    private  var permissionExplainDialog: AlertDialog? = null;
    private  var permissionSettingDialog: AlertDialog? = null;

//    检查权限
    fun checkPermission(activity: AppCompatActivity, permissionList: Array<String>, callback: Runnable) {
        var allGranted = true;
        permissionList.forEach {
            var result = ContextCompat.checkSelfPermission(activity, it)
            log("检查权限  $it  结果: $result")

            if (result != PackageManager.PERMISSION_GRANTED) {
                allGranted = false;
                log("没有权限")
            }
        }

        if (allGranted) {
            callback.run()
        } else { // 申请权限
            startRequestPermission(activity, permissionList);
        }
    }

//     之前拒绝过， 展示需要权限的提示框， 否则直接请求相关权限
    private fun startRequestPermission(activity: AppCompatActivity, permissionList: Array<String>) {
        permissionList.forEach {

            /**shouldShowRequestPermissionRationale
             * 如果之前请求的时候拒绝过， 该方法就返回true
             * 如果之前请求的时候拒绝过， 兵器诶选择了"不在询问'， 赶回false
             */
            if (ActivityCompat.shouldShowRequestPermissionRationale(activity, it)) {
                log("show persmission explain diamonlog ()")
                showPermissionExplainDialog(activity, permissionList)
            }
            else {
                log("request permission");
                requestPermission(activity, permissionList)
            }
        }

    }


//    甚至的请求权限方法
    private fun requestPermission(activity: AppCompatActivity, permissionList: Array<String>) {
        ActivityCompat.requestPermissions(activity, permissionList, PERMISSION_REQUEST_CODE)
    }


    /** 之前拒绝过， 暂时一个对话框，解释为什么需要这个权限
      */
    private fun showPermissionExplainDialog(activity: AppCompatActivity, permissionList: Array<String>) {
        if (permissionExplainDialog == null) {
            permissionExplainDialog = AlertDialog.Builder(activity).setTitle("申请权限")
                .setMessage("您刚才拒绝了相关权限， 但是现在应用需要这个权限，" + "点击确定申请权限， 点击取消将无法使用这个功能")
                .setPositiveButton("确定") { dialog,
                                           which ->
                    requestPermission(activity, permissionList)
                    dialog.cancel()
                }.create()
        }

        permissionExplainDialog?.let {
            if (!it.isShowing) {
                it.show()
            }
        }
    }

//     最后异步
    /**
     * 最后异步： 用户决绝并且勾线了不提示，那么只能够引导用户去设置页面打开权限
     */
    fun showPermissionSettingDialog(activity: AppCompatActivity, permissionList: Array<String>) {
        if (permissionSettingDialog == null) {
            permissionSettingDialog = AlertDialog.Builder(activity). setTitle ("权限设置")
                .setMessage("您刚才拒绝了相关的权限，请到应用设置页面更改应用的权限")
                .setPositiveButton("确定") { dialog, _ ->
                    val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                    val uri = Uri.fromParts("package", activity.packageName, null)
                    intent.data = uri
                    activity.startActivityForResult(intent, PERMISSION_SETTING_CODE)
                    dialog.cancel()
                }
                .setNegativeButton("取消") { dialog, _ ->
                    dialog.cancel()
                }
                .create()
        }

        permissionSettingDialog?.let {
            if (!it.isShowing) {
                it.show()
            }
        }
    }
}