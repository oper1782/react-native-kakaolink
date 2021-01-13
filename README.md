# react-native-kakaolink


# 초기세팅
- Android
https://developers.kakao.com/docs/latest/ko/getting-started/sdk-android

- IOS
https://developers.kakao.com/docs/latest/ko/getting-started/sdk-ios




# 사용법

- 초기 세팅
app.js에 KakaoLinkModule.init() 추가.

- 메세지 템플릿 보내기
<pre><code>
  KakaoLinkModule.sendScrapMessage(
    {
      title: "제목",
      imageUrl:imgUrl,
      description:'#맛집 #ReactNative'
      webUrl:null,//웹 링크
      mobileWebUrl:null,// 모바일 웹 링크
      buttonTitle:'버튼 이름'
    },
    {key:value}//버튼으로 앱 실행시 받을 수 있는 데이터
  )
  </code></pre>
