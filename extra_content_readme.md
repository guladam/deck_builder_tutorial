# Adding 3 new relics to the game

## Confusing Staff
You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/f54b9d974ef224555f7a889d2d425bb4777afb68

Here's a description of the Relic, it works similar to "Snecko Eye" in Slay the Spire:

```Randomize the cost of your cards between 0 and 3.```

Here's a step-by-step guide on what you need to do.

1. Create a new Relic Resource (confusing_staff.tres)
2. Create a new Script, based on the Relic template.
3. For this to work, we need access to the PlayerHandler. There are a bunch of ways to do it. I decided to use groups for this.
4. Open battle.tscn
5. Add the PlayerHandler node to a new group called "player_handler"
6. Finalize the code for the new Relic in confusing_staff.gd
7. Test if it works properly.

## Wooden Sword
You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/d2383fbb6af9cd1a3e97714696c56b4e67fee119

Here's a description of the Relic, it works similar to "Letter Opener" in Slay the Spire:

```Whenever you play 3 skills during your turn, deal 5 damage to all enemies.```

Here's a step-by-step guide on what you need to do.

1. Create a new Relic Resource (wooden_sword.tres)
2. Create a new Script, based on the Relic template.
3. We need to count these cards per turn. I used the map_exited and the player_hand_drawn events to make sure the counter resets at every turn, in every battle.
6. Finalize the code for the new Relic in wooden_sword.gd
7. Test if it works properly. It's easier to test if you change more cards to Skills temporarily.

```Quick note: I also figured that the original solution only worked once/turn. In reality, you might trigger this relic multiple times per turn. I changed it in this commit:```

https://github.com/guladam/deck_builder_tutorial/commit/3919f740593956f0197fbdfad04ea57ea644b7b7


## Blinding Potion
You can find all changes for the first milestone in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/8c84cb1d9d88b63e6adac0d0dc33e7407cad50df

Here's a description of the Relic, it works similar to "Runic Dome" in Slay the Spire:

```Gain 1 extra energy at the start of each turn. You no longer see enemy intents.```

Here's a step-by-step guide on what you need to do.

1. Create a new Relic Resource (blinding_potion.tres)
2. Create a new Script, based on the Relic template.
3. For this to work, we need access to the Enemy IntentUIs and CharacterStats. There are a bunch of ways to do it. I decided to use groups for this.
4. Open enemy.tscn
5. Add the IntentUI node to a new group called "intent"
6. Open run.tscn
7. Add the Run node to a new group called "run"
6. Finalize the code for the new Relic in blinding_potion.gd
7. We need to reduce the alpha to 0 instead of just calling hide() because we already use show() and hide() when the enemy intent changes.
7. Test if it works properly. We have a problem: if you save and load the game continuously we keep getting one extra mana... it's because the deactivate_relic() method is only called AFTER we have already saved the data with the CharacterStats resource updated.

We fix this in the second version, with this commit:

https://github.com/guladam/deck_builder_tutorial/commit/414cd5fc4151a9b41350dcf981d9baed208decd4

## With all the new Relics added, let's not forget to add them to the pool of Shop and Treasure Relics:

https://github.com/guladam/deck_builder_tutorial/commit/e0352be135a85048b1d1e5aa36b44461b8a3bfb5

# Adding 3 new cards to the game

## Trickster
You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/dad89ed713d1e909d53232dd4554bdf1f5d861a9

Here's a description of the Card, it works similar to "Finesse" in Slay the Spire:

```Gain 2 block. Draw 1 card.```

Here's a step-by-step guide on what you need to do.

1. It's a good idea to create a new Effect, we can use for Cards and Relics which can draw cards. Create the CardDrawEffect class based on the Effect template. (card_draw_effect.gd)
2. Create a new Card Resource (warrior_trickster.tres)
3. Create a new Script, based on the Card template. (warrior_trickster.gd)
4. Assign it to the new Card Resource
5. Test it.
6. Add it to the pool of draftable cards so it can appear in Shops and BattleRewards!

## Sharp Knife
You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/1060d8fff7e1f951d2ce29e38c2b69cd9e646797

Here's a description of the Card, it works similar to "Rampage" in Slay the Spire:

```Deal 6 damage. +4 damage this combat.```

Here's a step-by-step guide on what you need to do.

1. Create a new Card Resource (warrior_sharp_knife.tres)
2. Create a new Script, based on the Card template. (warrior_sharp_knife.gd)
3. Assign it to the new Card Resource
4. Test it.
5. Add it to the pool of draftable cards so it can appear in Shops and BattleRewards!

## Angry Anvil
You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/6f2001f50c6a2cd7ab3e934aa287f73a056de51a

Here's a description of the Card, it works similar to "True Grit" in Slay the Spire:

