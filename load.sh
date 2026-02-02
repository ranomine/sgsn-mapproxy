#!/bin/sh

echo "Downloading PharoVM and trusting it. Yolo"
curl https://get.pharo.org/64/vm130 | bash
echo "Downloading Pharo image and trusting it. Yolo"
curl https://get.pharo.org/64/130  | bash

mv Pharo.image MAPProxy.image
mv Pharo.changes MAPProxy.changes

echo "Loading code into the image"
./pharo MAPProxy.image eval --save "Metacello new baseline: 'MAPProxy'; onConflictUseIncoming; repository: 'filetree://$PWD/mc'; load."

echo "Initializing the TCAP model"
./pharo MAPProxy.image eval --save "MAPProxy asn1Model"
