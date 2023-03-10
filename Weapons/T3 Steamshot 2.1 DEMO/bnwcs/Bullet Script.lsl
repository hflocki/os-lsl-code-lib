integer damage=30;
integer push=TRUE;

explode()
{
    llSetStatus(STATUS_PHYSICS,FALSE);
    llParticleSystem([]);
    llSetLinkPrimitiveParams(LINK_SET,[PRIM_COLOR,ALL_SIDES,<0,0,0>,0,PRIM_GLOW,ALL_SIDES,0]);
    llRezObject("explosion", llGetPos(), ZERO_VECTOR, ZERO_ROTATION, -1);
    llTriggerSound("d125e8cd-86c1-e5f5-900b-61cf848bbc4e", 1);
    llTriggerSound("645f0d59-fdfc-41d1-7598-50b61bb17730", 1);
    llMessageLinked(LINK_SET,damage,"BNWCS AoE","5");
    
    
    
}
default
{
    
    state_entry()
    {
        llParticleSystem([
PSYS_PART_FLAGS, 259,
PSYS_SRC_PATTERN, 1, 
PSYS_PART_START_ALPHA, 1.000000,
PSYS_PART_END_ALPHA, 1.000000,
PSYS_PART_START_COLOR, <0, 0, 0>,
PSYS_PART_END_COLOR, <.5, .5, .5>,
PSYS_PART_START_SCALE, <.125, .125, 0>,
PSYS_PART_END_SCALE, <0.500000, 0.500000, 0.000000>,
PSYS_PART_MAX_AGE, 0.500000,
PSYS_SRC_MAX_AGE, 0.000000,
PSYS_SRC_ACCEL, <0.000000, 0.000000, 0.000000>,
PSYS_SRC_ANGLE_BEGIN, 0.000000,
PSYS_SRC_ANGLE_END, 0.000000,
PSYS_SRC_BURST_PART_COUNT, 1,
PSYS_SRC_BURST_RATE, 0.010000,
PSYS_SRC_BURST_RADIUS, 0.0,
PSYS_SRC_BURST_SPEED_MIN, 0.500000,
PSYS_SRC_BURST_SPEED_MAX, 1.000000,
PSYS_SRC_OMEGA, <0.000000, 0.000000, 0.000000>,
PSYS_SRC_TARGET_KEY,(key)"", 
PSYS_SRC_TEXTURE, ""]);
llSetBuoyancy(.4);
    }
    
    on_rez(integer sparam)
    {
        damage=sparam;
        llSetDamage(damage);
            
    }
    
    collision_start(integer n)
    {
          if(llKey2Name(llDetectedKey(0))!="damage")
          {
            explode();
            state done;
        }
      //  llDie();
    }
    
    land_collision_start(vector pos)
    {
       explode();
         state done;
      //  llDie();
    }
    
}

state done
{
    state_entry()
    {
        llSetTimerEvent(1);
    }
    
    timer()
    {
        llDie();
    }
}