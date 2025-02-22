#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
          install_resource "ELCImagePickerController/Classes/ELCImagePicker/Resources/ELCAlbumPickerController.xib"
                    install_resource "ELCImagePickerController/Classes/ELCImagePicker/Resources/ELCAssetPicker.xib"
                    install_resource "ELCImagePickerController/Classes/ELCImagePicker/Resources/ELCAssetTablePicker.xib"
                    install_resource "ELCImagePickerController/Classes/ELCImagePicker/Resources/Overlay.png"
                    install_resource "ELCImagePickerController/Classes/ELCImagePicker/Resources/Overlay@2x.png"
                    install_resource "SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/zh-Hans.lproj/UMFeedbackLocalizable.strings"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/bubble_min@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/cancel@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/microphone@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/save@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/ToolViewInputText@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/ToolViewInputTextHL@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/ToolViewInputVoice@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/ToolViewInputVoiceHL@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/umeng_add_photo@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/umeng_fb_audio_dialog_cancel@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/umeng_fb_audio_dialog_content@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/umeng_fb_audio_play_01@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/umeng_fb_audio_play_02@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/umeng_fb_audio_play_03@2x.png"
                    install_resource "UMengFeedback/UMFeedback_iOS_2.2/UMengFeedback_SDK_2.2/Resources/umeng_fb_audio_play_default@2x.png"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/UMSocialSDKResourcesNew.bundle"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/TencentOpenApi_IOS_Bundle.bundle"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMSCommentDetailController.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMSCommentInputController.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMSCommentInputControlleriPad.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMShareEditViewController.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMShareEditViewControlleriPad.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMSLoginViewController.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMSnsAccountViewController.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/SocialSDKXib/UMSShareListController.xib"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/en.lproj"
                    install_resource "UMengSocial/umeng_ios_social_sdk_4.2.2_arm64_custom/UMSocial_Sdk_4.2.2/zh-Hans.lproj"
          
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
