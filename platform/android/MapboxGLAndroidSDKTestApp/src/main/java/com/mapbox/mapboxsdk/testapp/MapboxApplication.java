package com.mapbox.mapboxsdk.testapp;

import android.app.Application;
import android.os.StrictMode;

import com.mapbox.mapboxsdk.MapboxAccountManager;
import com.squareup.leakcanary.LeakCanary;
import timber.log.Timber;

import static timber.log.Timber.DebugTree;

public class MapboxApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        if (LeakCanary.isInAnalyzerProcess(this)) {
            // This process is dedicated to LeakCanary for heap analysis.
            // You should not init your app in this process.
            return;
        }
        LeakCanary.install(this);

        initializeLogger();

        StrictMode.setThreadPolicy(new StrictMode.ThreadPolicy.Builder()
                .detectDiskReads()
                .detectDiskWrites()
                .detectNetwork()
                .penaltyLog()
                .build());
        StrictMode.setVmPolicy(new StrictMode.VmPolicy.Builder()
                .detectLeakedSqlLiteObjects()
                .penaltyLog()
                .penaltyDeath()
                .build());

        MapboxAccountManager.start(getApplicationContext(), getString(R.string.mapbox_access_token));
    }

    private void initializeLogger() {
        if (BuildConfig.DEBUG) {
            Timber.plant(new DebugTree());
        }
    }
}
