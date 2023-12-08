#include "include/is_valid/is_valid_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "is_valid_plugin.h"

void IsValidPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  is_valid::IsValidPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
