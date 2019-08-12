#!/bin/bash


# Shared Environment Variables (assume WERCKER_SOURCE_DIR is defined)

function set_pharo60_env_vars() {
    BASEDIR=$WERCKER_SOURCE_DIR
    PHAROBUILD=$BASEDIR/build
    PHAROVM=/usr/local/bin/pharo
    PHAROARG="--nodisplay"
    PHAROTEST="--pharo-arg=$PHAROARG"
    MAPPROXYIMAGE=MAPProxy
    MAPPROXY="$PHAROVM $PHAROARG $PHAROBUILD/$MAPPROXYIMAGE.image"
}

function set_env_vars() {
    set_pharo60_env_vars
}

# Do set the shared variables
set_env_vars


# Helpers to get a running Pharo image and vm (assume pwd is $PHAROBUILD)

function create_symlinks() {
    export LD_LIBRARY_PATH=/usr/lib/i386-linux-gnu/:$PWD
    ln -sf /usr/lib/i386-linux-gnu/libcrypto.so.1.0.0 libcrypto.so
}

function prepare_pharo60_vm() {
    echo "Using Pharo60+ VM"

    VM=pharo-linux-stable.zip
    wget --quiet http://files.pharo.org/get-files/70/$VM
    SUM=`sha256sum $VM | cut -d ' ' -f 1`
    echo $SUM
    if [ "$SUM" != "4b374a7f56d947dfd1d9dfe91131156cb4520651f176f2ad28a58963e479052e" ]; then
        echo "Smalltalk vm has changed and should not have changed: $SUM"
        exit 51
    fi

    wget --quiet http://files.pharo.org/get-files/60/sources.zip

    rm -rf vm/
    mkdir -p vm/
    unzip -d vm/ $VM
    rm $VM

    # And place the right Pharo6 sources into the VM directory.
    unzip -d vm/lib/pharo/*/ sources.zip
    rm sources.zip
}

function prepare_pharo60_img() {
    echo "Going to fetch latest Pharo60 image"
#    VER=60539
#    wget --quiet http://files.pharo.org/image/60/$VER.zip
#    SUM=`sha256sum $VER.zip | cut -d ' ' -f 1`
#    echo $SUM
#    if [ "$SUM" != "1562578b14df41c031e5d79218aff00db07d8817786e9f493614a0297b6ee90d" ]; then
#        echo "Smalltalk image has changed and should not have changed: $SUM"
#        exit 23
#    fi
#    unzip $VER.zip
#    rm $VER.zip

    mv /var/pharo/images/61/Pharo.image   $MAPPROXYIMAGE.image
    mv /var/pharo/images/61/Pharo.changes $MAPPROXYIMAGE.changes
}

# PUBLIC API
function get_pharo() {
#    prepare_pharo60_vm
    prepare_pharo60_img
    create_symlinks
}


# Helpers to load MAPProxy

function pre_load_mapproxy() {
    $MAPPROXY eval $BASEDIR/packaging/de-mapproxy/base_fixes.st
    $MAPPROXY eval --save "(NonInteractiveTranscript onFileNamed: #stdout)" install
    # Disable Epicea change tracking and warnings about deprecations
    $MAPPROXY eval --save "Smalltalk at: #EpMonitor ifPresent: [:epMonitor | epMonitor current disable ]"
    $MAPPROXY eval $BASEDIR/clean.st
    $MAPPROXY eval --save "ASTCache reset"
    $MAPPROXY eval --save "Deprecation showWarning: false."
    $MAPPROXY clean --save
}

function load_mapproxy() {
    $MAPPROXY eval --save "Metacello new \
						baseline: 'MAPProxy'; \
						repository: 'filetree://$BASEDIR/mc/'; load."
    $MAPPROXY clean --save
}

function initialize_mapproxy() {
    echo "Initializing MAP/CAP module and apply fixes"
    $MAPPROXY $BASEDIR/packaging/de-mapproxy/fixes.st
    $MAPPROXY clean --save
}

# PUBLIC API
function install_mapproxy() {
    pre_load_mapproxy
    load_mapproxy
    initialize_mapproxy
}


# Helpers to start mongodb

# PUBLIC API
start_standalone_mongo() {
  mkdir -p /data/db
  mongod --config /etc/mongod.conf --fork
  # print status
  mongo --eval "db.stats()"
}

# PUBLIC API
start_replica_set_mongo() {
  # Create a replicationSet and make the primary on port 27017 (default port)
  mkdir -p /tmp/mongodb1 /tmp/mongodb2 /tmp/mongodb3
  mongod --config $BASEDIR/tests/files/mongodb-1.conf --replSet ciTest --fork
  mongod --config $BASEDIR/tests/files/mongodb-2.conf --replSet ciTest --fork
  mongod --config $BASEDIR/tests/files/mongodb-3.conf --replSet ciTest --fork
  # print status
  mongo --eval "rs.status()"
  # step down to simulate re-resolving
  mongo $BASEDIR/tests/files/rs-init.js
}
