set -x

PYTORCH_HOME=$PWD
PYTORCH_BUILD=/tmp/pytorch_build/
what=$1
PYTORCH_REMOTING_DEST=$PYTORCH_BUILD/remoting/$what
mkdir -p "$PYTORCH_REMOTING_DEST"

python -m torchgen.gen \
  --source-path $PYTORCH_HOME/aten/src/ATen \
  --install_dir $PYTORCH_REMOTING_DEST/$what \
  --per-operator-headers \
  --mps \
  --generate remoting_$what \
  --output-dependencies $PYTORCH_BUILD/generated_sources.$what.cmake \
  --remoting-$what
