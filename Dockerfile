FROM ubuntu:22.04 as base

RUN apt-get update && apt-get install -y \
	python3.10 \
    python3-pip \
	ubuntu-drivers-common \
	nvidia-driver-535 \
    gcc-11 \
	g++-11 \
	wget \
	build-essential \
	vim
	
RUN python3 -m pip install --upgrade pip
# --break-system-packages

WORKDIR /~/app
RUN cd /~/app

Add LLM_Interface.py .
Add index.html .
Copy ./models models/
	
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
RUN mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN wget https://developer.download.nvidia.com/compute/cuda/12.3.1/local_installers/cuda-repo-ubuntu2204-12-3-local_12.3.1-545.23.08-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu2204-12-3-local_12.3.1-545.23.08-1_amd64.deb
RUN cp /var/cuda-repo-ubuntu2204-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/
RUN sudo apt-get update
RUN apt-get -y install cuda-toolkit-12-3

RUN python3 -m pip install flask

RUN CUDACXX=/usr/local/cuda-12.3/bin/nvcc CMAKE_ARGS="-DLLAMA_CUBLAS=on -DCUDA_PATH=/usr/local/cuda-12.3 -DCUDAToolkit_ROOT=/usr/local/cuda-12.3 -DCUDAToolkit_INCLUDE_DIR=/usr/local/cuda-12.3/include -DCUDAToolkit_LIBRARY_DIR=/usr/local/cuda-12.3/lib64 -DCMAKE_CUDA_ARCHITECTURES=native" FORCE_CMAKE=1  pip install llama-cpp-python --force-reinstall --upgrade --no-cache-dir --verbose
EXPOSE 8080
#CMD ["python", "./LLM_Interface.py"]
CMD python3 LLM_Interface.py
