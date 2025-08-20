PosterPrint App 🖼️🛒                                   demo : https://drive.google.com/file/d/19rfqCHnIWegvsxIwvyHrtkbWsKqRZmlH/view?usp=drive_link

PosterPrint App is a Flutter-based e-commerce application that allows users to order customized posters.
Users can either choose from ready-made templates or upload their own images, then customize poster size, add a frame, select quantity, and place an order with home delivery.

🚀 Features

Authentication: Sign up / Login with email & password.

Poster Templates: Browse a collection of pre-designed posters.

Upload Image: Upload your own photo to print as a poster.

Poster Customization:

Choose poster size (8x10, 11x14, 16x20, 18x24)

Add/remove frames

Set quantity

Shopping Cart: Add customized posters to cart.

Order Placement: Place order with delivery to user’s address.

State Management: Implemented with Cubit for better scalability and separation of concerns.

Responsive UI: Works across Android & iOS devices.

🛠️ Tech Stack

Framework: Flutter

State Management: Cubit (flutter_bloc)

Backend / API: (to be connected with printing service backend)

Database: (REST API)

UI: Material Design, responsive layouts

📂 Project Structure
lib/
│── cubits/               # Cubit state management files
│── models/               # Data models (Poster, User, Order, etc.)
│── screens/              # UI Screens
│   │── auth/             # Login / Signup
│   │── home/             # Home Page
│   │── shop/             # Browse posters
│   │── details/          # Poster details & customization
│   │── cart/             # Cart & checkout
│── widgets/              # Reusable widgets
│── main.dart             # Entry point

📸 Screens (example idea)

Home Screen → Browse categories or ready posters



![home](https://github.com/user-attachments/assets/eef039ba-166a-4906-a031-ecb9bc04b1e6)



Poster Customization Screen → Upload / Resize / Add frame / Select quantity

![upload](https://github.com/user-attachments/assets/8d9da4d5-6676-4b6e-8698-b59aff840d76)
![size](https://github.com/user-attachments/assets/29bd9237-7032-407c-a743-3b335c14c497)
![frame](https://github.com/user-attachments/assets/37841e8d-9d4c-417f-a0ee-3b3f215619d3)
![preview](https://github.com/user-attachments/assets/d3663d36-e233-4fa4-8c59-435ed1d49e84)




Cart Screen → Shows selected posters before checkout

![cart](https://github.com/user-attachments/assets/4e4323a1-edd7-4688-a753-aca2af2beb8a)

Checkout Screen → Enter address & place order

![address](https://github.com/user-attachments/assets/38634bc4-b124-45d7-90af-61a623583900)


🧑‍💻 Setup & Installation

Clone the repository:


git clone https://github.com/salahswidan/unique-app
cd unique-app


Install dependencies:

flutter pub get       



flutter run

📌 Future Enhancements

Online payment integration (Stripe/PayPal).

AI-based poster recommendations.


Live preview of posters in real room background.

Push notifications for order status.

📄 License

This project is licensed under the MIT License - see the LICENSE
 file for details.

