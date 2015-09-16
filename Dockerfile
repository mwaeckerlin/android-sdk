FROM ubuntu
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
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo "y"; done ) | ${ANDROID_HOME}/tools/android update sdk -u

WORKDIR /android

CMD ( sleep 5 && while [ 1 ]; do sleep 1; echo "y"; done ) | \
	${ANDROID_HOME}/tools/android update sdk -u && \
        sleep infinity

VOLUME /android
