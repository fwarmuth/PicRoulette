# Use an official Ubuntu runtime as a parent image
FROM ubuntu:22.04

# Set environment variables for Flutter
ENV FLUTTER_HOME=/flutter \
    FLUTTER_VERSION=2.10.2 \
    DART_HOME=/flutter/bin/cache/dart-sdk \
    PATH=${PATH}:/flutter/bin:/flutter/bin/cache/dart-sdk/bin

# # Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
      curl \
      unzip \
      git

# Download and install Flutter
RUN git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} && \
    cd ${FLUTTER_HOME} && \
    git checkout ${FLUTTER_VERSION} && \
    ./bin/flutter --version

# Add Flutter and Dart to the system PATH
ENV PATH="${PATH}:${FLUTTER_HOME}/bin:${DART_HOME}/bin"

# Install Dart
RUN ${FLUTTER_HOME}/bin/flutter --version && \
    ${FLUTTER_HOME}/bin/flutter precache && \
    ${FLUTTER_HOME}/bin/flutter pub global activate dartdoc

