#Steps for Building a CLI Gem

[x] 1. Plan gem, imagine the interface (idea is to have a good sense of what you want to build from the user’s perspective)
[x] 2. Start with the project structure (use google!)
[x] 3. Start with the entry point (file run)
[x] 4. Force that to build the CLI interface
[x] 5. Stub out the interface
  [x] a. list view
  [x] b. detail view
    [x] determine what attributes are needed
  => still need to style the interface properly
[x] 6. Start making things real
[ ] 7. Discover objects
[ ] 8. Program

#To Do
[x] Team Class - figure out how to put the teams in the right array based on gender
[ ] Re-evaluate the team details that I want to display
[x] CLI - Stub out Detail view
[ ] Test out detail view for one team 
[ ] Scraper - figure out how to get the lowest rank detail item
[ ] Scraper - Test out scraping all womens team details
[ ] Scraper - figure out how to get the mens team details
[ ] Fix incorrect input bug in CLI #call loop
[x] Test out passing the scraped rankings data to the Team Class
[x] Test out Scraper => Team => CLI with rankings data
[x] Fix bug - teams are out of order when ranked
[x] Test out passing one team's scraped data to the Team Class
[ ] Test out passing all team scraped data to the Team Class
[x] Test out Scraper => Team => CLI with one team's data
[ ] Test out Scraper => Team => CLI with all team data

#Tasks for Go-Live/Live Testing
[ ] change the if statements in #scrape_rankings_page
[ ] change html variable assignment in Scraper#scrape_rankings_page
[ ] change the html variable assignment Scraper#scrape_team_page

#Potential Elements to Refactor/Add
[ ] #scrape_rankings_page - logic for scraping women's team rankings
[ ] CLI - use %s formatting for list view
[ ] CLI - allow user to go back and see W or M teams after selection
[ ] revisit assigning team's gender - should it go in the scraper? should it be done elsewhere?


Quick summary of app

+ A command line interface for FIFA men's and women's soccer team world rankings from Wikipedia (https://en.wikipedia.org/wiki/FIFA_Women%27s_World_Rankings and https://en.wikipedia.org/wiki/FIFA_World_Rankings)

+ User starts program

+ Greet user and ask if they want to view the Men's or Women's rankings

+ Show the list of the 20 teams and basic stats: rank, number of points, change in position (up/down/none)
  FIFA Men's World Rankings
  + Rank (6 char)  Team (15 char) - Points (8 char)- Change (8)
  + 1.   Germany - 1609 - Up
  + 2.   Brazil - 1603 - Down
  + 3.   Argentina - 1413 - Down

  Women's
  + Rank   Team - Points - Change
  + 1.   USA - 2118 - Up
  + 2.   Germany - 2111 - Down
  + 3.   France - 2076 - None


+ Ask the user which team they would like to learn more about
  + Team info available:
    + Description (maybe just the first paragraph?)
    + Nicknames
    + Confederation
    + Head Coach
    + Captain
    + Current Ranking => should this not be a team-level attribute? the ranking can later be conferred by the order in the array?
    + Team Name
    + Current Points Total
    + Movement in Rankings (up/down/none)

    maybes:
    + Most caps
    + Top scorer
    + FIFA Code
    + Association

Example:
*should there be a header here with the team's ranking and points?*
Team Name: Germany
Current FIFA Ranking: 1
Current Points Total: 1609
Nickname(s): Nationalelf (national eleven), DFB-Elf (DFB Eleven), Die Mannschaft (The Team)
Confederation: UEFA (Europe)
Head Coach: Joachim Löw
Captain: Manuel Neuer
Brief Description:
"The Germany national football team (German: Die deutsche Fußballnationalmannschaft or just Die Mannschaft) is the men's football team that has represented Germany in international competition since 1908.[4] It is governed by the German Football Association (Deutscher Fußball-Bund), founded in 1900.[8][9] Ever since the DFB was reinaugurated in 1949 the team has represented the Federal Republic of Germany. Under Allied occupation and division, two other separate national teams were also recognised by FIFA: the Saarland team representing the Saarland (1950–1956) and the East German team representing the German Democratic Republic (1952–1990). Both have been absorbed along with their records[10][11] by the current national team. The official name and code "Germany FR (FRG)" was shortened to "Germany (GER)" following the reunification in 1990."

*maybe leave this out*
Current Roster:
1	GK	Kevin Trapp
12	GK	Bernd Leno
22	GK	Marc-André ter Stegen
2	DF	Shkodran Mustafi
3	DF	Jonas Hector
4	DF	Matthias Ginter
5	DF	Marvin Plattenhardt
6	DF	Benjamin Henrichs
16	DF	Antonio Rüdiger
17	DF	Niklas Süle
18	DF	Joshua Kimmich
7	MF	Julian Draxler (Captain)
8	MF	Leon Goretzka
10	MF	Kerem Demirbay
14	MF	Emre Can
15	MF	Amin Younes
20	MF	Julian Brandt
21	MF	Sebastian Rudy
9	FW	Sandro Wagner
11	FW	Timo Werner
13	FW	Lars Stindl
