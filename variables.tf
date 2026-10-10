variable "dx_hosted_transit_virtual_interfaces" {
  description = <<EOT
Map of dx_hosted_transit_virtual_interfaces, attributes below
Required:
    - address_family
    - bgp_asn
    - connection_id
    - name
    - owner_account_id
    - vlan
Optional:
    - amazon_address
    - bgp_auth_key
    - customer_address
    - mtu
    - region
EOT

  type = map(object({
    address_family   = string
    bgp_asn          = number
    connection_id    = string
    name             = string
    owner_account_id = string
    vlan             = number
    amazon_address   = optional(string)
    bgp_auth_key     = optional(string)
    customer_address = optional(string)
    mtu              = optional(number)
    region           = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.dx_hosted_transit_virtual_interfaces : (
        v.mtu == null || (contains([1500, 8500], v.mtu))
      )
    ])
    error_message = "must be one of: 1500, 8500"
  }
  validation {
    condition = alltrue([
      for k, v in var.dx_hosted_transit_virtual_interfaces : (
        v.vlan >= 1 && v.vlan <= 4094
      )
    ])
    error_message = "must be between 1 and 4094"
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

