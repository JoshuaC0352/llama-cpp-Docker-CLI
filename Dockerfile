#FROM alpine:3.14
FROM ubuntu:22.04 as base
#FROM python:3.9-slim-bullseye



#RUN add-apt-repository ppa:ubuntu-toolchain-r/test
#RUN apt update
RUN apt-get update && apt-get install -y \
	python3.10 \
    python3-pip \
	ubuntu-drivers-common \
	nvidia-driver-535 \
    gcc-11 \
	g++-11 \
	wget \
	build-essential
	
RUN python3 -m pip install --upgrade pip
# --break-system-packages

WORKDIR /~/app
RUN cd /~/app

Add LLM_Interface.py .
Copy ./models models/
	
#RUN wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
#RUN mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
#RUN wget https://developer.download.nvidia.com/compute/cuda/12.3.1/local_installers/cuda-repo-wsl-ubuntu-12-3-local_12.3.1-1_amd64.deb
#RUN dpkg -i cuda-repo-wsl-ubuntu-12-3-local_12.3.1-1_amd64.deb
#RUN cp /var/cuda-repo-wsl-ubuntu-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/
#RUN apt-get update
#RUN apt-get -y install cuda-toolkit-12-3

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
RUN mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN wget https://developer.download.nvidia.com/compute/cuda/12.3.1/local_installers/cuda-repo-ubuntu2204-12-3-local_12.3.1-545.23.08-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu2204-12-3-local_12.3.1-545.23.08-1_amd64.deb
RUN cp /var/cuda-repo-ubuntu2204-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/
RUN sudo apt-get update
RUN apt-get -y install cuda-toolkit-12-3
	
	

#RUN source ~/.bashrc
#RUN python3 -m pip install . --break-system-packages


#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 --slave /usr/bin/g++ g++ /usr/bin/g++-11
#RUN python3 -m pip install --upgrade pip
#RUN pip install --upgrade setuptools wheel
#RUN sudo apt-get install build-essential
#RUN python3 -m pip install --upgrade setuptools wheel --break-system-packages
#RUN CUDACXX=/usr/local/cuda-12/bin/nvcc CMAKE_ARGS="-DLLAMA_CUBLAS=on -DCMAKE_CUDA_ARCHITECTURES=native" FORCE_CMAKE=1 python3 -m pip install llama-cpp-python --no-cache-dir --force-reinstall --upgrade
#RUN LLAMA_CUBLAS=1 CMAKE_ARGS="-DLLAMA_CUBLAS=on" pip install llama-cpp-python
#RUN CUDACXX=/usr/local/cuda-12/bin/nvcc CMAKE_ARGS="-DLLAMA_CUBLAS=on -DCMAKE_CUDA_ARCHITECTURES=native" FORCE_CMAKE=1 pip install llama-cpp-python --no-cache-dir --force-reinstall --upgrade
RUN CUDACXX=/usr/local/cuda-12.3/bin/nvcc CMAKE_ARGS="-DLLAMA_CUBLAS=on -DCUDA_PATH=/usr/local/cuda-12.3 -DCUDAToolkit_ROOT=/usr/local/cuda-12.3 -DCUDAToolkit_INCLUDE_DIR=/usr/local/cuda-12.3/include -DCUDAToolkit_LIBRARY_DIR=/usr/local/cuda-12.3/lib64 -DCMAKE_CUDA_ARCHITECTURES=native" FORCE_CMAKE=1  pip install llama-cpp-python --force-reinstall --upgrade --no-cache-dir --verbose
EXPOSE 8080
#CMD ["python", "./LLM_Interface.py"]
CMD python3 LLM_Interface.py