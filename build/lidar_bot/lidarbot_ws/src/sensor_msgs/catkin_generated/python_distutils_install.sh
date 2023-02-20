#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/sipc/self_parking/src/lidar_bot/lidarbot_ws/src/sensor_msgs"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/sipc/self_parking/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/sipc/self_parking/install/lib/python3/dist-packages:/home/sipc/self_parking/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/sipc/self_parking/build" \
    "/usr/bin/python3" \
    "/home/sipc/self_parking/src/lidar_bot/lidarbot_ws/src/sensor_msgs/setup.py" \
     \
    build --build-base "/home/sipc/self_parking/build/lidar_bot/lidarbot_ws/src/sensor_msgs" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/sipc/self_parking/install" --install-scripts="/home/sipc/self_parking/install/bin"
