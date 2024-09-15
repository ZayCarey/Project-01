/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

-> start

// Initialize variables
VAR torch = false
VAR key = false
VAR strength = 3
VAR intelligence = 0
VAR artifact = false
VAR health = 10

== start ==
You find yourself at the edge of an ancient forest rumored to contain hidden ruins. Your goal is to find the lost artifact said to be hidden deep within.

+ [Enter the forest] -> forest
+ [Stay back] -> leave

== forest ==
The forest is dark and foreboding. You hear the sounds of creatures moving around you.
* {torch == false} [Look for a torch] -> find_torch
* {torch == true} [Continue deeper into the forest] -> deeper_forest
* [Explore the nearby cave] -> cave

== find_torch ==
You search around and find an old torch. This will help you navigate the forest.
~ torch = true
-> forest

== cave ==
You enter a dark cave. It's pitch black, and you can hear the sound of dripping water.
* {torch == true} [Light the torch to see] -> light_torch
* {torch == false} [Proceed in the dark] -> proceed_dark

== light_torch ==
You light the torch, revealing the cave is filled with bats! They scatter, but not before scratching you.
~ health -= 2
You lose 2 health points from the bats' scratches.
-> deeper_cave

== proceed_dark ==
You proceed in the dark but stumble into a pit. It's a narrow escape, but you manage to climb out.
~ health -= 3
You lose 3 health points from the fall.
-> deeper_cave

== deeper_cave ==
Deeper in the cave, you find a small chest. It could be a trap, but it might contain something valuable.
+ [Open the chest] -> open_chest
+ [Leave it alone] -> forest

== open_chest ==
You open the chest and find a health potion and a small knife.
~ health += 5
You gain 5 health points after drinking the potion.
~ strength += 1
You equip the knife, increasing your strength by 1.
-> forest

== deeper_forest ==
You venture deeper into the forest. The torchlight helps you see the path ahead.
* {key == false} [Search for a key] -> find_key
* {key == true} [Approach the ruins] -> ruins
* [Explore the abandoned camp] -> camp

== find_key ==
You find a rusty key hidden under a pile of leaves. This might open something important.
~ key = true
-> deeper_forest

== camp ==
You come across an abandoned camp. It's eerily quiet, and you have a bad feeling about this place.
+ [Search the camp] -> search_camp
+ [Avoid the camp] -> ruins

== search_camp ==
As you search the camp, a wild animal appears and attacks you!
* [Fight the animal] -> fight_animal
* [Run away] -> run_away

== fight_animal ==
You fight the animal with all your might.
* {strength >= 4} [Defeat the animal] -> defeat_animal
* {strength < 4} [Struggle to fend it off] -> struggle_animal

== defeat_animal ==
With your increased strength, you manage to defeat the animal.
~ health -= 2
You lose 2 health points in the fight but gain some confidence.
-> ruins

== struggle_animal ==
The animal overpowers you, and you barely manage to escape with your life.
~ health -= 5
You lose 5 health points and feel your strength weakening.
-> ruins

== run_away ==
You choose to run away, avoiding further injury.
~ health -= 1
You lose 1 health point in the process.
-> ruins

== ruins ==
You arrive at the ancient ruins. There's a large door with a keyhole.
* {key == true} [Use the key to open the door] -> open_door
* {key == false} [Try to break the door open] -> break_door

== open_door ==
You use the key to open the door. Inside, you find the lost artifact resting on a pedestal.
* [Take the artifact] -> take_artifact

== break_door ==
You try to break the door open using your strength.
* {strength >= 5} [Push the door open with all your might] -> break_success
* {strength < 5} [Try again] -> break_fail

== break_success ==
Your strength is enough to break the door open. You find the lost artifact resting on a pedestal.
* [Take the artifact] -> take_artifact

== break_fail ==
You don't have enough strength to break the door open.
-> ruins

== take_artifact ==
You take the lost artifact. It's glowing with a strange light. You feel a surge of energy coursing through you.
~ artifact = true
~ intelligence += 2
The artifact has enhanced your intelligence.

Now that you have the artifact, you need to decide how to leave the ruins safely.
+ [Take the hidden passage] -> hidden_passage
+ [Leave through the front entrance] -> front_entrance

== hidden_passage ==
You find a hidden passage behind the pedestal. It looks narrow and dark.
* {torch == true} [Light the torch and proceed] -> torch_passage
* {torch == false} [Go in without the torch] -> dark_passage

== torch_passage ==
You light the torch and make your way through the narrow passage. It's a tight fit, but you manage to squeeze through without incident.
-> final_exit

== dark_passage ==
You proceed through the passage without a torch, stumbling over loose rocks and sharp edges.
~ health -= 3
You lose 3 health points from the scrapes and bruises.
-> final_exit

== front_entrance ==
You decide to leave through the front entrance. As you step outside, you are confronted by a group of bandits!
+ [Fight the bandits] -> fight_bandits
+ [Try to escape] -> escape_bandits

== fight_bandits ==
You prepare to fight the bandits.
* {strength >= 5} [Fight with all your might] -> win_bandits
* {strength < 5} [Struggle to fight them off] -> lose_bandits

== win_bandits ==
You fight bravely and manage to defeat the bandits.
~ health -= 4
You lose 4 health points but manage to escape with the artifact.
-> final_exit

== lose_bandits ==
The bandits overpower you, and you barely manage to escape with your life.
~ health -= 6
You lose 6 health points and drop the artifact during the scuffle.
~ artifact = false
You escape, but the artifact is lost.
-> end

== escape_bandits ==
You decide to run for your life, evading the bandits in the dense forest.
* {intelligence >= 3} [Use your wits to outsmart them] -> outsmart_bandits
* {intelligence < 3} [Run blindly through the forest] -> caught_bandits

== outsmart_bandits ==
You use your wits to lose the bandits in the forest, successfully escaping with the artifact.
-> final_exit

== caught_bandits ==
The bandits catch up to you and take the artifact.
~ artifact = false
You manage to escape with your life, but the artifact is lost.
-> end

== final_exit ==
You finally make it out of the forest with the artifact in hand. Its power courses through you, and you know this discovery will change everything.
-> end

== leave ==
You decide not to enter the forest. Perhaps it's safer to leave the artifact lost forever.
-> end

== end ==
THE END
->END
* [Restart the game] -> start