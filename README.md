# Lossless Music Player 🎵

A high-fidelity offline music player built with Flutter, designed to handle local audio files with a focus on FLAC/Lossless playback and organized library management.

> **⚠️ Note:** This is a legacy project created during my early days of learning Flutter. The file structure and code quality reflect a learning curve and may not follow current best practices or clean architecture patterns. It is archived here for portfolio and demonstration purposes.

## 📱 App Preview

### 🎥 Live Demo
<p align="center">
  <a href="https://youtu.be/_JXjAi11lCk?si=pbnxb6mFdawykuVt">
    <img src="https://github.com/user-attachments/assets/11fedd33-c6c8-42ca-b6b8-f6fe9f29b05a" width="600">
  </a>
</p>

## 📸 Screenshots

| Library Access & Source Management | Music Discovery & Library | Music Player & Queue Management |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/72507212-6b01-4754-b032-7f095aeccf44" width="300"> | <img src="https://github.com/user-attachments/assets/70acbaef-704b-4060-b835-f9ab2c5ad770" width="300"> | <img src="https://github.com/user-attachments/assets/3887e8a7-2b9b-477d-99e8-0689049f4594" width="300"> |

| Artist & Album Library | Folder-Based Library |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/5e8fdada-5d15-456c-9227-f55f56c7ceb2" width="300"> | <img src="https://github.com/user-attachments/assets/697a45e0-7bf7-47b7-85df-8205656089a3" width="300"> |


---

## ✨ Features

### 1. 📂 Specific Folder Selection
Unlike standard players that scan your entire phone, this app gives you control. You can select specific folders from your storage to include in your library, keeping your music organized and excluding unwanted audio files (like WhatsApp voice notes).

### 2. 🏠 dynamic Home Page
The home screen is divided into two intuitive sections:
* **Visual Grid:** A beautiful GridView displaying Album/Song Artworks for quick access.
* **Detailed List:** A full scrollable list of songs containing metadata (Artist, Duration, Format) and a clear "Hi-Res" badge for lossless files.

### 3. 👤 Smart Artist Grouping
A hierarchical view for browsing your collection:
* **Parent Tile:** Displays the Artist's cover art, total album count, and total song count.
* **Child Tile:** Expands to show the specific Albums and the songs within them.

### 4. 📁 Folder Browser
Browse your music by the physical folder structure on your device. Each folder card displays:
* Generated Artwork based on the music inside.
* The full storage path.
* Total track count within that folder.

### 5. 🎧 Full-Featured Player
A complete playback interface featuring:
* **HD Artwork:** Renders full-quality embedded album art.
* **Playback Controls:** Play, Pause, Next, Previous.
* **Queue Management:** Shuffle and Repeat (Repeat One / Repeat All) modes.
* **Seek Bar:** Real-time progress slider.

---

## 🛠️ Built With

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [GetX](https://pub.dev/packages/get)
* **Audio Engine:** [just_audio](https://pub.dev/packages/just_audio)
* **Metadata Query:** [on_audio_query](https://pub.dev/packages/on_audio_query)
* **Permissions:** [permission_handler](https://pub.dev/packages/permission_handler)

## 📥 Installation

1.  Clone the repo:
    ```bash
    git clone https://github.com/ALjavir/lossless-music-player.git
    ```
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the app:
    ```bash
    flutter run
    ```

---
## 📬 Contact

**Al Javir** - Flutter Developer
* 📧 [flutter.x.tonmoy@gmail.com](mailto:flutter.x.tonmoy@gmail.com)
* 🔗 [GitHub Profile](https://github.com/ALjavir)

  
## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
