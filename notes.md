#Steps for Building a CLI Gem

[x] 1. Plan gem, imagine the interface (idea is to have a good sense of what you want to build from the user’s perspective)
[x] 2. Start with the project structure (use google!)
[x] 3. Start with the entry point (file run)
[x] 4. Force that to build the CLI interface
[ ] 5. Stub out the interface
  [ ] a. list view
  [ ] b. detail view
    [ ] determine what attributes are needed 
  => still need to style the interface properly
[ ] 6. Start making things real
[ ] 7. Discover objects
[ ] 8. Program


Quick summary of app

+ A command line interface for FIFA men's and women's soccer team world rankings from Wikipedia (https://en.wikipedia.org/wiki/FIFA_Women%27s_World_Rankings and https://en.wikipedia.org/wiki/FIFA_World_Rankings)

+ User starts program

+ Greet user and ask if they want to view the Men's or Women's rankings

+ Show the list of the 20 teams and basic stats: rank, number of points, change in position (up/down/no change)
  FIFA Men's World Rankings
  + Rank   Team - Points - Change
  + 1.   Germany - 1609 - Up
  + 2.   Brazil - 1603 - Down
  + 3.   Argentina - 1413 - Down

  Women's
  + Rank   Team - Points - Change
  + 1.   USA - 2118 - Up
  + 2.   Germany - 2111 - Down
  + 3.   France - 2076 - No Change


+ Ask the user which team they would like to learn more about
  + Team info available:
    + Description (maybe just the first paragraph?)
    + Association
    + Nicknames
    + Confederation
    + Head Coach
    + Captain

    maybes:
    + Most caps
    + Top scorer
    + FIFA Code
