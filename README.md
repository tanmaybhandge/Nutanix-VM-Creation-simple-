# Nutanix VM Creation


This repository deploys Virtual Machine on Nutanix Cluster using Infrastructure as code with Terraform.

Pre-requites

- Terraform
- Adding nutanix as a required provider.
- Create the new VM in Nutanix, clone it and modify the VM Disk as image template. We require OS image on Nutanix cluster.
- Make sure networking VLAN has been configured.
- Establish the connectivity to Prism.

### Configuration

1. Clone the respository.

2. Update the below value in the ```main.tf``` file to match your Nutanix environment.

      In the provider block modify the below

        username     = <Username of the Prism Central>
        password     = <Password of the Prism Central>
        port         = 9440
        endpoint     = <IP address of the Prism Central>
        insecure     = true
        wait_timeout = 10

      In the data block provide the name of the cluster, VLAN information (Subnet) and Image name. In resource block you may configure the Virtual machine as per your requirment

          name                 = <Name of the Virtual machine>
          num_vcpus_per_socket = <vCPU per Socket>
          num_sockets          = <Number of Socket>
          memory_size_mib      = <RAM size in MB>

  3. Save the main.tf file.

### Running this repository
Initialize the modules (and download the Nutanix Provider) by running terraform init.

    $ terraform init

Once you’ve initialized the directory, it’s good to run the validate command before you run ```plan``` or ```apply```. Validation will catch syntax errors, version errors, and other issues.

    $ terraform validate

Next, it’s always a good idea to do a dry run of your plan to see what it’s actually going to do. You can even use one of the subcommands with terraform plan to output your plan to apply it later.

    $ terraform plan

You can execute ```apply``` command, this command will deploy or applies your configuration.

    $ terraform apply

If you would like to remove / delete the resources which has been launched, you can execute the destroy command. This command will destroy your Infrastructure.

    $ terraform destroy
