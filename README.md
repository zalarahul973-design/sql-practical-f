# Event Management System

A complete SQL database system for managing events, venues, organizers, attendees, tickets, and payments.

## 📊 Database Overview

**6 Main Tables:**

- **Venues** → Event locations and capacity  
- **Organizers** → Event organizers' contact details  
- **Events** → Event catalog with venue and organizer info  
- **Attendees** → Event participants  
- **Tickets** → Bookings for attendees  
- **Payments** → Payment records for tickets  

---

## 🎯 Key Features

- ✅ Complete venue & organizer management  
- ✅ Event creation and tracking  
- ✅ Ticket booking system with status (Confirmed, Pending, Cancelled)  
- ✅ Payment management (Success, Failed, Pending)  
- ✅ Revenue and attendance tracking  
- ✅ Advanced SQL data organization and integrity  

---

## 🛠 Technical Details

- **Built With:** MySQL  
- **Relationships:** Proper primary and foreign key constraints  
- **Data Types:** Optimized for event and financial data  
- **Constraints:** Primary keys, foreign keys, referential integrity  

---

## 📁 Sample Data Included

- 5 Venues (Grand City Hall, Sunset Arena, Riverside Convention Center, Skyline Auditorium, Oceanview Pavilion)  
- 5 Organizers (Elite Events Co., Starline Productions, Global Gatherings, NextGen Planners, Premier Management)  
- 5 Events (Tech Innovation Summit, Music Fiesta 2025, Global Business Expo, Healthcare Leadership Forum, Art & Culture Fest)  
- 5 Attendees (Alice Johnson, Brian Smith, Catherine Lee, David Brown, Ella Martinez)  
- Tickets for attendees  
- Payment records  

---

## 💾 Installation

1. Create the database:
```sql
CREATE DATABASE project;
USE project;
2. Run all `CREATE TABLE` statements to create the necessary tables.  
3. Execute all `INSERT` statements to load the sample data.  
4. The database is now ready to use for managing events, attendees, tickets, and payments.  

---

## 📈 Use Cases

- Event management companies  
- Venue and organizer coordination  
- Ticket booking and payment tracking  
- Attendance monitoring  
- Revenue and demand analysis  

A robust SQL solution for event management, providing complete data organization, integrity, and reporting capabilities.
