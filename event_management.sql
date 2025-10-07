CREATE DATABASE project;

CREATE TABLE Venues (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(100),
    location VARCHAR(150),
    capacity INT
) ENGINE=InnoDB;

INSERT INTO Venues (venue_id, venue_name, location, capacity)
VALUES
(1, 'Grand City Hall', 'Downtown, New York', 5000),
(2, 'Sunset Arena', 'Los Angeles, California', 12000),
(3, 'Riverside Convention Center', 'Chicago, Illinois', 3500),
(4, 'Skyline Auditorium', 'Houston, Texas', 4500),
(5, 'Oceanview Pavilion', 'Miami, Florida', 6000);

CREATE TABLE Organizers (
    organizer_id INT PRIMARY KEY,
    organizer_name VARCHAR(100),
    contact_email VARCHAR(100),
    phone_number VARCHAR(15)
) ENGINE=InnoDB;
INSERT INTO Organizers (organizer_id, organizer_name, contact_email, phone_number)
VALUES
(1, 'Elite Events Co.', 'contact@eliteevents.com', '212-555-7812'),
(2, 'Starline Productions', 'info@starlinepro.com', '310-555-4521'),
(3, 'Global Gatherings', 'support@globalgatherings.com', '646-555-9034'),
(4, 'NextGen Planners', 'hello@nextgenplanners.com', '415-555-2378'),
(5, 'Premier Management', 'team@premiermgmt.com', '305-555-6642');


CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
    venue_id INT,
    organizer_id INT,
    ticket_price DECIMAL(10,2),
    total_seats INT,
    available_seats INT,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
) ENGINE=InnoDB;

INSERT INTO Events (event_id, event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats)
VALUES
(1, 'Tech Innovation Summit', '2025-11-15', 1, 1, 199.99, 5000, 4500),
(2, 'Music Fiesta 2025', '2025-12-05', 2, 2, 89.50, 12000, 11800),
(3, 'Global Business Expo', '2026-01-20', 3, 3, 149.00, 3500, 3300),
(4, 'Healthcare Leadership Forum', '2026-02-10', 4, 4, 99.99, 4500, 4400),
(5, 'Art & Culture Fest', '2026-03-25', 5, 5, 59.00, 6000, 5800);

CREATE TABLE Attendees (
    attendee_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
) ENGINE=InnoDB;

INSERT INTO Attendees (attendee_id, name, email, phone_number)
VALUES
(1, 'Alice Johnson', 'alice.johnson@email.com', '212-555-1010'),
(2, 'Brian Smith', 'brian.smith@email.com', '310-555-2020'),
(3, 'Catherine Lee', 'catherine.lee@email.com', '646-555-3030'),
(4, 'David Brown', 'david.brown@email.com', '415-555-4040'),
(5, 'Ella Martinez', 'ella.martinez@email.com', '305-555-5050');

CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY,
    event_id INT,
    attendee_id INT,
    booking_date DATE,
    status ENUM('Confirmed', 'Cancelled', 'Pending'),
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id)
) ENGINE=InnoDB;

INSERT INTO Tickets (ticket_id, event_id, attendee_id, booking_date, status)
VALUES
(1, 1, 1, '2025-10-01', 'Confirmed'),
(2, 2, 2, '2025-10-02', 'Confirmed'),
(3, 3, 3, '2025-10-03', 'Pending'),
(4, 4, 4, '2025-10-04', 'Cancelled'),
(5, 5, 5, '2025-10-05', 'Confirmed');

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    ticket_id INT,
    amount_paid DECIMAL(10,2),
    payment_status ENUM('Success', 'Failed', 'Pending'),
    payment_date DATE,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
) ENGINE=InnoDB;

INSERT INTO Payments (payment_id, ticket_id, amount_paid, payment_status, payment_date)
VALUES
(1, 1, 199.99, 'Success', '2025-10-01'),
(2, 2, 89.50, 'Success', '2025-10-02'),
(3, 3, 149.00, 'Pending', '2025-10-03'),
(4, 4, 0.00, 'Failed', '2025-10-04'),
(5, 5, 59.00, 'Success', '2025-10-05');

