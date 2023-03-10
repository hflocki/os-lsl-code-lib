// Ugly 2 fisted hack - Francis

integer SWORD = 1;
integer PUNCH12 = 2;
integer PUNCHL = 3;
integer KICK = 4;
integer FLIP = 5;

integer strike_type;

default
{
    state_entry() 
    {
        llSetStatus(STATUS_BLOCK_GRAB, TRUE);
    }
    run_time_permissions(integer perm)
    {
        if (perm)
        {
                llTakeControls(CONTROL_ML_LBUTTON | CONTROL_LBUTTON | CONTROL_UP | CONTROL_FWD | CONTROL_BACK | CONTROL_ROT_LEFT | CONTROL_LEFT | CONTROL_RIGHT | CONTROL_ROT_RIGHT | CONTROL_DOWN, TRUE, TRUE);
        }
    } 
        
    attach(key on)
    {
        if (on != NULL_KEY)
        {
            integer perm = llGetPermissions();
            
            if (perm != (PERMISSION_TAKE_CONTROLS | PERMISSION_TRIGGER_ANIMATION))
            {
                llRequestPermissions(on, PERMISSION_TAKE_CONTROLS | PERMISSION_TRIGGER_ANIMATION);
            }
            else
            {
                llTakeControls(CONTROL_ML_LBUTTON | CONTROL_LBUTTON | CONTROL_UP | CONTROL_FWD | CONTROL_BACK | CONTROL_ROT_LEFT | CONTROL_LEFT | CONTROL_RIGHT | CONTROL_ROT_RIGHT, TRUE, TRUE);
            }
            
        }
        else
        {
            llSay(0, "releasing controls");
            llTakeControls(FALSE, TRUE, TRUE);
        }
    }
    
    timer()
    {
        if (  (strike_type == FLIP)
            || (strike_type == SWORD))
        {
            llSensor("", "", ACTIVE | AGENT, 4.0, PI_BY_TWO*0.5);
        }
        else
        {
            llSensor("", "", ACTIVE | AGENT, 3.0, PI_BY_TWO*0.5);
        }
        llSetTimerEvent(0.0);
    }
        
    control(key owner, integer level, integer edge)
    {
        if (level & (CONTROL_ML_LBUTTON | CONTROL_LBUTTON))
        {
            if (edge & CONTROL_UP)
            {
                llApplyImpulse(<0,0,3.5>,FALSE);
                llStartAnimation("backflip");
                llSetTimerEvent(0.25);
                strike_type = FLIP;
            }
            if (edge & CONTROL_FWD)
            {
                llStartAnimation("sword_strike_R");
                llSleep(0.5);
                llSetTimerEvent(0.25);
                strike_type = SWORD;
            }
            if (edge & (CONTROL_LEFT | CONTROL_ROT_LEFT))
            {
                llStartAnimation("sword_strike_R");
                llSleep(0.5);
                llSetTimerEvent(0.25);
                strike_type = SWORD;
            }
            if (edge & (CONTROL_RIGHT | CONTROL_ROT_RIGHT))
            {
                llStartAnimation("sword_strike_R");
                llSleep(0.5);
                llSetTimerEvent(0.25);
                strike_type = SWORD;
            }
            if (edge & CONTROL_BACK)
            {
                llStartAnimation("sword_strike_R");
                llSleep(0.5);
                llSetTimerEvent(0.25);
                strike_type = SWORD;
          }
            if (edge & CONTROL_DOWN)
            {
                llStartAnimation("sword_strike_R");
                llSleep(0.5);
                llSetTimerEvent(0.25);
                strike_type = SWORD;
           }
        }
    }
    
    sensor(integer tnum)
    {
        vector dir = llDetectedPos(0) - llGetPos();
        dir.z = 0.0;
        dir = llVecNorm(dir);
        rotation rot = llGetRot();
        if (strike_type == SWORD)
        {            
            llTriggerSound("crunch", 0.2);
            dir += llRot2Up(rot);
            dir *= 1000000.0;
            llPushObject(llDetectedKey(0), dir, ZERO_VECTOR, FALSE);
        }
        else if (strike_type == PUNCH12)
        {
            llTriggerSound("crunch", 0.2);
            dir += dir;
            dir *= 1000.0;
            llPushObject(llDetectedKey(0), dir, ZERO_VECTOR, FALSE);
        }
        else if (strike_type == PUNCHL)
        {
            llTriggerSound("crunch", 0.2);
            dir -= llRot2Left(rot);
            dir *= 1000.0;
            llPushObject(llDetectedKey(0), dir, ZERO_VECTOR, FALSE);
        }
        else if (strike_type == KICK)
        {
            llTriggerSound("crunch", 0.2);
            dir += dir;
            dir *= 1000.0;
            llPushObject(llDetectedKey(0), dir, ZERO_VECTOR, FALSE);
        }
        else if (strike_type == FLIP)
        {
            llTriggerSound("crunch", 0.2);
            llPushObject(llDetectedKey(0), <0,0,150>, ZERO_VECTOR, FALSE);
        }
        strike_type= 0;
    }
}
