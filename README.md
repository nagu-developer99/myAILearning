This is just a place holder of a docker image that when run, brings up a container that has langchain libraries and faiss -gpu to play around.
This image also has ollama with mistral downloaded as default.

Run it this way:

docker run -d --gpus all -p 8888:8888 -v /C/Users/LENOVO/OneDrive/Documents/pyProjs/testDockerImages/notebooks:/home/jupyter/  aiimage
