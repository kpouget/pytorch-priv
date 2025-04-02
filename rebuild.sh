#! /bin/bash

export USE_SYSTEM_PYBIND11=ON
export USE_XNNPACK=OFF
export USE_DISTRIBUTED=OFF
export USE_KINETO=OFF
export BUILD_TEST=OFF
export USE_CUDA=OFF
export USE_XPU=OFF
export CMAKE_POLICY_VERSION_MINIMUM=3.5 # not sure why :/

export USE_MPS=ON

if [[ $(uname) == Darwin ]]; then
    export USE_MPS_REMOTING_BACKEND=ON
else
    export USE_BLAS=OFF
    # Linux
    export CMAKE_CXX_FLAGS="-I/usr/include/python3.12/"
    export USE_MPS_REMOTING_FRONTEND=ON
    sed 's/# Set the install prefix/set(CMAKE_INSTALL_COMPONENT true)/' -i build/third_party/protobuf/cmake/cmake_install.cmake
fi
export MAX_JOBS=6

export CMAKE_INSTALL_COMPONENT=true

python3 setup.py develop && python3 -c 'import torch; print("Python working!"); print(torch._C)'
