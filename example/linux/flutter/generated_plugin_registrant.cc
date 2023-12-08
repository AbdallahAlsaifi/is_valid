//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <is_valid/is_valid_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) is_valid_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "IsValidPlugin");
  is_valid_plugin_register_with_registrar(is_valid_registrar);
}
