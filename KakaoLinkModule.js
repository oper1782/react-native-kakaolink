
import { Platform, NativeModules } from 'react-native'



const KakaoLink = {

  init : () =>{
    if(Platform.OS ==='android'){
      NativeModules.KakaoLinkModule.init()
    }else{
      NativeModules.KakaoLinkModule.initKakao()
    }
  },
  sendScrapMessage:(feedTemplate,options) => {
    const { title, imageUrl, description, webUrl, mobileWebUrl, buttonTitle} = feedTemplate;

      NativeModules.KakaoLinkModule.sendScrapMessage(
        {
          title,
          imageUrl,
          description,
          webUrl,
          mobileWebUrl,
          buttonTitle,
        },
        options
      )
    }
}
export default KakaoLink
