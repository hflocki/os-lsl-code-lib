integer running = FALSE;
integer count = 0;

//Subroutines
start_particles()
{
    llParticleSystem([
    PSYS_PART_FLAGS, PSYS_PART_EMISSIVE_MASK | PSYS_PART_INTERP_COLOR_MASK | PSYS_PART_INTERP_SCALE_MASK | PSYS_PART_FOLLOW_VELOCITY_MASK | PSYS_PART_FOLLOW_SRC_MASK,
    PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_ANGLE,
    PSYS_SRC_ANGLE_BEGIN, 0.0,
    PSYS_SRC_ANGLE_END, 0.0,
    PSYS_PART_START_SCALE, <0.5, 0.75, 2>,
    PSYS_PART_END_SCALE, <0.25, 1.75, .1>,
    PSYS_PART_START_ALPHA, 1.0,
    PSYS_PART_END_ALPHA, 1.0,
    PSYS_PART_START_COLOR, <0,1,0>,
    PSYS_PART_END_COLOR, <0,1,0>,
    PSYS_PART_MAX_AGE, 1.5,
    PSYS_SRC_MAX_AGE, 0.75,
    PSYS_SRC_BURST_RATE, 0.075,
    PSYS_SRC_BURST_PART_COUNT, 2,
    PSYS_SRC_BURST_RADIUS, 0.0,
    PSYS_SRC_BURST_SPEED_MAX, 250.0,
    PSYS_SRC_BURST_SPEED_MIN, 250.0
    ]);
}

stop_particles()
{
    llParticleSystem([]);
}

default
{
    state_entry()
    {
        running = FALSE;
        stop_particles();
    }
    
    on_rez(integer num)
    {
        llResetScript();
    }
    timer()
    {
        llTriggerSound("237ee9be-d7d7-1aed-671e-060b39b58d11", 1.0);
        count += 1;
        if(count == 8)
        {
            count = 0;
            llSetTimerEvent(0);
        }
    }
    link_message(integer src, integer num, string msg, key id)
    {
        if ( msg == "ccc_on" )
        {
            running = TRUE;
        }
        else if ( msg == "ccc_off" )
        {
            running = FALSE;
        }
        else if (msg == "fire" && running)
        {
            start_particles();
            llSetTimerEvent(0.1);
        }
        else if ( msg == "cease fire" )
        {
            stop_particles();
            count = 0;
            llSetTimerEvent(0);
        }
    }
}