```Gain 7 block. Exhaust 1 random card.```

Here's a step-by-step guide on what you need to do.

1. It's a good idea to create a new Effect, we can use for Cards and Relics which can exhaust random cards. Create the ExhaustRandomEffect class based on the Effect template. (exhaust_random_effect.gd)
2. Create a new Card Resource (warrior_angry_anvil.tres)
3. Create a new Script, based on the Card template. (warrior_angry_anvil.gd)
4. Assign it to the new Card Resource
5. Test it.
6. Add it to the pool of draftable cards so it can appear in Shops and BattleRewards!

```Quick note: we can simply queue_free() the random card from the hand because there is no exhaust pile in this example project. Exhausting a card simply means deleting it or not adding it to the discard pile after playing.```

```If you want to have an exhaust pile in your game this ExhaustRandomEffect needs to be changed.```

# New room type: Event Rooms

## Step 1: Creating the new Room type

You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/b8f8f54bc34a73f1e83867033719a29514be949a

Here’s a step-by-step guide on what you need to do.

1. In room.gd add a new enum type called EVENT.
2. In map_room.gd add a icon and scale constant to the ICONS dictionary. Use the new Room.Type.EVENT as a key.
3. In map_generator.gd add a new random weight to ensure there's a chance that an EVENT room appears on the map.
4. Test it by starting a new Run. You should see EVENT rooms now, but nothing happens when you click on them.

## Step 2: Creating Placeholder Event Rooms

You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/dbd1833351e028cc3a07de330729e56c943d49e8

Here’s a step-by-step guide on what you need to do.

1. In events.gd add a new EventBus signal.
2. Create a new export variable for the Room resource (room.gd)
3. In run.gd add a new match in the _on_map_exited() callback and also establish a connection to the new EventBus signal inside _setup_event_connections().
4. Create a new Scene called EventRoomButton with a script attached to it. This is useful because MOST events are single choices of button clicks. The system will be flexible so you can create all kinds of crazy events but if you want to do a lot of simple button click events, having this scene helps a lot. (event_room_button.gd and event_room_button.tscn)
5. Create two example Event Scenes. Control Node root nodes + 1 instantiated EventRoomButton each.
6. Create a new Resource type script called EventRoomPool (event_room_pool.gd)
7. Create a new EventPool Resource (event_room_pool.tres)
8. Assign the 2 test event room scenes to this new Resource's export variable.
9. Modify map_generator.gd so we can assign random Event rooms from the pool when an Event-type Room is generated.
10. Open map_generator.tscn and map.tscn: assign the event_room_pool.tres resource to the new export variables.
11. Test the game. Now if you click on the buttons in EventRooms you go back to the map and you can continue playing the game.
12. We can also create a script template for EventRooms (event_room_template.gd)

(Note) there are some extra comments added to the template in this commit: https://github.com/guladam/deck_builder_tutorial/commit/a8188c6629a3d122135664cdc3c3aebde18680a2

## Step 3: Creating two EventRooms

The "gambling event" is actually finished in the previous commit:
https://github.com/guladam/deck_builder_tutorial/commit/dbd1833351e028cc3a07de330729e56c943d49e8

Basically you need to modify the first test scene you created in the previous step, according to gamble_event.gd and gamble_event.tscn.

The other event is called the "helpful boi event", you can track changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/d3b62d2d753b2c2491c20520701c75e4bc740b90

Here’s a step-by-step guide on what you need to do.

1. Rename the second test event scene to "helpful_boi_event.tscn"
2. Change the Scene according to helpful_boi_event.tscn
3. Attach a new Script to the root node, based on the EventRoom template (helpful_boi_event.gd)
4. Test it.

```Note: to test these events, you can set the export variables to the root nodes of the events, and use print() statements to check how the values change.```

## Step 4: Hooking up the EventRooms inside Run

You can find all changes in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/1e0ad80a374d85bc7f00f585fb783b6d95222ac9

1. We need to change temporary code in Run, and inject the dependencies (CharacterStats and RunStats) to EventRooms.
2. If you test it after changing run.gd you'll see that your max_hp doesn't update in the TopBar.
3. That's because the stats_changed() signal is not emitted when the max_hp changes.
4. Change stats.gd accordingly and test again.

Hope you enjoyed adding some new content! 😊

# Fixing a Bug with the GambleEvent

There was a bug where the GambleEvent could crash on the _ready() callback as it tried to access the run_stats Resource before it was injected as a dependency.

This can be fixed, by moving it to a separate setup() method, which is called manually by the Run class, AFTER setting those dependencies. You can find the fix in this commit:
https://github.com/guladam/deck_builder_tutorial/commit/aec9f41cb8cc941bb8f385bbb3578c0e6684392e