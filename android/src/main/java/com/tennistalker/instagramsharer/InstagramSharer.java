// Assicurati che il package name sia corretto
package com.tennistalker.instagramsharer;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.util.Base64;
import androidx.core.content.FileProvider;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import java.io.File;
import java.io.FileOutputStream;

@CapacitorPlugin(name = "InstagramSharer")
public class InstagramSharer extends Plugin {

    @PluginMethod
    public void shareToStory(PluginCall call) {
        String base64String = call.getString("imageBase64");
        String appId = call.getString("appId");

        if (base64String == null || appId == null) {
            call.reject("Missing imageBase64 or appId option");
            return;
        }

        try {
            byte[] imageData = Base64.decode(base64String, Base64.DEFAULT);
            File cachePath = new File(getContext().getCacheDir(), "images");
            cachePath.mkdirs();
            File imageFile = new File(cachePath, "share.png");
            FileOutputStream stream = new FileOutputStream(imageFile);
            stream.write(imageData);
            stream.flush();
            stream.close();

            String authority = getContext().getPackageName() + ".fileprovider";
            Uri contentUri = FileProvider.getUriForFile(getContext(), authority, imageFile);

            Intent intent = new Intent("com.instagram.share.ADD_TO_STORY");
            intent.putExtra("source_application", appId);
            intent.setDataAndType(contentUri, "image/png");
            intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

            PackageManager pm = getContext().getPackageManager();
            if (pm.resolveActivity(intent, 0) != null) {
                getActivity().startActivity(intent);
                call.resolve();
            } else {
                call.reject("Instagram app is not installed.");
            }
        } catch (Exception e) {
            call.reject("An error occurred while sharing.", e);
        }
    }
}