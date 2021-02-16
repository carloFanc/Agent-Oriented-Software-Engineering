:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").
 
 add gotobox(B) && (\+ belief has_box) =>[
    cr takeoff(),
	cr goto(B),
	cr land(),
	act pickup(B),
	add_belief(has_box),
	add_desire(bring_box_toPlatform(B)),
	stop 
].
 
 add bring_box_toPlatform(B) && (belief has_box) =>[
    cr takeoff(),  
	check_artifact_belief(B, start(Ob1)),
	check_agent_belief(Ob1, area(StartingArea)),
	check_artifact_belief(B, destination(Ob2)),
	check_agent_belief(Ob2, area(DestinationArea)),
	act (getLandingZone(StartingArea,DestinationArea), Zone),
	cr goto(Zone),
	cr land(),
	act dropdown(),
	del_belief(has_box),
	act (getRailBot(StartingArea),RB),
	add_agent_desire(RB, takeBox(B)),
	add_desire(goChargingStation),
	stop
].

 add goChargingStation && (\+ belief has_box) =>[
   act (getChargingStation, CS),
   cr takeoff(),
   cr goto(CS),
   cr land(),
   del_belief(isBusy),
   stop
].

add deliverBox(B) && true =>[
    cr takeoff(),
	cr goto(B),
	cr land(),
	act pickup(B),
	add_belief(has_box),
	add_desire(deliverBoxToDestination(B)),
	stop
].

add deliverBoxToDestination(B) && (belief has_box) =>[
    cr takeoff(),
	check_artifact_belief(B, destination(Dest)),
	cr goto(Dest),
	cr land(),
	act dropdown(),
	check_artifact_belief(B, destination(Ob2)),
	add_agent_belief(Ob2, has_deliveredBox),
	add_agent_desire(Ob2, destroy_box(B)), 
	del_belief(has_box),
	add_desire(goChargingStation), 
	stop
].