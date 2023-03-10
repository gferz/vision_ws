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

echo_and_run cd "/home/gabriel/vision_ws/src/custom_package"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/gabriel/vision_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/gabriel/vision_ws/install/lib/python3/dist-packages:/home/gabriel/vision_ws/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/gabriel/vision_ws/build" \
    "/usr/bin/python3" \
    "/home/gabriel/vision_ws/src/custom_package/setup.py" \
     \
    build --build-base "/home/gabriel/vision_ws/build/custom_package" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/gabriel/vision_ws/install" --install-scripts="/home/gabriel/vision_ws/install/bin"
