User-Related Servlets and JSPs

- SignUpServlet
Description: Handles user registration.
JSPs:
1. signup.jsp (form for user registration)
2. signup_success.jsp (confirmation page after successful registration)

- LoginServlet
Description: Handles user login.
JSPs:
1. login.jsp (form for user login)
2. login_success.jsp (page after successful login)

- ProfileServlet
Description: Displays and allows updating user profile.
JSPs:
1. profile.jsp (form for viewing/updating user profile)

- BookingServlet
Description: Handles booking creation and viewing.
JSPs:
1. create_booking.jsp (form for creating a booking)
2. view_bookings.jsp (displays user's bookings)

- PaymentServlet
Description: Handles payment processing.
JSPs:
1. payment.jsp (form for entering payment details)
2. payment_success.jsp (confirmation page after successful payment)

- ChatbotServlet (KIV)
Description : Handles incoming user questions, generate responses and save interactions to database.
JSP:
1. chatbot.jsp (chat interface that use JavaScript and AJAX to handle real-time communication with the servlet)


Admin-Related Servlets and JSPs

- AdminLoginServlet
Description: Handles admin login.
JSPs:
1. admin_login.jsp (form for admin login)
2. admin_dashboard.jsp (admin dashboard after successful login)

- ManageUsersServlet
Description: Allows admin to view and manage users.
JSPs:
1. view_users.jsp (displays a list of users)

- ManagePackagesServlet
Description: Allows admin to view and manage travel packages.
JSPs:
1. view_packages.jsp (displays a list of packages)
2. edit_package.jsp (form for editing package details)
3. add_package.jsp (form for adding a new package)

-BookingApprovalServlet
Desc: for approving/rejecting bookings
-CheckBookingServlet
Desc : for retrieving and displaying booking information
JSP :
1. adminBookings.jsp (for viewing and managing bookings)

- GenerateReportServlet
Description: Handles report generation.
JSPs:
1. generate_report.jsp (form for generating a report)
2. view_report.jsp (displays the generated report)
