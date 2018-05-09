# Tensorflow building detection

This is a docker container runs all steps mentioned in: [Example Use: A building detector with TensorFlow API](https://github.com/developmentseed/label-maker/blob/master/examples/walkthrough-tensorflow-object-detection.md)

### Usage

```
docker build -t tbd .
docker run -it tbd
```

**Manually**

```
docker run -it tbd /bin/bash
./script.sh
```

**If everything runs ok, the output should be 👇**

```
INFO:tensorflow:Recording summary at step 0.
INFO:tensorflow:Recording summary at step 0.
INFO:tensorflow:global step 1: loss = 311.7867 (72.100 sec/step)
INFO:tensorflow:global step 1: loss = 311.7867 (72.100 sec/step)
INFO:tensorflow:global step 2: loss = 292.7577 (25.074 sec/step)
INFO:tensorflow:global step 2: loss = 292.7577 (25.074 sec/step)
INFO:tensorflow:global step 3: loss = 289.7815 (21.244 sec/step)
INFO:tensorflow:global step 3: loss = 289.7815 (21.244 sec/step)
...

```



	