#!/bin/sh

### BEGIN INIT INFO
# Provides:          tomcat
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start and stop Apache Tomcat
# Description:       Enable Apache Tomcat service provided by daemon.
### END INIT INFO

ECHO=/bin/echo
#TEST=/usr/bin/test
TOMCAT_USER=ec2-user
TOMCAT_HOME=/home/ec2-user/apache-tomcat-9.0.31
TOMCAT_START_SCRIPT=$TOMCAT_HOME/bin/startup.sh
TOMCAT_STOP_SCRIPT=$TOMCAT_HOME/bin/shutdown.sh

#$TEST -x $TOMCAT_START_SCRIPT || exit 0
#$TEST -x $TOMCAT_STOP_SCRIPT || exit 0

start() {
    $ECHO -e "Starting Tomcat"
    sh "$TOMCAT_START_SCRIPT"
    $ECHO "."
}

stop() {
    $ECHO -e "Stopping Tomcat"
    sh "$TOMCAT_STOP_SCRIPT"
    $ECHO "."
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        sleep 30
        start
        ;;
    *)
        $ECHO "Usage: tomcat {start|stop|restart}"
        exit 1
esac
exit 0
