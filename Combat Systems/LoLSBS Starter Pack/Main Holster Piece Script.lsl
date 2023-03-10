//This script works by turning the entire holster invisible when the gun is unholstered, then making the holster peices visible again.


integer holstered = FALSE;

init()
{
    llListen(-873145, "", NULL_KEY, "");
    //Communication channel. The number must be the same as in the main gun script.
}

default
{
    state_entry()
    {
        init();
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }
    
    touch_start(integer num_detected)
    {
        if (llDetectedKey(0) == llGetOwner())
        {
            llSay(-873145, "Menu" + (string)llGetOwner());
            //Opens the menu
        }
    }
    
    listen(integer channel, string name, key id, string message) 
    {
        if (message == "holster" + (string)llGetOwner())
        {
            llSetLinkAlpha(LINK_SET, 1.0, ALL_SIDES);
            holstered = TRUE;
        }
        else if (message == "unholster" + (string)llGetOwner())
        {
            llSetLinkAlpha(LINK_SET, 0.0, ALL_SIDES);
            llMessageLinked(LINK_SET, 1, "", NULL_KEY);
            holstered = FALSE;
        }
    }
}
