#zookeeper
docker run -d --name=zookeeper garland/zookeeper
#mesos master
docker run -d -p 5050:5050 --link zookeeper:zookeeper mesosphere/mesos:1.0.1-2.0.93.ubuntu1404 mesos-master --work_dir=/tmp --zk=zk://zookeeper:2181/mesos --quorum=1
#mesos slave
docker run -d --link zookeeper:zookeeper -v /sys/fs/cgroup:/sys/fs/cgroup -v /var/run/docker.sock:/var/run/docker.sock mesosphere/mesos:1.0.1-2.0.93.ubuntu1404 mesos-slave --work_dir=/tmp --master=zk://zookeeper:2181/mesos --containerizers=docker
docker run -d --link zookeeper:zookeeper -v /sys/fs/cgroup:/sys/fs/cgroup -v /var/run/docker.sock:/var/run/docker.sock mesosphere/mesos:1.0.1-2.0.93.ubuntu1404 mesos-slave --work_dir=/tmp --master=zk://zookeeper:2181/mesos --containerizers=docker
#marathon
docker run -d -p 8080:8080 --link zookeeper:zookeeper mesosphere/marathon --master zk://zookeeper:2181/mesos --zk zk://zookeeper:2181/marathon
