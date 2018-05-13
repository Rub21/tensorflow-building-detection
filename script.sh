#!/bin/bash
label-maker download
label-maker labels
label-maker images

WORKDIR='/usr/src/app'
TOD='/usr/src/app/models/research/object_detection'
# Create TFRecords for model training
# https://github.com/developmentseed/label-maker/blob/master/examples/walkthrough-tensorflow-object-detection.md#create-tfrecords-for-model-training
cp $WORKDIR/label-maker/examples/utils/tf_records_generation.py $TOD
cp $WORKDIR/data/labels.npz $TOD
cp -a $WORKDIR/data/tiles $TOD
cd $TOD
python tf_records_generation.py --label_input=labels.npz \
        --train_rd_path=data/train_buildings.record \
        --test_rd_path=data/test_buildings.record

# Object detection model setup
# https://github.com/developmentseed/label-maker/blob/master/examples/walkthrough-tensorflow-object-detection.md#object-detection-model-setup
cd $WORKDIR && wget http://download.tensorflow.org/models/object_detection/ssd_inception_v2_coco_2017_11_17.tar.gz
tar xvf ssd_inception_v2_coco_2017_11_17.tar.gz
mv ssd_inception_v2_coco_2017_11_17 $TOD/
mkdir $TOD/training
cp label-maker/examples/utils/ssd_inception_v2_coco.config $TOD/training
cp label-maker/examples/utils/building_od.pbtxt $TOD/data

# Train the TensorFlow object detection model
# https://github.com/developmentseed/label-maker/blob/master/examples/walkthrough-tensorflow-object-detection.md#train-the-tensorflow-object-detection-model
cd $TOD/
python train.py --logtostderr \
        --train_dir=training/ \
        --pipeline_config_path=training/ssd_inception_v2_coco.config
