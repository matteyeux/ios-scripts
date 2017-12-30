#!/bin/bash
# From to.panga repository
# just added a simple var when ppl ask me to build multiple IPAs 
APP=g0blin
$(which xcodebuild) clean build CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY="" -sdk `xcrun --sdk iphoneos --show-sdk-path` -arch arm64
mv build/Release-iphoneos/$APP.app $APP.app
mkdir Payload
mv $APP.app Payload/$APP.app
zip -r9 $APP.ipa Payload/$APP.app
rm -rf build Payload
