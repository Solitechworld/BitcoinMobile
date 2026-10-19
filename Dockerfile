FROM eclipse-temurin:17-jdk-jammy
ENV ANDROID_HOME=/opt/android-sdk
RUN apt-get update && apt-get install -y wget unzip python3 && rm -rf /var/lib/apt/lists/* \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/tools.zip \
    && unzip -q /tmp/tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm /tmp/tools.zip \
    && yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses > /dev/null \
    && ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

WORKDIR /app
COPY . .
RUN chmod +x ./gradlew
CMD ["./gradlew", "test"]
