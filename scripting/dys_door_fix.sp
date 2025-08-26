#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <dhooks>
#include <sdktools>

#define DEBUG true
#define MaxEdicts 2048

int g_curTick;
int g_lastTick[MaxEdicts + 1]; //we're assuming there's not more than 2048 edicts

public Plugin myinfo = {
	name = "Dys Door Fix",
	description = "Fixes Source Engine bug for Dystopia where doors fly away",
	author = "bauxite, credits to Rain, Agiel, MasterKatze, Snoop, SM friends",
	version = "0.1.1",
	url = "",
};

public void OnPluginStart()
{
	#if DEBUG
	RegConsoleCmd("sm_maxents", Cmd_MaxEdicts);
	#endif
	
	Handle gd = LoadGameConfigFile("dystopia/door");
	if (gd == INVALID_HANDLE)
	{
		SetFailState("Failed to load GameData");
	}
	DynamicDetour dd = DynamicDetour.FromConf(gd, "Fn_DoorGoUp");
	if (!dd)
	{
		SetFailState("Failed to create dynamic detour");
	}
	if (!dd.Enable(Hook_Pre, DoorGoUp))
	{
		SetFailState("Failed to detour");
	}
	delete dd;
	

	dd = DynamicDetour.FromConf(gd, "Fn_DoorGoDown");
	if (!dd)
	{
		SetFailState("Failed to create dynamic detour");
	}
	if (!dd.Enable(Hook_Pre, DoorGoDown))
	{
		SetFailState("Failed to detour");
	}
	delete dd;
	CloseHandle(gd);
}

#if DEBUG
public Action Cmd_MaxEdicts(int client, int args)
{
	int MaxEdicts = GetMaxEntities();
	PrintToServer("MaxEdicts: %d", MaxEdicts);
	
	return Plugin_Handled;
}
#endif

MRESReturn DoorGoUp(int pThis)
{
	if(!pThis)
	{
		return MRES_Ignored;
	}
	
	int door = pThis;
	
	g_curTick = GetGameTickCount();
	
	if(g_lastTick[door] == g_curTick)
	{
		#if DEBUG
		PrintToChatAll("blocking go Up! %d - %d", door, g_curTick);
		#endif
		
		return MRES_Supercede;
	}
	
	#if DEBUG
	PrintToChatAll("go up! %d - %d", door, g_curTick);
	#endif
	
	g_lastTick[door] = g_curTick;
	
	return MRES_Ignored;
}

MRESReturn DoorGoDown(int pThis)
{
	if(!pThis)
	{
		return MRES_Ignored;
	}
	
	int door = pThis;
	
	g_curTick = GetGameTickCount();
	
	if(g_lastTick[door] == g_curTick)
	{
		#if DEBUG
		PrintToChatAll("blocking go Down! %d - %d", door, g_curTick);
		#endif
		
		return MRES_Supercede;
	}
	
	#if DEBUG
	PrintToChatAll("go down! %d - %d", door, g_curTick);
	#endif
	
	g_lastTick[door] = g_curTick;
	
	return MRES_Ignored;
}
