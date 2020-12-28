#include <sourcemod>

#define MAX_CASH_AMOUNT 16000

static int g_money_offset = 0;
static Handle g_enabled;

public const Plugin myinfo = {
    name = "Max Cash", author = "LAN of DOOM",
    description = "Grants max cash on spawn", version = "1.0.0",
    url = "https://github.com/lanofdoom/counterstrikesource-max-cash"};

void OnSpawn(Handle event, const char[] unused_name,
             bool unused_dont_broadcast) {
  if (GetConVarInt(g_enabled) && g_money_offset) {
    int user_id = GetEventInt(event, "userid");
    int client_id = GetClientOfUserId(user_id);
    SetEntData(client_id, g_money_offset, MAX_CASH_AMOUNT);
  }
}

public void OnPluginStart() {
  g_money_offset = FindSendPropInfo("CCSPlayer", "m_iAccount");
  g_enabled =
      CreateConVar("sm_max_cash_enabled", "1",
                   "If enabled, players spwan with max cash", FCVAR_NOTIFY);
  HookEvent("player_spawn", OnSpawn);
}
