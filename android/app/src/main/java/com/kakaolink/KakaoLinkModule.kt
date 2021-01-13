package com.kakaolink

import android.util.Log
import androidx.core.content.ContextCompat.startActivity
import com.facebook.react.bridge.*
import com.kakao.sdk.common.KakaoSdk
import com.kakao.sdk.common.util.Utility
import com.kakao.sdk.link.LinkClient
import com.kakao.sdk.template.model.*


private var context: ReactApplicationContext? = null
private var TAG:String = "123";

class KakaoLinkModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "KakaoLinkModule"
    }

    @ReactMethod
    public fun init() {
        KakaoSdk.init(this.reactApplicationContext, reactApplicationContext.getString(R.string.kakao_app_key))
    }

    @ReactMethod
    public fun sendScrapMessage(contents:ReadableMap,options:ReadableMap?) {
        val jsonObj:MutableMap<String,String> = MapUtil.toMap(contents) as MutableMap<String, String>;
//        val jsonObj: JSONObject? = convertReadableMapToJsonObject(contents)
        val title: String = jsonObj?.get("title") ?: "제목없음";
        val description:String? = jsonObj?.get("description");
        val imageUrl: String = jsonObj?.get("imageUrl") ?: "";

        val webUrl: String? = jsonObj?.get("webUrl");
        val mobileWebUrl: String? = jsonObj?.get("mobileWebUrl");
        val buttonTitle : String? = jsonObj?.get("buttonTitle");

//        val optionsJson: JSONObject? = convertReadableMapToJsonObject(options);


        var optionsJson:MutableMap<String,String>? = null;
        if(options != null){
            optionsJson = MapUtil.toMap(options) as MutableMap<String, String>;
        }

        val defaultFeed = FeedTemplate(
                content = Content(
                        title = title!!,
                        description = description,
                        imageUrl = imageUrl,
                        link = Link(
                                webUrl = webUrl,
                                mobileWebUrl = mobileWebUrl,
                                androidExecParams = optionsJson,
                                iosExecParams = optionsJson
                        )
                ),
                social = Social(
                ),
                buttonTitle = buttonTitle
//                buttons = listOf(
//                        Button(
//                                "웹으로 보기",
//                                Link(
//                                        webUrl = "https://developers.kakao.com",
//                                        mobileWebUrl = "https://developers.kakao.com"
//                                )
//                        ),
//                        Button(
//                                "앱으로 보기",
//                                Link(
//                                        androidExecParams = optionsJson,
//                                        iosExecParams = optionsJson
//                                )
//                        )
//                )
        )

        LinkClient.instance.defaultTemplate(this.reactApplicationContext, defaultFeed) { linkResult, error ->
            if (error != null) {
                Log.e(TAG, "카카오링크 보내기 실패", error)
            }
            else if (linkResult != null) {
                var keyHash = Utility.getKeyHash(this.reactApplicationContext)
                Log.d(TAG, "카카오링크 보내기 성공 ${linkResult.intent} : ${keyHash}")
                startActivity(this.reactApplicationContext,linkResult.intent,null);


                // 카카오링크 보내기에 성공했지만 아래 경고 메시지가 존재할 경우 일부 컨텐츠가 정상 동작하지 않을 수 있습니다.
                Log.w(TAG, "Warning Msg: ${linkResult.warningMsg}")
                Log.w(TAG, "Argument Msg: ${linkResult.argumentMsg}")
            }
        }
    }


    @ReactMethod
    public fun someMethod(someParameter: String) {
        // TODO What you want to do
    }
}


