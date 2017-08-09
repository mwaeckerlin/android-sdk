FROM mwaeckerlin/ubuntu-base
MAINTAINER mwaeckerlin

ENV ANDROID_HOME /android

RUN apt-get update
RUN apt-get install -y wget unzip default-jdk libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

WORKDIR /tmp
RUN wget -q $(wget -q -O- 'https://developer.android.com/sdk' | \
              sed -n 's,.*"\(https\?://.*android-sdk.*linux.*\.tgz\)".*,\1,p')
RUN tar xzf /tmp/android-sdk*linux*.tgz
RUN mv android-sdk-linux /android
RUN rm /tmp/android-sdk*linux*.tgz
# Buildservice on https://hub.docker.com/ →
# ApplyLayer exit status 1 stdout: stderr:
# write /android/system-images/android-23/google_apis/armeabi-v7a/system.img:
# no space left on device
# → so, only update on container creation :p
#RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo "y"; done ) | ${ANDROID_HOME}/tools/android update sdk -u

WORKDIR /android

# accept the license
RUN mkdir licenses
RUN echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > licenses/android-sdk-license"
RUN echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > licenses

CMD ( sleep 5 && while [ 1 ]; do sleep 1; echo "y"; done ) | \
	${ANDROID_HOME}/tools/android update sdk -u && \
        sleep infinity

VOLUME /android
