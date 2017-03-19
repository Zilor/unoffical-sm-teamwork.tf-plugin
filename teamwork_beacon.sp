#pragma semicolon 1

#include <sourcemod>

#pragma newdecls required

#define PLUGIN_VERSION "1.0.0-SM"

public Plugin myinfo = 
{
	name = "Teamwork beacon ID",
	author = "teamworktf & Zilor",
	description = "Allows you to set a Teamwork beacon id",
	version = PLUGIN_VERSION,
	url = "https://github.com/Zilor/unoffical-sm-teamwork.tf-plugin"
};

public void OnPluginStart()
{
	CreateConVar("tw_version", PLUGIN_VERSION, "SourceMod version for the Teamwork network beacon", FCVAR_NOTIFY);
	CreateConVar("tw_beacon", "", "Your Teamwork beacon id", FCVAR_NOTIFY|FCVAR_ARCHIVE);
}
