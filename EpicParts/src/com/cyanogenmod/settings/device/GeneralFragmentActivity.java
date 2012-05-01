/*
 * Copyright (C) 2011 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cyanogenmod.settings.device;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.CheckBoxPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceFragment;
import android.preference.PreferenceManager;
import android.preference.PreferenceScreen;
import android.util.Log;

import com.cyanogenmod.settings.device.R;

public class GeneralFragmentActivity extends PreferenceFragment {

    private static final String TOUCHKEY_LED_FILE = "/sys/devices/virtual/sec/t_key/touchleds_disabled";
    private static final String PREF_ENABLED = "1";
    private static final String TAG = "EpicParts_General";

    private CheckBoxPreference mTouchkeyLED;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        addPreferencesFromResource(R.xml.general_preferences);

        PreferenceScreen prefSet = getPreferenceScreen();
        mTouchkeyLED = (CheckBoxPreference) findPreference(DeviceSettings.KEY_TOUCHKEYLED);

        if (isSupported(TOUCHKEY_LED_FILE)) {
            mTouchkeyLED.setChecked(PREF_ENABLED.equals(Utils.readOneLine(TOUCHKEY_LED_FILE)));
        } else {
            mTouchkeyLED.setEnabled(false);
        }

    }

    @Override
    public boolean onPreferenceTreeClick(PreferenceScreen preferenceScreen, Preference preference) {

        String boxValue;
        String key = preference.getKey();

        Log.w(TAG, "key: " + key);
	if (key.equals(DeviceSettings.KEY_TOUCHKEYLED)) {
            final CheckBoxPreference chkPref = (CheckBoxPreference) preference;
            boxValue = chkPref.isChecked() ? "1" : "0";
            Utils.writeValue(TOUCHKEY_LED_FILE, boxValue);
        }

        return true;
    }

    public static boolean isSupported(String FILE) {
        return Utils.fileExists(FILE);
    }

    public static void restore(Context context) {
        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
        if (isSupported(TOUCHKEY_LED_FILE)) {
            String sDefaultValue = Utils.readOneLine(TOUCHKEY_LED_FILE);
            Utils.writeValue(TOUCHKEY_LED_FILE, sharedPrefs.getBoolean(DeviceSettings.KEY_TOUCHKEYLED, PREF_ENABLED.equals(sDefaultValue)));
        }
    }
}
