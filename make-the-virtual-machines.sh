# make 3 docker-machine (remove if already exist) boot2-docker virtual machines
# put python/pip on them to make them like a 'normal linux box' for ansible

make_machine() {
    docker-machine rm -y $1
    docker-machine create --driver virtualbox $1
    #level set boot2docker with a normal linux distro
    docker-machine ssh $1 'tce-load -wi python'
    docker-machine ssh $1 'wget https://bootstrap.pypa.io/get-pip.py'
    docker-machine ssh $1 'sudo python get-pip.py'
    docker-machine ssh $1 'rm -f get-pip.py'
}

make_machine es-host1
make_machine es-host2
make_machine es-host3

echo "!!! Virtual Machines Created, validate below IPs match those in inventory.ini !!!"
echo "!!! Run ansible-playbook create-es-cluster.yml when it does !!!"
docker-machine ls