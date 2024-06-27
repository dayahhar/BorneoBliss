<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Booking Data</h1>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>User ID</th>
                    <th>Package ID</th>
                    <th>Booking Pax</th>
                    <th>Booking Status</th>
                    <th>Action</th>
                    
                </tr>
            </thead>
            <tbody>
                ${bookingData} <!-- Directly print the accumulated data -->
            </tbody>
        </table>
        <form action="ViewBookingServlet" method="get"> <!-- Form for refreshing data -->
            <input type="submit" value="Refresh">
        </form>
    </div>
</body>
</html>
