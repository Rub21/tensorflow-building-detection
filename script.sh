#!/bin/bash
label-maker download
label-maker labels
#Preview : https://github.com/developmentseed/label-maker/issues/79
#label-maker preview -n 10
label-maker images

#Setup TensorFlow Object Detection API
