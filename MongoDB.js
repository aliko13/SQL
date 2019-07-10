// Author: Ali Huseynov D14122782
db = db.getSiblingDB('d14122782_teams');

db.teams.insert({
	team_id: "eng1",
	date_founded: new Date("Oct 04, 1896"),
     league: "Premier League",
	 points: 62,
	 name: "Manchester United",
     players: [
        { p_id: "Rooney", goal: 85, caps: 125, age: 28 },
        { p_id: "Scholes", goal: 15, caps: 225, age: 28 },
			  { p_id: "Giggs", goal: 45, caps: 359, age: 38 } ]
	 });

db.teams.insert({
	team_id: "eng2",
	date_founded: new Date("Oct 04, 1899"),
     league: "Premier League",
	 points: 52,
	 name: "Arsenal",
     players: [ { p_id: "Mata", goal: 5, caps: 24, age: 27 },
              { p_id: "Bergkamp", goal: 95, caps: 98, age: 48 } ]
	 });

db.teams.insert({
	team_id: "eng3",
	date_founded: new Date("Oct 04, 1912"),
     league: "Premier League",
	 points: 65,
	 name: "Chelsea",
     players: [ { p_id: "Costa", goal: 15, caps: 25, age: 28 },
              { p_id: "Ivanov", goal: 5, caps: 84, age: 28 },
			  { p_id: "Drogba", goal: 105, caps: 125, age: 35 } ]
	 });

db.teams.insert({
	team_id: "spa1",
	date_founded: new Date("Oct 04, 1912"),
     league: "La Liga",
	 points: 80,
	 name: "Barcelona",
     players: [ { p_id: "Messi", goal: 195, caps: 189, age: 30 },
              { p_id: "Valdes", goal: 0, caps: 158, age: 27 },
			  { p_id: "Iniesta", goal: 72, caps: 25, age: 31},
			  { p_id: "Pique", goal: 9, caps: 201, age: 38 } ]
	 });

db.teams.insert({
	team_id: "spa2",
	date_founded: new Date("Nov 04, 1914"),
     league: "La Liga",
	 points: 72,
	 name: "Real Madrid",
     players: [ { p_id: "Ronaldo", goal: 135, caps: 134, age: 28 },
				 { p_id: "Bale", goal: 75, caps: 45, age: 27 },
				 { p_id: "Marcelo", goal: 11, caps: 25, age: 31 },
              { p_id: "Benzema", goal: 125, caps: 95, age: 22 } ]
	 });

db.teams.insert({
	team_id: "spa3",
	date_founded: new Date("Oct 04, 1912"),
     league: "La liga",
	 points: 68,
	 name: "Valencia",
     players: [ { p_id: "Martinez", goal: 26, caps: 54, age: 21 },
              { p_id: "Aimar", goal: 45, caps: 105, age: 29 } ]
	 });

db.teams.insert({
	team_id: "ita1",
	date_founded: new Date("Oct 04, 1922"),
     league: "Serie A",
	 points: 69,
	 name: "Roma",
     players: [ { p_id: "Totti", goal: 198, caps: 350, age: 35 },
              { p_id: "De Rossi", goal: 5, caps: 210, age: 30 },
			  { p_id: "Gervinho", goal: 43, caps: 57, age: 24 } ]
	 });

db.teams.insert({
	team_id: "ita2",
	date_founded: new Date("Oct 04, 1899"),
     league: "Serie A",
	 points: 52,
	 name: "Juventus",
     players: [ { p_id: "Buffon", goal: 0, caps: 225, age: 37 },
              { p_id: "Pirlo", goal: 45, caps: 199, age: 35 },
			  { p_id: "Pogba", goal: 21, caps: 42, age: 20 } ]
	 });

db.teams.insert({
	team_id: "ita3",
	date_founded: new Date("Oct 04, 1911"),
     league: "Serie A",
	 points: 62,
	 name: "AC Milan",
     players: [ { p_id: "Inzaghi", goal: 115, caps: 189, age: 35 },
              { p_id: "Abbiati", goal: 0, caps: 84, age: 24 },
			  { p_id: "Van Basten", goal: 123, caps: 104, age: 35 } ]
	 });

db.teams.insert({
	team_id: "ita4",
	date_founded: new Date("Oct 04, 1902"),
     league: "Serie A",
	 points: 71,
	 name: "Inter Milan",
     players: [ { p_id: "Handanovic", goal: 0, caps: 51, age: 29 },
              { p_id: "Cambiasso", goal: 35, caps: 176, age: 35 },
			  { p_id: "Palacio", goal: 78, caps: 75, age: 31 } ]
	 });

//Q2. insert 2 new players to the Manchester united and AC milan
db.teams.update(
  {"team_id": "ita3"},
  {"$push":{ "players":{ p_id: "Keane", goal: 33, caps: 326, age: 44 }}});

db.teams.update(
	{"team_id": "ita3"},
	{"$push":{ "players":{ p_id: "Kaka", goal: 53, caps: 112, age: 32 }}});

// Q3. find the oldest teams
db.teams.find().sort({"date_founded": 1}).limit(1).pretty();

// Q4. update the number of goal of all the Real Madrid Players by 3 goals each
// note: update all array elements will be released in the new version of MongoDB 3.5.12
// source link: https://jira.mongodb.org/browse/SERVER-1243
db.teams.update(
  {"team_id":"spa2"},
  {"$inc":{"players.0.goal":3}});

db.teams.update(
  {"team_id":"spa2"},
  {"$inc":{"players.1.goal":3}});

db.teams.update(
  {"team_id":"spa2"},
  {"$inc":{"players.2.goal":3}});


// Q5. using a cursor, update the number of caps of all the "Serie A" teams by incrementing them by 10% (round it!)

function update( id ) {
  var team =  db.Teams.find( {_id : id });
  teams.forEach(function (a) {
    for (var i in a.players) {
      db.Teams.update(
        { _id:  id,
          "players.goal": a.players[i].goal
        },
        {$set : {"players.$.caps" : (a.players[i].caps+(a.players[i].caps*0.1))} }
      );
    }
  });
}
cursor = db.teams.find({league:"Serie A"});
	while ( cursor.hasNext() ) {
	  updateRecords(cursor.next()._id );
	}


// Q6. update the points of Arsenal to be equal to the point of Barcelona
// get the point of the Barcelona
	var point = db.teams.findOne({name:"Barcelona"}).points;
	db.teams.update({"name":"Arsenal"}, {$set:{"points":point}});

// Q7. Find all the players over 30 years old containing the string "es"
 db.teams.aggregate( [
     { $unwind: "$players" },
     { $match: {"players.age" : {'$gte': 30 }}},
		 { $match: {"players.p_id": {'$regex' : ".*es.*"}}}
 ]);

 // Q8. Using aggregate mongoDB operator, list the total point by league.
 db.teams.aggregate({$group: {_id: "$league", total: {$sum: "$points"}}})

 // Q9. Using aggregation, list all the teams by number of goals in descending order.
 db.teams.aggregate({$project: {_id: "$name", total: {$sum: "$players.goal"}}},{$sort:{total:-1}})
