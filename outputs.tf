output "virtual-machine-id" {
  description = "The ID of the Windows Virtual Machine."
  value       = [for virtual-machine-id in module.virtual_machine : virtual-machine-id]
}

output "virtual-machine-private-ip" {
  description = "Output the private ip address of the vm."
  value       = [for virtual-machine-private-ip in module.virtual_machine : virtual-machine-private-ip]
}

output "network-interface-id" {
  description = "Output the Id of the network interface."
  value       = [for network-interface-id in module.virtual_machine : network-interface-id]
}

output "virtual-machine-identity" {
  description = "The SystemAssigned identity of the VMs."
  value       = [for virtual-machine-identity in module.virtual_machine : virtual-machine-identity]
}

output "vm-resource" {
  description = "The VM resource output."
  value       = [for vm-resource in module.virtual_machine : vm-resource]
}

output "ni-resource" {
  description = "The Network Interface resource."
  value       = [for ni-resource in module.virtual_machine : ni-resource]
}
