//#define DEV_MODE
#define detutils_debug
//#define detutils_sscanf

#include <a_samp>
#include <sscanf2>/*
#include <YSI_Coding\y_timers>
#include <YSI_Coding\y_hooks>
#define YSI_COMPATIBILITY_MODE
#include "DETUTILS_DENTIST\y_hooks_timers"*/
//#include <a_fixes>
#include "DETUTILS\d_samp"

// Dummies:

keyword  public Func()
{
    return 1;
}

keyword   forward  Function(a, const b[], Float:c);
/*
task Test[1000]()
{
    print("task - Hi");
    return 1;
}

HOOK_TASK__ Test()
{
    print("task Hook - Hi");
    return 1;
}

timer Test2[1000]() 
{
    print("timer - Hi");
    return 1;
}

HOOK_TIMER__ Test2()
{
    print("timer Hook - Hi");
    return 1;
}
*/
// Actual code:

main()
{
    //repeat Test2();
    print("Gamemode loaded.");
}
/////////////////////////////////////////////////////////////
public OnPlayerSpawn(playerid)
{
    SetPlayerPos(playerid, 825.6589,-1614.8202,13.5469);
    SendClientMessage(playerid, -1, "Welcome %s, your id is %i", _ReturnPlayerName(playerid), playerid);
    SendClientMessageToAll(-1, "Player %s with id %i joined", ReturnPlayerName(playerid), playerid);
    GivePlayerMoney(playerid, 10364);
    SetPlayerSkin(playerid, 70);
    GivePlayerWeapon(playerid, 24, 999);
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        SetPlayerVehiclePos(playerid, 825.6589,-1614.8202,13.5469);
    }
    return 1;
}

public OnPlayerUpdate(playerid)
{
    //SendClientMessage(playerid, -1, "Your speed is %i km/h.", d_ac_GetSpeed(playerid));
    return 1;
}
/////////////////////////////////////////////////////////////
enum Enums
{
    Admin
}

new Player[MAX_PLAYERS][Enums];
/////////////////////////////////////////////////////////////
decl Command:acon(playerid,params[])
{
    ToggleAntiCheatSystem(true);
    return 1;
}

