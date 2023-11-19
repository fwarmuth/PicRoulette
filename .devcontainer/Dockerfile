# Use an official Ubuntu runtime as a parent image
FROM ubuntu:22.04 AS base

# # Install necessary dependencies and remove the apt packages cache when done.
RUN apt-get update && \
    apt-get install -y \
      curl \
      unzip \
      wget \
      git \
      apt-transport-https

# Install chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb
RUN rm ./google-chrome-stable_current_amd64.deb

# Set environment variables for Flutter
ENV FLUTTER_HOME=/flutter \
    FLUTTER_VERSION=2.10.2 \
    DART_HOME=/flutter/bin/cache/dart-sdk \
    PATH=${PATH}:/flutter/bin:/flutter/bin/cache/dart-sdk/bin

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


# Copy app to /app
# Start to run Flutter commands
# doctor to see if all was installes ok
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade

# # copy source code to folder
COPY random_image_app /app
# stup new folder as the working directory
WORKDIR /app
# Run build: 1 - clean, 2 - pub get, 3 - build web
RUN flutter clean
RUN flutter pub get
RUN flutter build web

FROM nginx:1.21.1-alpine 
COPY --from=base /app/build/web /usr/share/nginx/html
