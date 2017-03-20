#pragma semicolon 1

#include <sourcemod>
#include <SteamWorks>
//#pragma newdecls required

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

public void OnMapStart()
{
	char cBeaconKey[256];
	gcvBeaconKey.GetString(cBeaconKey, sizeof(cBeaconKey));
	if(!cBeaconKey[0])
	{
		
		char cApiKey[256];
		gcvApiKey.GetString(cApiKey, sizeof(cApiKey));
		
		if(!cApiKey[0])
		{
			LogError("No Teamwork API Key set. Unable to request a Teamwork beacon key for this server");
			return;
		}
		
		// Fetch the port of this server		
		ConVar cvPort = FindConVar("hostport");
		if(!cvPort)
		{
			ThrowError("Unable to detect the port of this Server. Please request the key manually");
		}
		
		// Fetch the IP Adress of this server
		int aiIpAdress[4];
		SteamWorks_GetPublicIP(aiIpAdress);

		
		char cQueryURL[2048];
		Format(cQueryURL, sizeof(cQueryURL), "%s/?api_key=%s&ip=%i.%i.%i.%i?port=%i", API_URL, aiIpAdress[0], aiIpAdress[1], aiIpAdress[2], aiIpAdress[3], cvPort.IntValue);

		
// TODO: Remove the legacy code and replace it with the new syntax
		
		Handle hHTTPRequest = SteamWorks_CreateHTTPRequest(EHTTPMethod:k_EHTTPMethodGET, cQueryURL);
		
		if (!hHTTPRequest || !SteamWorks_SetHTTPCallbacks(hHTTPRequest, HTTPCallback) || !SteamWorks_SendHTTPRequest(hHTTPRequest))
		{
			CloseHandle(hHTTPRequest);
			ThrowError("Failed to send the HTTP request to the server!");
		}
		
	}
}

public HTTPCallback(Handle:hHTTPRequest, bool:bFailure, bool:bRequestSuccessful, EHTTPStatusCode:eStatusCode)
{
	if (!bFailure && bRequestSuccessful && eStatusCode == k_EHTTPStatusCode200OK)
	{
		SteamWorks_GetHTTPResponseBodyCallback(hHTTPRequest, HTTPResponse);
	}

	CloseHandle(hHTTPRequest);
	ThrowError("Connection failed");
}

public HTTPResponse(const String:sResponse[])
{
	//Insert fancy SourceMod json libary here.
}

//TODO: END