decl Command:acoff(playerid,params[])
{
    ToggleAntiCheatSystem(false);
    return 1;
}
/////////////////////////////////////////////////////////////
decl IntColour:green = 223231;
decl StrColour:g_GrayColour[20] = "{B9C9BF}";
/////////////////////////////////////////////////////////////
decl Command:fadetest(playerid,params[])
{
    FadePlayerScreen(playerid);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerScreenFade(playerid)
{
    SendClientMessage(playerid, -1, "%sYour screen faded!", ReturnStrColour(g_GrayColour));
    return 1;
}
/////////////////////////////////////////////////////////////
decl Command: tagtest(playerid,params[])
{
    SendClientMessage(playerid, -1, "Tag command worked.");
    return 1;
}
/////////////////////////////////////////////////////////////
decl CommandAlias:tagt(playerid,params[]) = tagtest;
/////////////////////////////////////////////////////////////
CMD:cmd(playerid,params[])
{
    SendClientMessage(playerid, -1, "%sCMD: command worked.", ReturnStrColour(g_GrayColour));
    SendClientMessage(playerid, COLOR_HEX_WHITE,
    "{ffffff}This is white and {%06x}this is the %s's color!", 
    GetPlayerColor(playerid) >>> 8, ReturnPlayerName(playerid));
    return 1;
}
/////////////////////////////////////////////////////////////
YCMD:ycmd(playerid,params[])
{
    SendClientMessage(playerid, -1, "%sYCMD: command worked.", ReturnStrColour(g_GrayColour));
    return 1;
}
/////////////////////////////////////////////////////////////
COMMAND:command(playerid,params[])
{
    SendClientMessage(playerid, -1, "%sCOMMAND: command worked.", ReturnStrColor(g_GrayColour));
    SendClientMessage(playerid, ReturnIntColour(green), "I am g_GrayColour-coloured text.");
    return 1;
}
/////////////////////////////////////////////////////////////
alias command tag(playerid,params[]) =tagtest;
/////////////////////////////////////////////////////////////
command sayhi (playerid,params[])
{
    /*new parameters[128], idx;

    new action; 

    parameters = strtok(params, idx);

    if(strlen(parameters) == 0) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /sayhi <action>");

    action = strval(parameters);*/
    new action;
    if(sscanf(params, "i", action)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /sayhi <action>");

    if(action == 1)
    {
        SendClientMessage(playerid, -1, "Hi, %s.", _ReturnPlayerName(playerid));
    }
    else if(action != 1)
    {
        SendClientMessage(playerid, -1, "No HI for you!");
    }
    return 1;
}
/////////////////////////////////////////////////////////////
alias command hi (playerid,params[]) = sayhi;
/////////////////////////////////////////////////////////////
admin command ac (playerid,params[])
{
    SendClientMessage(playerid, -1, "You're admin.");
    return 1;
}
/////////////////////////////////////////////////////////////
command untiltest(playerid, params[])
{
    new i;
    until(i = 50)
    {
        i++;
        printf("%i", i);
    }
    SendClientMessage(playerid, -1, "i is now 50.");
    return 1;
}

/////////////////////////////////////////////////////////////
public OnCommandStateChange(playerid, cmdtext[], stateid) // new and PROPER debugging
{
    if(stateid == COMMAND_DEBUG_STATE_RECEIVED)
    {
        printf("Command %s received.", cmdtext);
        return 1;
    }
    else if(stateid == COMMAND_DEBUG_STATE_READY)
    {
        printf("Command %s ready.", cmdtext);
        return 1;
    }
    else if(stateid == COMMAND_DEBUG_STATE_PERFORMED)
    {
        printf("Command %s performed.", cmdtext);
        return 1;
    }
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPrefixedCommandStateChange(playerid, cmdtext[], stateid) // you can also debug prefixed commands
{
    if(stateid == COMMAND_DEBUG_STATE_RECEIVED)
    {
        printf("Custom prefixed command %s received.", cmdtext);
        return 1;
    }
    else if(stateid == COMMAND_DEBUG_STATE_READY)
    {
        printf("Custom prefixed command %s ready.", cmdtext);
        return 1;
    }
    else if(stateid == COMMAND_DEBUG_STATE_PERFORMED)
    {
        printf("Custom prefixed command %s performed.", cmdtext);
        return 1;
    }
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerCheatDetected(playerid, cheattype)
{
    if(cheattype == CHEAT_TYPE_MONEY)
    {
        SendClientMessage(playerid, -1, "Stop using money hack, you could've just robbed a bank - but we got you!");
    }
    else if(cheattype == CHEAT_TYPE_SKINCHANGER)
    {
        SendClientMessage(playerid, -1, "Don't dare to change your skin this way ever again!");
    }
    else if(cheattype == CHEAT_TYPE_TELEPORT)
    {
        SendClientMessage(playerid, -1, "Stop teleporting!");
    }
    else if(cheattype == CHEAT_TYPE_HIGHPING)
    {
        SendClientMessage(playerid, -1, "Your ping is too high man! Try to reduce it a bit.");
    }
    else if(cheattype == CHEAT_TYPE_HEALTH)
    {
        SendClientMessage(playerid, -1, "Hey! Don't modify your health - you aren't immortal.");
    }
    else if(cheattype == CHEAT_TYPE_ARMOUR)
    {
        SendClientMessage(playerid, -1, "Stop changing your armour.");
    }
    else if(cheattype == CHEAT_TYPE_SPEEDHACK)
    {
        SendClientMessage(playerid, -1, "Aren't you too fast to be a human? Are you a... cheater?");
    }
    return 1;
}
/////////////////////////////////////////////////////////////
decl Prefix:shitprefix = "&";

prefixed command test (Prefix:"&",playerid, params[])
{
    SendClientMessage(playerid, -1, "Amazing %s, this custom-prefixed command worked.", _ReturnPlayerName(playerid));
    return 1;
}
/////////////////////////////////////////////////////////////
prefixed command TEST(Prefix:"&",playerid, params[])
{
    SendClientMessage(playerid, -1, "WORKS!");
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPrefixedCommandReceived(playerid, cmdtext[])
{
    SendClientMessage(playerid, -1, "%s, your command was received. (%s)", _ReturnPlayerName(playerid), cmdtext);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPrefixedCommandPerformed(playerid, cmdtext[], success)
{
    if(!success)
    {
        SendClientMessage(playerid, -1, "Command %s doesn't exist.", cmdtext);
    }
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerCommandReceived(playerid, cmdtext[])
{
    SendClientMessage(playerid, -1, "%s, your command was received. (%s)", _ReturnPlayerName(playerid), cmdtext);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success)
    {
        SendClientMessage(playerid, -1, "Command %s doesn't exist.", cmdtext);
    }
    return 1;
}
/////////////////////////////////////////////////////////////
decl Prefix:aletter = "@";
decl Prefix: hashtag = "#" ;

decl Command:cson(playerid, params[])
{
    ToggleCommandCaseSensivity(true);
    SendClientMessage(playerid, -1, "%s turned command case-sensivity on.", ReturnPlayerName(playerid));
    return 1;
}

decl Command:csoff(playerid, params[])
{
    ToggleCommandCaseSensivity(false);
    SendClientMessage(playerid, -1, "%s turned command case-sensivity off.", ReturnPlayerName(playerid));
    return 1;
}
prefixed command dear ( Prefix: aletter, playerid, params[])
{
    SendClientMessage(playerid, -1, "%s said hi.", _ReturnPlayerName(playerid));
    return 1;
}
/////////////////////////////////////////////////////////////
prefixed command hi (Prefix:"#", playerid, params[])
{
    SendClientMessage(playerid, -1, "Hi man");
    return 1;
}
/////////////////////////////////////////////////////////////
decl Prefix:dollar = "$"; 
decl PrefixedCommand:skal(Prefix:"$", playerid, params[])
{
    SendClientMessage(playerid, -1, "Cheers, %s!", ReturnPlayerName(playerid));
    return 1;
}
decl Prefix:plus = "+";
decl PrefixedCommand:sscanf(Prefix: "+",playerid, params[]) 
{
    new action;
    if(sscanf(params, "i", action)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: +sscanf <action>");

    if(action == 1)
    {
        SendClientMessage(playerid, -1, "Hi, %s.", _ReturnPlayerName(playerid));
    }
    else if(action != 1)
    {
        SendClientMessage(playerid, -1, "No HI for you!");
    }
    return 1;
}
/////////////////////////////////////////////////////////////
create role AdminRole (playerid, Player[playerid][Admin] == 1);
/////////////////////////////////////////////////////////////
decl Role:AdminRole2(playerid, Player[playerid][Admin] >= 1 );
/////////////////////////////////////////////////////////////
command makeadmin (playerid, params[])
{
    SendClientMessage(playerid, -1, "You're now an administrator.");
    Player[playerid][Admin] = 1;
    return 1;
}
/////////////////////////////////////////////////////////////
role command clearchat (playerid, params[], AdminRole)
{
    for(new i; i < 20; i++)
        SendClientMessage(playerid, -1, "");

    SendClientMessage(playerid, -1, "You cleared the chat.");
    return 1;
}
/////////////////////////////////////////////////////////////
decl RoleCommand:ao(playerid, params[], AdminRole2)
{
    SendClientMessageToAll(-1, "Announcement!");
    return 1;
}
/////////////////////////////////////////////////////////////
public OnGameModeInit()
{
    UsePlayerPedAnims();
    DisableDefaultProperties();
    CreatePropertyEntrance("24/7 Market", 811.1299,-1616.0647,13.5469, 0, 0, true, INTERIOR_MARKET_247_1);
    CreatePropertyEntrance("Your Interior", 825.6589,-1614.8202,13.5469, 0, 0, true, INTERIOR_CUSTOM, 0.0000, 0.0000, 4.0000, 1, 1);
    CreateDroppedGun(30,999,811.1299,-1616.0647,13.5469);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerConnect(playerid)
{
    if(!IsPlayerUsingAndroidClient(playerid)) return SendClientMessage(playerid, -1, "You're using a computer to play SA:MP, great!");
    SetSpawnInfo(playerid, 0, 0, 811.1299,-1616.0647,13.5469, 0, 0,0,0,0,0,0);
    SpawnPlayer(playerid);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerClientCheckReceived(playerid)
{
    printf("Successfully performed client check on player id %i.", playerid);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPropertyActionPerformed(playerid, propertyid, actionid)
{
    new string[256];
    if(actionid == PROPERTY_ACTION_ENTER)
    {
        format(string, 256, "%sYou entered %s, %s. Property id: %i [%i]", 
            ReturnStringColour(g_GrayColour),
            GetPropertyName(propertyid),
            ReturnPlayerName(playerid), 
            GetPropertyIDByName(g_PropertyData[propertyid][p_PropertyName]), //GetPropertyIDByName(GetPropertyName(propertyid)), // to ensure this also works
            propertyid);
        SendClientMessage(playerid, -1, string);
        return 1;
    }
    else if(actionid == PROPERTY_ACTION_EXIT)
    {
        format(string, 256, "%sYou exited %s, %s. Property id: %i [%i]", 
            ReturnStringColour(g_GrayColour),
            GetPropertyName(propertyid),
            ReturnPlayerName(playerid), 
            GetPropertyIDByName(GetPropertyName(propertyid)),
            propertyid);
        SendClientMessage(playerid, -1, string);
        return 1;
    }
    return 0;
}
/////////////////////////////////////////////////////////////
public OnPropertyCreated(propertyid)
{
    printf("Property created! ID: %i", propertyid);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerEnterProperty(playerid)
{
  new message[256];
  format(message, 256, "%s opens the door and enters the object.", ReturnPlayerName(playerid));
  SendMessageInRange(3.0, playerid, message, -1);
  return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerExitProperty(playerid)
{
  new message[256];
  format(message, 256, "%s opens the door and leaves the place.", ReturnPlayerName(playerid));
  SendMessageInRange(3.0, playerid, message, -1);
  return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerScoreSniperHeadshot(playerid, killedid)
{
    new message[256];
    format(message, 256, "You killed %s by headshot.", ReturnPlayerName(killedid));
    SendClientMessage(playerid, -1, message);
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerPickUpGun(playerid)
{
    SendClientMessage(playerid, -1, "You picked up a gun.");
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerThrowGun(playerid)
{
    SendClientMessage(playerid, -1, "You threw away a gun.");
    return 1;
}
/////////////////////////////////////////////////////////////
public OnPlayerDestroyGun(playerid)
{
    SendClientMessage(playerid, -1, "You destroyed a gun.");
    return 1;
}
/////////////////////////////////////////////////////////////