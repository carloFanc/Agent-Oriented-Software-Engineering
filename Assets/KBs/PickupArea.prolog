:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").


 add call_drone(B) && true =>[
    act (getDrone(), D),
	(
	not(check_agent_belief(D, isBusy)),
	add_agent_belief(D, isBusy)
	),
	add_agent_desire(D, gotobox(B)),
	stop
].
 
add destroy_box(B) && (belief has_deliveredBox) =>[
    act destroy(B),
	del_belief(has_deliveredBox),
	stop
].