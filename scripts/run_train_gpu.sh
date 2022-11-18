
###
 # @Author: tyl 1209339478@qq.com
 # @Date: 2022-08-29 12:48:39
 # @LastEditors: tyl 1209339478@qq.com
 # @LastEditTime: 2022-08-29 14:08:23
 # @FilePath: \midas\scripts\run_train_gpu.sh
### 
if [ $# -lt 3 ]
then
    echo "Usage: \
          bash run_train_gpu.sh [DEVICE_NUM] [VISIABLE_DEVICES(0,1,2,3,4,5,6,7)] [ckpt_path]
          "
exit 1
fi

if [ $1 -lt 1 ] || [ $1 -gt 8 ]
then
    echo "error: DEVICE_NUM=$1 is not in (1-8)"
exit 1
fi

export DEVICE_NUM=$1
export RANK_SIZE=$1

BASEPATH=$(cd "`dirname $0`" || exit; pwd)
export PYTHONPATH=${BASEPATH}:$PYTHONPATH
if [ -d "../train_GPU" ];
then
    rm -rf ../train_GPU
fi
mkdir ../train_GPU
cd ../train_GPU || exit

if [ $1 -gt 1 ]
then
    export CUDA_VISIBLE_DEVICES="$2"
    mpirun -n $1 --allow-run-as-root --output-filename log_output --merge-stderr-to-stdout \
    python3 ${BASEPATH}/../midas_train.py --device_target 'GPU' --run_distribute True --model_weights $3> train.log 2>&1 &
else
    python3 ${BASEPATH}/../midas_train.py --device_target 'GPU' --run_distribute False  --device_id $2 --model_weights $3> train.log 2>&1 &
fi
