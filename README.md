# Agent-Oriented-Software-Engineering
The goal of this assignment consists of designing the management of an au-
tonomous warehouse, where drones and robots are employed to retrieve, move
and deliver packages (represented as boxes, in our case).

![uno](https://user-images.githubusercontent.com/18367371/108044669-da722c00-7042-11eb-870d-98cb47cdf6b4.PNG)

## the Environment
Figure 3 shows the representation of our warehouse. Every area is distinguished
by a different color (i.e., north, south, east, west). In case you are color-blinded,
you can infer which color corresponds to which area by simply looking at the
label on the corresponding exchange area (N, S, E, W).
For each area, there are 4 different platforms. Each platform has the same
color of the finishing or starting area, depending whether the box is in the
retrieving or delivering phase respectively. For instance, a box that should be
delivered from address 4 to address 2, will be transferred by the Drone on the
green platform of the west area (because the box has to arrive in the east area,
which is green) and then the RailBot of the east area will place the box { given
by the SortingBot { on the yellow platform of the east area (because the box
has arrived from the west area, which is yellow). 
The numbers near each platform simply show the number of boxes being
there at each instant of time.

## the MAS
The MAS is characterized by 1 model of artifact:
-Box
It represents the model of the boxes that will be instantiated at run-time;
and by 5 models of agent:
- PickupArea
These areas are full-edged agents: they have plans, they can add/remove
desires and beliefs from other agents, etc. They have mainly 3 roles:
1. represent the post-office box of the house,
2. deciding which drone must take care of a box it needs to send,
3. recall a box sent to it (actually destroying it).
As can be seen in the PickupArea.cs code, at the very start of the simula-
tion to each PickupArea a belief is added stating to which area it belongs
(i.e., north, south, east, west). This information could be useful to cor-
rectly design the knowledge bases of the other agents.
- GameManager
The GameManager is the agent responsible for the creation of the boxes.
It also triggers the PickupArea representing the address of the sender. We
have already provided you an example of implementation for the knowl-
edge base of such an agent, but feel free to edit it in order to make it suit
your design choices.
- Drone
Drones' main responsibility is to retrieve boxes from the PickupAreas and
deliver them to the corresponding platform, and vice versa, as explained
in section 2.1.1;
- RailBot
Each RailBot can only move along its own rail. Its main duty is to either
{ transfer the box from a platform to the exchange area and delegate
the management of the box to the SortingBot (if the box must be
delivered to a different area), or { leave the box where it is and ask a drone to deliver to the correct
address (if box's destination address is in the same area as the starting
address);
- SortingBot
The SortingBot is responsible for the sorting of the boxes from an exchange
area to another one. It is invoked by the RailBot of the starting area, and
it delegates the management of the box to the RailBot of the destination
area.
