# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
  - Have a FifaRankings::CLI class and there is an executable bin/fifa-rankings file that contains the method (FifaRankings::CLI.new.call) to launch the interface
- [x] Pull data from an external source
  - The app pulls data from Wikipedia's FIFA Women's World Rankings page (https://en.wikipedia.org/wiki/FIFA_Women%27s_World_Rankings) as well as the associated/linked Wikipedia team pages.
- [x] Implement both list and detail views
  - There is a list view of the top 20 teams sorted by their rank. The list displays the rank, team name, and the change in the team's rank since the last calculation. The detail view, which is accessed when you submit the rank of a particular team, displays the following information about the team (where available): team name, rank, total points, confederation, head coach, team captain(s), top scorer(s), and the player(s) with the most caps.
