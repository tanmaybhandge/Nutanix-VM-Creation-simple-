terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.7.0"
    }
  }
}

provider "nutanix" {
  # Configuration options

  username     = "admin"
  password     = "password@123"
  port         = 9440
  endpoint     = "10.0.0.1"
  insecure     = true
  wait_timeout = 10
}

data "nutanix_cluster" "myCluster" {
  name = "POC-Cluster"
}

data "nutanix_subnet" "subnet_info" {
  subnet_name = "Primary"
}

data "nutanix_image" "image_info" {
  image_name = "CentOS"
}

resource "nutanix_virtual_machine" "vm1" {
  name                 = "TF-VM"
  cluster_uuid         = data.nutanix_cluster.myCluster.id
  num_vcpus_per_socket = 2
  num_sockets          = 2
  memory_size_mib      = 4096

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet_info.id
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.image_info.id
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
    }
  }

}
