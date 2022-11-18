
###
 # @Author: tyl 1209339478@qq.com
 # @Date: 2022-08-29 12:48:39
 # @LastEditors: tyl 1209339478@qq.com
 # @LastEditTime: 2022-08-29 15:04:20
 # @FilePath: \midas\scripts\run_eval.sh
### 
export DEVICE_ID=$1
export DATA_NAME=$2
export ckpt_path=$3
export device_target=$3
python -u ../midas_eval.py  --device_id=$DEVICE_ID --data_name=$DATA_NAME --ckpt_path=$ckpt_path --device_target=$device_target> eval.txt 2>&1 &
