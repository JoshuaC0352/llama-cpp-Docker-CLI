# llama-cpp-Docker-CLI
The command line interface has been updated to a html interface, the python script has been turned into a listener script.

Pull the repository, then use a docker build command to build the docker image.  When you run the image use docker run -p 8080:8080 [image_name].

The synthia model this is using will need to be downloaded separately as well, as I am not able to store it in github.  Link is provided in the models folder.  Alternatively, different models can be used with a simple code update to the LLM_Interface.py file.

This utelizes the llama-cpp interface found here:
https://github.com/ggerganov/llama.cpp
