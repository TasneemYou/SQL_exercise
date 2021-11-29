/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
select Name from artists Art cross join albums Alb on Art.ArtistId = Alb.ArtistId
where Alb.AlbumId=NULL;


/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
select distinct Art.Name from artists Art join albums Alb 
on Art.ArtistId = Alb.ArtistId join tracks t ON
t.AlbumId = Alb.AlbumId join genres g on 
g.GenreId = t.GenreId
where g.Name = 'Latin';



/* TASK III
Which video track has the longest length?
*/
select Name from tracks order by Milliseconds desc limit 1; 

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/
select c.FirstName, c.LastName, c.SupportRepId, c.City, e.EmployeeId, e.ReportsTo, e.City 
from customers c cross join employees e
where e.ReportsTo = NULL or c.City=e.City;

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/
select m.FirstName as manager_first, m.LastName as manager_last from employees e join employees m
on e.ReportsTo = m.EmployeeId where e.EmployeeId = (
select SupportRepId from customers where Country = 'Brazil');


/* TASK VI
Which playlists have no Latin tracks?
*/
select distinct p.Name, t.GenreId from playlists p join playlist_track pt on p.PlaylistId = pt.PlaylistId
join tracks t on pt.TrackId = t.TrackId
where t.GenreId != (SELECT GenreId from genres where Name = 'Latin');