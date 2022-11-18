
###
 # @Author: tyl 1209339478@qq.com
 # @Date: 2022-08-29 12:48:39
 # @LastEditors: tyl 1209339478@qq.com
 # @LastEditTime: 2022-08-29 15:04:21
 # @FilePath: \midas\scripts\run_distribute_train.sh
### 
echo "========================================================================"
echo "Please run the script as: "
echo "bash run.sh RANK_SIZE CKPT_PATH"
echo "For example: bash run_distribute.sh 8 ./ckpt/midas_resnext_101_WSL.ckpt"
echo "It is better to use the absolute path."
echo "========================================================================"
set -e

RANK_SIZE=$1
export RANK_SIZE
export HCCL_CONNECT_TIMEOUT=600
EXEC_PATH=$(pwd)
echo "$EXEC_PATH"

test_dist_8pcs()
{
    export RANK_TABLE_FILE=${EXEC_PATH}/rank_table_8pcs.json
    export RANK_SIZE=8
}

test_dist_2pcs()
{
    export RANK_TABLE_FILE=${EXEC_PATH}/rank_table_2pcs.json
    export RANK_SIZE=2
}

test_dist_${RANK_SIZE}pcs

export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

cd ../
rm -rf distribute_train
mkdir distribute_train
cd distribute_train
for((i=0;i<${RANK_SIZE};i++))
do
    rm -rf device$i
    mkdir device$i
    cd ./device$i
    mkdir src
    cd src
    mkdir utils
    cd ../../../
    cp ./midas_train.py config.yaml ./distribute_train/device$i
    cp ./src/*.py ./distribute_train/device$i/src
    cp ./src/utils/*.py ./distribute_train/device$i/src/utils
    cd ./distribute_train/device$i
    export DEVICE_ID=$i
    export RANK_ID=$i
    echo "start training for device $i"
    env > env$i.log
    python midas_train.py --run_distribute True --is_modelarts False --model_weights $2> train$i.log 2>&1 &
    echo "$i finish"
    cd ../
done

if [ $? -eq 0 ];then
    echo "training success"
else
    echo "training failed"
    exit 2
fi
echo "finish"
cd ../
