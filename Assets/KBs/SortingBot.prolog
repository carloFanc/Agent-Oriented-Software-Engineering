:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add takeBoxToTargetEA(B) && true =>[
   cr goto(B),
   act pickup(B),
   check_artifact_belief(B, destination(Ob)),
   check_agent_belief(Ob, area(DestinationArea)), 
   act (getExchangeArea(DestinationArea),EA),
   cr goto(EA), 
   act dropdown(EA),
   act (getRailBot(DestinationArea), RB),
   add_agent_belief(RB, boxinEA),
   add_agent_desire(RB, takeBoxToFinalPlatform(B)),
   act (getChargingStation(), CS),
   cr goto(CS), 
   stop
].