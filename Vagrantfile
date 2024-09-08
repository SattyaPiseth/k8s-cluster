Vagrant.configure("2") do |config|
    # Constants
    MASTER_VM_NAME = "k8s-master"
    WORKER_VM_NAME = "k8s-worker"
    NUM_WORKERS = 2  # Number of worker nodes
    VM_BOX = "ubuntu/jammy64"
    MASTER_MEMORY = 4096  # Master node RAM
    WORKER_MEMORY = 2048   # Worker node RAM
    CORES_PER_VM = 2
    
    # Define the Master Node
    config.vm.define MASTER_VM_NAME do |master|
      master.vm.box = VM_BOX
      
      # Network configuration for master node
      master.vm.network "private_network", type: "dhcp"
  
      # Allocate resources
      master.vm.provider "virtualbox" do |vb|
        vb.memory = MASTER_MEMORY
        vb.cpus = CORES_PER_VM
        vb.name = MASTER_VM_NAME
      end
  
      # Provision the master node
      master.vm.provision "shell", path: "provision-master.sh"
    end
  
    # Define Worker Nodes
    (1..NUM_WORKERS).each do |i|
      config.vm.define "#{WORKER_VM_NAME}#{i}" do |worker|
        worker.vm.box = VM_BOX
  
        # Network configuration for worker nodes
        worker.vm.network "private_network", type: "dhcp"
  
        # Allocate resources
        worker.vm.provider "virtualbox" do |vb|
          vb.memory = WORKER_MEMORY
          vb.cpus = CORES_PER_VM
          vb.name = "#{WORKER_VM_NAME}#{i}"
        end
  
        # Provision the worker node
        worker.vm.provision "shell", path: "provision-worker-#{i}.sh"
      end
    end
  
    # Synced folder for easy access to KubeSpray files
    config.vm.synced_folder "./kubespray", "/kubespray", type: "rsync", rsync__exclude: ".git/"
  
    # Provision KubeSpray
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "/kubespray/cluster.yml"  # Path to your KubeSpray playbook
      ansible.inventory_path = "/kubespray/inventory/mycluster/hosts.yaml"  # Path to the inventory file
      ansible.extra_vars = {
        "kube_network_plugin" => "calico"  # Example: setting the network plugin variable; customize as needed
      }
    end
  
    # Customizing VirtualBox VM settings
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end
  