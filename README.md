anki-growth
===========

Simulation (with a some simplifying assumptions) of [Anki](http://ankisrs.net/) decks over time. The script outputs the average number of reviews over a set period of time in a scenario where a user adds X numbers per day. I wrote it in an attempt to get a handle on how a the number of daily reviews changes over time if you add a set number of cards per day.

The program doesn't seem to model Anki behavior perfectly. Adding 20 new reviews to an actual Anki deck results in a workload of about 70 reviews per day. The simulation underestimates this by about 10 cards. Given that this is my first attempt at writing a non-numerical program in Scheme *and* first time attempting to simulate anything, there is either a problem with the implementation or the program's underlying assumptions about Anki's behavior.

The results of running the script reveals that the number of reviews per day quickly stabilize no matter how many cards you add to Anki each day. As a quick rule of thumb, you can just multiply the number of cards added per day by 3 and that's roughly the number of reviews per day that growth will be capped at. It's not perfect, but such a heuristic should be close enough for the majority of practical uses of the code. It will save you the hassle of cloning the repo and trying to get the code running, too.

For example, if you add 100 cards to Anki each day, you can expect the workload to stabilize at about 300 cards each day. 