// Author: Ali Huseynov D14122782
// Part 1
// Add a person Tom (age: 28 from: Spain like: football). Make Tom a friend of Mary.
 // Insert a new person (name: Bill, age: 23, country: Ireland) and make Bill a friend of Mary and Denis
CREATE (e17:Person { name: "Tom", country: "Spain", age: 28, sport: "Football" }),
(e18:Person { name: "Bill", country: "Ireland", age: 23}),
(e17)-[:FRIEND_OF]->(e1),(e18)-[:FRIEND_OF]->(e1)

// Show the age of Denis and his friends
MATCH (e:Person {name:"Denis"})-[:FRIEND_OF]->(e2:Person)
RETURN e.age, e2.age

// Show all the person from Scotland
MATCH (e:Person {country:"Scotland"})
 RETURN e.name, e.country

 // Show all the person with age less or equal than 20 from Ireland
 MATCH (e:Person) where e.age<20 and e.country="Ireland" return e.name

 // Show all the person with age less or equal 30 playing football
 MATCH (e:Person) where e.age<=30 and e.sport="Football" return e.name

 // Count the person by country
 MATCH (e:Person) return e.country, count(*) order by e.country

 // Show the average age of the person group by sport
 MATCH (e:Person) return e.sport, avg(e.age) order by e.sport

 // Show all the direct friends of Mary
 MATCH (e:Person {name:"Mary"})-[:FRIEND_OF]-(e2:Person)
 RETURN e2.name

 // Show all the friends of Paul with a maximum distance of 5 steps
 MATCH (e:Person {name:"Paul"})-[:FRIEND_OF*..5]-(e2:Person)
 RETURN e2.name

 // Count all the friends of Paul with maximum distance 5 steps by nationality
 MATCH (e:Person {name:"Paul"})-[:FRIEND_OF*..5]-(e2:Person)
RETURN e2.country, count(e2) order by e2.country

// Show the path(s) between Paul and Lisa. For each path show the length. How many paths are there?
MATCH (e:Person{name:"Paul"})
MATCH path = shortestpath( (e)-[:FRIEND_OF]-(m:Person{name:"Lisa"} ) )
RETURN m.name,length(path)
ORDER BY m.name

// Show the shortest path between Paul and Lisa.
MATCH (e:Person{name:"Paul"})
MATCH path = shortestpath( (e)-[:FRIEND_OF]-(m:Person{name:"Lisa"} ) )
RETURN path

// Show (if exists) a connection between Mary and all her friends, where the path can only contain persons that play football
MATCH (e:Person {name:"Mary"})
MATCH path = shortestpath((e)-[:FRIEND_OF]->(e2:Person))
where e2.sport="Football" return path

// Part2
// creating nodes and connections
CREATE (a1:Airport {city: "Dublin",country:"Ireland", code:"dub"}),
(a2:Airport {city: "Cork",country:"Ireland", code:"ork"}),
(a3:Airport {city: "London",country:"UK", code:"lhr"}),
(a4:Airport {city: "Rome",country:"Italy", code:"fco"}),
(a5:Airport {city: "Moscow",country:"Russia", code:"dme"}),
(a6:Airport {city: "Hongkong",country:"China", code:"hkg"}),
(a7:Airport {city: "Amsterdam",country:"Holland", code:"ams"}),
(a8:Airport {city: "Berlin",country:"Germany", code:"txl"}),
(a9:Airport {city: "Paris",country:"France", code:"cdg"}),
(a10:Airport {city: "Newyork",country:"USA", code:"jfk"}),
(a11:Airport {city: "Chicago",country:"USA", code:"ord"}),
(a12:Airport {city: "Sao_paulo",country:"Brazil", code:"gru"}),
(a13:Airport {city: "Rio",country:"Brazil", code:"gig"}),
(a3)-[:Connected_to {time:45,price:150}]->(a1),
(a4)-[:Connected_to {time:150,price:400}]->(a3),
(a4)-[:Connected_to {time:120,price:500}]->(a9),
(a9)-[:Connected_to {time:60,price:200}]->(a1),
(a8)-[:Connected_to {time:240,price:900}]->(a5),
(a9)-[:Connected_to {time:30,price:100}]->(a7),
(a8)-[:Connected_to {time:120,price:900}]->(a1),
(a3)-[:Connected_to {time:700,price:1100}]->(a10),
(a1)-[:Connected_to {time:360,price:800}]->(a10),
(a1)-[:Connected_to {time:50,price:50}]->(a2),
(a1)-[:Connected_to {time:150,price:70}]->(a4),
(a1)-[:Connected_to {time:480,price:890}]->(a11),
(a7)-[:Connected_to {time:660,price:750}]->(a6),
(a3)-[:Connected_to {time:700,price:1000}]->(a6),
(a1)-[:Connected_to {time:90,price:60}]->(a7),
(a5)-[:Connected_to {time:720,price:1000}]->(a10),
(a5)-[:Connected_to {time:420,price:500}]->(a6),
(a10)-[:Connected_to {time:240,price:430}]->(a11),
(a1)-[:Connected_to {time:900,price:800}]->(a12),
(a12)-[:Connected_to {time:840,price:650}]->(a11),
(a13)-[:Connected_to {time:45,price:150}]->(a8)

// Find the total time from Moscow to Rio. Show also the path (airport connections)
MATCH path = (a:Airport{city:"Moscow"})-[:Connected_to*..5]-(a2:Airport{city:"Rio"})
RETURN
path, REDUCE (tot = 0, n IN relationships(path) | tot + n.time)
as total_time

// Show all the flights from Dublin to any destination and sort them by price (from the most expensive)
MATCH path = (a:Airport{city:"Dublin"})-[:Connected_to*..5]-(a2:Airport)
RETURN
REDUCE (tot = 0, n IN relationships(path) | tot + n.price)
as total_price order by total_price desc

// Show what can be reached from Chicago in one or two steps (= direct flight or 1 change only)
// the following query shows the direct and one step options from Chicago to other airports
MATCH (a1:Airport{city:"Chicago"})-[:Connected_to]-(a2:Airport), (a3:Airport{city:"Dublin"})-[:Connected_to*..1]-(a4:Airport)
RETURN
a2.code, a4.code

// Show what can be reached from London in less than 240 minutes (4 hours).
// I am pretty sure their much more clever way, but i could not find it :( 
MATCH path=(a:Airport{city:"London"})-[:Connected_to*..3]-(a2:Airport)
RETURN
a2.city,
REDUCE (tot = 0, n IN relationships(path) |tot + n.time) as total order by total limit(11)
