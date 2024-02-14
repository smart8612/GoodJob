#!/bin/sh

#  ci_post_clone.sh
#  GoodJob
#
#  Created by JeongTaek Han on 2/14/24.
#  


# 1. GOOGLE_SERVICE_INFO_PLIST 환경변수가 존재하는지 확인
if [ -n "$GOOGLE_SERVICE_INFO_PLIST" ]; then
    echo "GOOGLE_SERVICE_INFO_PLIST 환경변수가 발견되었습니다."
    
    # 환경변수 값을 GoogleService-Info.plist 파일에 저장
    echo "$GOOGLE_SERVICE_INFO_PLIST" > "$CI_PRIMARY_REPOSITORY_PATH"/"$CI_PRODUCT"/"$CI_PRODUCT"/GoogleService-Info.plist
    echo "GoogleService-Info.plist 파일을 프로젝트 디렉토리 내에 생성하였습니다."
else
    echo "GOOGLE_SERVICE_INFO_PLIST 환경변수가 존재하지 않습니다. 스크립트를 종료합니다."
fi

exit 0
