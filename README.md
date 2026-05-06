Hey, this is a Turn Based RPG battle system I have been working on in my free time. The system is far from complete, and honestly pretty poorly made, but has been a great learning experience.

In this README, I will go over some details on how the system works in order to make it easy for anyone stopping by.



-----ACTORS-----
Actors exist in two components; a resource containing it's stats, and a scene holding it's animations.

The Resource for an actor contains things such as it's name and stats, as well as a reference to it's own animation scene.

This system is designed to work for player characters and AI controlled enemies.

For animations, an animation player node is used to give easier control over the animations, as well as a signal to time the hits of an attack with the animation.


-----SKILLS-----
Skills exist as resources. Targeting types are still a work in progress, but each skill designates an animation type, mana cost, and damage formula within it's resource file.

-----BATTLE-----
The battle system is ran by two main nodes, the Battle Manager, and a Battle State Machine.

The Battle Manager collects and distributes data, as well as running some draw commands to set the scene.

The Battle Manager contains functions for beginning attacks, resolving skills, and dealing damage.

The Battle State Machine controls when the player can use inputs and how they use inputs, as well as telling the Battle Manager when to carry out skills.


-----BATTLE SETUP-----
At the start of the battle scene, the Battle Manager runs some setup functions before tossing control to the state machine.
These include draw functions for the actors and menus, as well as some functions collecting and distributing data.
Actors are cloned for the battle so that they can be influenced without directly changing the base actor.