(1)CRUD
INSERT INTO events (event_id, event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats)
VALUES (6, 'New Event', '2026-04-01', 6, 6, 100.00, 1000, 1000);

-- Read all events
SELECT * FROM Events;

-- Update an event
UPDATE Events
SET event_name = 'Updated Event Name'
WHERE event_id = 1;

-- Delete an event
DELETE FROM Events
WHERE event_id = 6;

(2)
SELECT e.event_name
FROM Events e
JOIN Venues v ON e.venue_id = v.venue_id
WHERE v.location LIKE '%New York%' AND e.event_date >= CURDATE();

-- Top 5 highest revenue-generating events
SELECT e.event_name, SUM(p.amount_paid) AS revenue
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_id
ORDER BY revenue DESC
LIMIT 5;

--  Find Attendees who booked tickets in the last 7 days
SELECT a.name
FROM Attendees a
JOIN Tickets t ON a.attendee_id = t.attendee_id
WHERE t.booking_date >= CURDATE() - INTERVAL 7 DAY;

(3)SQL operators(AND,OR,NOT)
-- Events in December with >50% available seats
SELECT event_name
FROM Events
WHERE MONTH(event_date) = 12 AND available_seats > total_seats / 2;

-- Attendees with booked ticket OR pending payment
SELECT DISTINCT attendees.name
FROM Attendees 
JOIN Tickets 
ON attendees.attendee_id = tickets.attendee_id
JOIN Payments 
ON tickets.ticket_id = payments.ticket_id
WHERE tickets.status = 'Confirmed' OR payments.payment_status = 'Pending';

-- Events NOT fully booked
SELECT event_name
FROM Events
WHERE available_seats > 0;
(4) 
-- Sort events by date
SELECT event_name, event_date
FROM Events
ORDER BY event_date ASC;

-- Count attendees per event
SELECT events.event_name, COUNT(tickets.attendee_id) AS attendee_count
FROM Events 
JOIN Tickets 
ON events.event_id = tickets.event_id
GROUP BY events.event_id;

-- Total revenue per event
SELECT events.event_name, SUM(payments.amount_paid) AS total_revenue
FROM Events 
JOIN Tickets 
ON events.event_id = tickets.event_id
JOIN Payments 
ON tickets.ticket_id = payments.ticket_id
GROUP BY events.event_id;
(5)
-- Calculate the total revenue generated from all events
SELECT SUM(payments.amount_paid) AS total_revenue
FROM Payments 
JOIN Tickets 
ON payments.ticket_id = tickets.ticket_id;

-- Find the event with the highest number of attendees
SELECT events.event_name, COUNT(tickets.attendee_id) AS attendee_count
FROM Events 
JOIN Tickets 
ON events.event_id = tickets.event_id
GROUP BY events.event_id
ORDER BY attendee_count DESC
LIMIT 1;

-- Compute the average ticket price across all events
SELECT AVG(e.ticket_price) AS avg_ticket_price
FROM Events e;
(6)
Establish Primary & Foreign Key Relationships
/*All primary and foreign key relationships in the database have been successfully created. Orders are linked 
to customers, order items are linked to both orders and products, and payments and shipping are linked to orders, 
ensuring proper connections between all related tables.*/
(7)
-- Retrieve event details along with venue information using INNER JOIN
SELECT e.event_name, v.location
FROM Events e
INNER JOIN Venues v
ON e.venue_id = v.venue_id;

--  Get a list of attendees who booked a ticket but did NOT complete payment using LEFT JOIN
SELECT a.name
FROM Attendees a
JOIN Tickets t
ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p
ON t.ticket_id = p.ticket_id
WHERE p.payment_status IS NULL OR p.payment_status != 'Completed';


-- Identify events without any attendees using LEFT JOIN
SELECT e.event_name
FROM Events e
LEFT JOIN Tickets t
ON e.event_id = t.event_id
WHERE t.event_id IS NULL;

