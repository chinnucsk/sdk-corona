local metadata =
{
	plugin =
	{
		format = 'jar',
		manifest = 
		{
			permissions = {},
			usesPermissions =
			{
				"android.permission.INTERNET",
				"android.permission.WRITE_EXTERNAL_STORAGE",
			},
			usesFeatures = {},
			applicationChildElements =
			{
				[[
				<activity 
					android:name="v2.com.playhaven.interstitial.PHInterstitialActivity" 
					android:theme="@android:style/Theme.Translucent"
		            android:windowSoftInputMode="adjustResize"/>
				]],
				[[
				<activity 
					android:name="com.playhaven.src.publishersdk.content.PHContentView"
					android:theme="@android:style/Theme.Dialog" 
					android:windowSoftInputMode="adjustResize"/>
				]],
			},
		},
	},
}

return metadata