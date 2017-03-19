#pragma semicolon 1

#include <sourcemod>
#include <SteamWorks>

#pragma newdecls required

#define PLUGIN_VERSION "1.0.1-SM"
#define API_URL "https://teamwork.tf/community/beacon"

ConVar gcvBeaconKey;
ConVar gcvApiKey;


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
	gcvBeaconKey = CreateConVar("tw_beacon", "", "Your Teamwork beacon key", FCVAR_NOTIFY|FCVAR_ARCHIVE);
	gcvApiKey = CreateConVar("tw_api_key", "", "Your Teamwork API key", FCVAR_PROTECTED);
}

//Currently unused
public void OnMapStart()
{
	char cApiKey[256];
	char cBeaconKey[256];
	gcvApiKey.GetString(cApiKey, sizeof(cApiKey));
	gcvBeaconKey.GetString(cBeaconKey, sizeof(cBeaconKey));
	if(!cBeaconKey[0])
	{
		if(!cApiKey[0])
		{
			LogError("No Teamwork API Key set. Unable to request a Teamwork beacon key for this server");
			return;
		}
		
		int IPAdress[4];
		SteamWorks_GetPublicIP(IPAdress);
		
		// Url ?api_key=<tw_api_key>&port=<server_port>&ip=<server_ip>
		
		
		//LogError("teamwork.tf responded with a error: %s", cErrorMessage)
	}
}