-- Show attendees who have not booked any ticket using LEFT JOIN
SELECT a.name
FROM Attendees a
LEFT JOIN Tickets t
ON a.attendee_id = t.attendee_id
WHERE t.attendee_id IS NULL;
(8)
-- Find events that generated revenue above the average ticket sales
SELECT events.event_name
FROM Events 
JOIN Tickets 
ON events.event_id = tickets.event_id
JOIN Payments 
ON tickets.ticket_id = payments.ticket_id
GROUP BY events.event_id
HAVING SUM(payments.amount_paid) > (SELECT AVG(ticket_price) FROM Events);


-- Identify attendees who have booked tickets for multiple events
SELECT attendees.name
FROM Attendees 
JOIN Tickets 
ON attendees.attendee_id = tickets.attendee_id
GROUP BY attendees.attendee_id
HAVING COUNT(DISTINCT tickets.event_id) > 1;

-- Retrieve organizers who have managed more than 3 events
SELECT organizers.organizer_name
FROM Organizers 
JOIN Events 
ON organizers.organizer_id = events.organizer_id
GROUP BY organizers.organizer_id
HAVING COUNT(events.event_id) > 3;
(9)
-- Extract the month from event_date to analyze event trends
SELECT MONTH(event_date) AS event_month
FROM Events;

-- Calculate the number of days remaining for an upcoming event
SELECT event_name, DATEDIFF(event_date, CURDATE()) AS days_remaining
FROM Events
WHERE event_date > CURDATE();

-- Format payment_date as YYYY-MM-DD HH:MM:SS
SELECT DATE_FORMAT(payment_date, '%Y-%m-%d %H:%i:%s') AS formatted_payment_date
FROM Payments;
(10)
-- Convert all organizer names to uppercase
SELECT UPPER(organizer_name) AS organizer_name_upper
FROM Organizers;

-- Remove extra spaces from attendee names using TRIM()
SELECT TRIM(name) AS trimmed_name
FROM Attendees;

-- Replace NULL email fields with 'Not Provided'
SELECT COALESCE(email, 'Not Provided') AS email
FROM Attendees;
(11)
-- Rank events based on total revenue earned
SELECT event_name, 
       SUM(payments.amount_paid) AS total_revenue,
       RANK() OVER (ORDER BY SUM(payments.amount_paid) DESC) AS revenue_rank
FROM Events 
JOIN Tickets 
ON events.event_id = tickets.event_id
JOIN Payments 
ON tickets.ticket_id = payments.ticket_id
GROUP BY events.event_id, events.event_name;


-- Display the cumulative sum of ticket sales
SELECT event_name, 
       SUM(t.ticket_price) AS ticket_sales,
       SUM(SUM(t.ticket_price)) OVER (ORDER BY e.event_id) AS cumulative_sales
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
GROUP BY e.event_id, e.event_name;
--
-- Show the running total of attendees registered per event
SELECT e.event_name, 
       COUNT(t.attendee_id) AS attendees_registered,
       SUM(COUNT(t.attendee_id)) OVER (ORDER BY e.event_id) AS running_total_attendees
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
GROUP BY e.event_id, e.event_name;
(12)
-- Categorize events based on ticket sales
SELECT e.event_name,
       e.total_seats,
       e.available_seats,
       CASE
           WHEN e.available_seats < 0.2 * e.total_seats THEN 'High Demand'
           WHEN e.available_seats BETWEEN 0.2 * e.total_seats AND 0.5 * e.total_seats THEN 'Moderate Demand'
           ELSE 'Low Demand'
       END AS demand_category
FROM Events e;

-- Assign payment statuses
SELECT p.payment_id,
       p.payment_status,
       CASE
           WHEN p.payment_status = 'Success' THEN 'Successful'
           WHEN p.payment_status = 'Failed' THEN 'Failed'
           ELSE 'Pending'
       END AS payment_status_label
FROM Payments p;