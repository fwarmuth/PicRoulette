# Pic Roulette
A simple flutter app that servces a random image from a directory of images.

## Getting Started
1. Clone the repo
2. Due to flutter web limitations, you must run copy your images at container build time. 
```
copy <path-to-image-dir> ./random_image_app/assets/images
```
3. Set the name of the app in the `.env` file
```
APP_TITLE=<your-app-name>
```

4. Build the docker image
```
docker build -t pic-roulette -f .devcontainer/Dockerfile .
```
5. Run the docker image
```
docker run -d -v <path-to-image-dir>:/app/ -p 1337:8080 pic-roulette
```

## Dev
1. Clone the repo
2. Open with VSCode
3. Install the devcontainer extension
4. Open the project in the devcontainer
5. Go