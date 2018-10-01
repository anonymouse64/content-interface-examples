#!/bin/bash -e

# first build all the snaps
for dir in consumer-snap producer-snap1 producer-snap2; do 
    pushd $dir > /dev/null
    snapcraft clean
    snapcraft
    cp *.snap ../
    popd > /dev/null
done

# now remove all previous iterations of the snaps
for snap in consumer-snap producer-snap1 producer-snap2; do 
    sudo snap remove $snap
done

# now install all the snaps again
for snap in consumer-snap producer-snap1 producer-snap2; do 
    sudo snap install ${snap}*.snap --devmode
done
