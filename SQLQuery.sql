--1. Find the 5 Oldest (Most Loyal) Users
SELECT * 
FROM users
ORDER BY created_at ASC
LIMIT 5;

--2. Find Users Who Have Never Posted a Photo (Inactive Users)
SELECT users.username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.image_url IS NULL;

--3. Find the Most Liked Photo (Contest Winner)
SELECT users.username, photos.id AS photo_id, photos.image_url, COUNT(*) AS total_likes
FROM photos
JOIN likes ON photos.id = likes.photo_id
JOIN users ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

--4. Find Top 5 Most Used Hashtags
SELECT tags.tag_name, COUNT(*) AS total_num_used
FROM photo_tags
JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tags.tag_name
ORDER BY total_num_used DESC
LIMIT 5;

--5. Find the Best Day of the Week for Ad Launch (Most Registrations)
SELECT DAYNAME(created_at) AS Days, COUNT(*) AS Total_logins
FROM users
GROUP BY Days
ORDER BY Total_logins DESC;


--6. Calculate Average Number of Posts per User
SELECT 
    (SELECT COUNT(*) FROM photos) / 
    (SELECT COUNT(*) FROM users) AS avg_posts_per_user;


--7. Identify Potential Bots (Users Who Liked Every Photo)
	SELECT users.username, COUNT(*) AS total_likes
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = (SELECT COUNT(*) FROM photos);
