
###
 # @Author: tyl 1209339478@qq.com
 # @Date: 2022-08-29 12:48:39
 # @LastEditors: tyl 1209339478@qq.com
 # @LastEditTime: 2022-08-29 14:08:20
 # @FilePath: \midas\scripts\run_standalone_train.sh
### 
export DEVICE_ID=$1
export model_weights=$2
python -u ../midas_train.py  \
    --device_id=$DEVICE_ID --run_distribute=False --is_modelarts=False --model_weights=$model_weights> train_$DEVICE_ID.log 2>&1 &
