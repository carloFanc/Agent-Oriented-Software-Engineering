:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add takeBoxToFinalPlatform(B) && (belief boxinEA) =>[
   cr goto(B),
   act pickup(B),
   check_artifact_belief(B, start(Ob1)),
   check_agent_belief(Ob1, area(StartingArea)),
   act (getArea(StartingArea), SA),
   cr goto(SA),
   act dropdown(SA),
   add_desire(invoke_drone(B)),
   act (getChargingStation(),CS),
   cr goto(CS),
   stop
].

add takeBox(B) && (\+ belief boxinEA) =>[
   check_artifact_belief(B, start(Ob1)),
   check_agent_belief(Ob1, area(StartingArea)),
   check_artifact_belief(B, destination(Ob2)),
   check_agent_belief(Ob2, area(DestinationArea)),
   StartingArea = DestinationArea,
   cr goto(B),
   act pickup(B), 
   act (getArea(DestinationArea), A),
   act dropdown(A), 
   add_desire(invoke_drone(B)),
   act (getChargingStation(),CS),
   cr goto(CS)
].

 add takeBox(B) && (\+ belief boxinEA) =>[
   check_artifact_belief(B, start(Ob1)),
   check_agent_belief(Ob1, area(StartingArea)),
   check_artifact_belief(B, destination(Ob2)),
   check_agent_belief(Ob2, area(DestinationArea)),
   StartingArea \= DestinationArea,
   cr goto(B),
   act pickup(B), 
   act (getExchangeArea(),EA),
   cr goto(EA), 
   act dropdown(EA),
   act (getChargingStation(),CS),
   cr goto(CS), 
   act (getSortingBot(),SB),
   add_agent_desire(SB, takeBoxToTargetEA(B)),
   stop
].
 
add invoke_drone(B) && true =>[
   act (getDrone(), D),
	(
	not(check_agent_belief(D, isBusy)),
	add_agent_belief(D, isBusy)
	),
   del_desire(invoke_drone(B)), 
   add_agent_desire(D, deliverBox(B)), 
   check_belief(boxinEA),
   del_belief(boxinEA),
   stop
].


 