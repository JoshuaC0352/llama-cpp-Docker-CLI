# llama-cpp-Docker-CLI
A docker file setup that contains a command line interface that can interface with a desired .gguf LLM

Pull the repository, then use a docker build command to build the docker image.  When you run the image use docker run -it [image_name].  It has to be run in interactive mode, since it uses a command line interface.

The synthia model this is using will need to be downloaded separately as well, as I am not able to store it in github.  Link is provided in the models folder.  Alternatively alternate models can be used with a simple code update to the LLM_Interface.py file.
