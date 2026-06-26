<div align="center">

<img src="assets/icons/app_icon.png" alt="Explaino Logo" width="100"/>

# Explaino

**An educational social platform connecting students and experts — powered by Flutter.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

</div>

---

## 📖 About

**Explaino** is a graduation project mobile application built with Flutter that creates an educational social network. It allows users to ask questions, share posts and certificates, book one-on-one meetings with experts, and interact with an AI-powered chatbot — all within a single platform.

---

## ✨ Features

- 🔐 **Authentication** — Secure sign-up, login, and OTP verification flow
- 🏠 **Home Feed** — Browse community posts and questions in a dynamic feed
- ❓ **Ask Questions** — Post academic/professional questions and receive answers
- 📝 **Share Posts** — Create and share posts with images, videos, and PDF attachments
- 🏅 **Certificates** — Upload and showcase professional certificates
- 💬 **Comments & Replies** — Facebook-style threaded comment system
- 📅 **Schedule Meetings** — Book, confirm, and manage one-on-one sessions with experts
- 🤖 **AI Chatbot** — Built-in AI assistant for instant help
- 👤 **User Profiles** — View and manage your personal profile and activity

---

## 📱 Screenshots

### 🚀 Onboarding & Authentication

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/onbording_1.jpg" width="180"/><br/><sub>Onboarding 1</sub></td>
    <td align="center"><img src="assets/screenshots/onbording_2.jpg" width="180"/><br/><sub>Onboarding 2</sub></td>
    <td align="center"><img src="assets/screenshots/onbording_3.jpg" width="180"/><br/><sub>Onboarding 3</sub></td>
    <td align="center"><img src="assets/screenshots/login.jpg" width="180"/><br/><sub>Login</sub></td>
  </tr>
</table>

### 📝 Registration

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/Registeration.jpg" width="180"/><br/><sub>Register Step 1</sub></td>
    <td align="center"><img src="assets/screenshots/Registeration_2.jpg" width="180"/><br/><sub>Register Step 2</sub></td>
    <td align="center"><img src="assets/screenshots/Registeration_3.jpg" width="180"/><br/><sub>Register Step 3</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="assets/screenshots/Registeration_4.jpg" width="180"/><br/><sub>Register Step 4</sub></td>
    <td align="center"><img src="assets/screenshots/Registeration_5.jpg" width="180"/><br/><sub>Register Step 5</sub></td>
    <td align="center"><img src="assets/screenshots/Registeration_6.jpg" width="180"/><br/><sub>Register Step 6</sub></td>
  </tr>
</table>

### 🏠 Home Feed

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/Home_posts.jpg" width="180"/><br/><sub>Home — Posts</sub></td>
    <td align="center"><img src="assets/screenshots/Home_questions.jpg" width="180"/><br/><sub>Home — Questions</sub></td>
    <td align="center"><img src="assets/screenshots/Post_comment.jpg" width="180"/><br/><sub>Post Details & Comments</sub></td>
  </tr>
</table>

### ✍️ Create Content

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/Add_post.jpg" width="180"/><br/><sub>Add Post</sub></td>
    <td align="center"><img src="assets/screenshots/Add_question.jpg" width="180"/><br/><sub>Add Question</sub></td>
    <td align="center"><img src="assets/screenshots/Add_certificate.jpg" width="180"/><br/><sub>Add Certificate</sub></td>
  </tr>
</table>

### 💡 Answers

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/Answer.jpg" width="180"/><br/><sub>Answer View</sub></td>
    <td align="center"><img src="assets/screenshots/Answer_2.jpg" width="180"/><br/><sub>Answer Detail</sub></td>
  </tr>
</table>

### 📅 Meetings

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/Meeting_1.jpg" width="180"/><br/><sub>Meetings List</sub></td>
    <td align="center"><img src="assets/screenshots/Meeting_2.jpg" width="180"/><br/><sub>Schedule Meeting</sub></td>
    <td align="center"><img src="assets/screenshots/Meeting_3.jpg" width="180"/><br/><sub>Meeting Details</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="assets/screenshots/Meeting_4.jpg" width="180"/><br/><sub>Meeting Confirmed</sub></td>
    <td align="center"><img src="assets/screenshots/Meeting_5.jpg" width="180"/><br/><sub>Meeting Status</sub></td>
    <td align="center"><img src="assets/screenshots/Meeting_6.jpg" width="180"/><br/><sub>Meeting Summary</sub></td>
  </tr>
</table>

### 🤖 AI Chatbot

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/Chatbot_1.jpg" width="180"/><br/><sub>Chatbot — Start</sub></td>
    <td align="center"><img src="assets/screenshots/Chatbot_2.jpg" width="180"/><br/><sub>Chatbot — Chat</sub></td>
    <td align="center"><img src="assets/screenshots/Chatbot_3.jpg" width="180"/><br/><sub>Chatbot — Response</sub></td>
    <td align="center"><img src="assets/screenshots/Chatbot_4.jpg" width="180"/><br/><sub>Chatbot — Extended</sub></td>
  </tr>
</table>

### 👤 Profile

<table>
  <tr>
    <td align="center"><img src="assets/screenshots/Profile _1.jpg" width="180"/><br/><sub>Profile Overview</sub></td>
    <td align="center"><img src="assets/screenshots/Profile_2.jpg" width="180"/><br/><sub>Profile — Posts</sub></td>
    <td align="center"><img src="assets/screenshots/Profile_3.jpg" width="180"/><br/><sub>Profile — Details</sub></td>
  </tr>
</table>

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles, organized into three layers:

```
lib/
├── core/                  # Shared utilities, DI, constants, routing
│   ├── constants/
│   ├── di/
│   ├── network/
│   ├── router/
│   └── widgets/
└── features/
    ├── auth/              # Authentication (login, register, OTP)
    ├── on_boarding/       # Onboarding screens
    ├── main/              # Main shell & bottom navigation
    ├── tabs/
    │   ├── home/          # Feed (posts & questions)
    │   ├── add_question_or_posts/ # Content creation
    │   ├── meetings/      # Meeting scheduling
    │   ├── chatbot/       # AI Chatbot
    │   └── profile/       # User profile
    ├── post_action/       # Post details, comments, replies
    ├── add_answer/        # Answer submission
    └── schedule_meeting/  # Meeting booking flow
```

Each feature is structured as:

```
feature/
├── data/
│   ├── datasources/
│   ├── mappers/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── cubit/
    ├── screens/
    └── widgets/
```

---

## 🛠️ Tech Stack

| Category | Package |
|---|---|
| **State Management** | `flutter_bloc` · `equatable` · `freezed` |
| **Navigation** | `go_router` |
| **Dependency Injection** | `get_it` · `injectable` |
| **Networking** | `dio` · `retrofit` |
| **Serialization** | `json_serializable` · `freezed_annotation` |
| **Local Storage** | `shared_preferences` · `flutter_secure_storage` |
| **UI & Animations** | `lottie` · `flutter_svg` · `cached_network_image` · `google_fonts` · `shimmer` |
| **Media** | `image_picker` · `file_picker` · `video_player` · `chewie` · `syncfusion_flutter_pdfviewer` |
| **Code Generation** | `build_runner` · `json_serializable` · `retrofit_generator` |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `^3.9.2`
- **Dart SDK** `^3.x`
- **Android Studio / VS Code**

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd explaino
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🤝 Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Branching strategy
- Conventional commits format
- Code style guide
- PR process

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  Made with ❤️ as a Graduation Project
</div>
