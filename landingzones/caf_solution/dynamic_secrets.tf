module dynamic_keyvault_secrets {
  # source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  # version = "~>5.1.0"
  source = "/tf/caf/aztfmod//modules/security/dynamic_keyvault_secrets"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.caf.keyvaults[each.key]
  objects  = module.caf
}