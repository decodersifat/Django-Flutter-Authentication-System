
````markdown
# Internship Assignment  
**Task:** Develop Login & Registration System  

## 🛠 Tech Stack

### Frontend
- **Framework:** Flutter  
- **Language:** Dart  
- **Local Storage:** Shared Preference (Android)  
  - Used to handle the onboarding state.

### Backend
- **Framework:** Django  
- **Language:** Python  

### Database
- **MySQL** (via Django ORM)  

---

## 🚀 Run the Project

### Backend Setup

#### 1️⃣ Prerequisites
- Make sure **Python** is installed.
- Install **MySQL** (Workbench optional):  
  - [MySQL Installer](https://dev.mysql.com/downloads/installer/)  
  - [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

#### 2️⃣ Clone the Repository
```bash
git clone https://github.com/decodersifat/Django-Flutter-Authentication-System.git
````

#### 3️⃣ Navigate to Backend Folder

```bash
cd backend
```

#### 4️⃣ Create a Virtual Environment

```bash
python -m venv venv
```

#### 5️⃣ Activate the Environment

```bash
venv\Scripts\activate   # For Windows
source venv/bin/activate # For Mac/Linux
```

#### 6️⃣ Install Dependencies

```bash
pip install -r requirements.txt
```

> If it fails, manually install dependencies from `requirements.txt`.

#### 7️⃣ Setup Database

* Configure MySQL server with:

  * **Port**
  * **Host**
  * **User**
  * **Password**
  * **Database Name**

* Create a `.env` file in the backend root directory with the following variables:

```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=your_db_name
```

#### 8️⃣ Run Backend

```bash
python manage.py runserver 0.0.0.0:8000
```

#### 9️⃣ API Endpoints

* **Login:** [http://127.0.0.1:8000/api/v1/auth/login/](http://127.0.0.1:8000/api/v1/auth/login/)
* **Register:** [http://127.0.0.1:8000/api/v1/auth/register/](http://127.0.0.1:8000/api/v1/auth/register/)

---

### Frontend Setup

#### 1️⃣ Install Flutter SDK

[Flutter Installation Guide (Windows)](https://docs.flutter.dev/get-started/install/windows/mobile)

#### 2️⃣ Open the Frontend Project

* Path: `frontend/inqbic`
* Open in your preferred IDE (e.g., VS Code, Android Studio).

#### 3️⃣ Install Dependencies

```bash
flutter pub get
```

#### 4️⃣ Run the App

Make sure the backend is running, then:

```bash
flutter run
```

---

## 📱 Features

* **Cross-platform Compatibility:** Android | iOS | Web

* **Onboarding Screens** (Shown once on Android & iOS)
  ![Onboarding Screen](https://dummyimage.com/600x400/000/fff\&text=Onboarding+Screen)

* **Login & Register Screens (Mobile)**
  ![Mobile Login](https://dummyimage.com/600x400/000/fff\&text=Mobile+Login)
  ![Mobile Register](https://dummyimage.com/600x400/000/fff\&text=Mobile+Register)

* **Login & Register Screens (Web)**
  ![Web Login](https://dummyimage.com/600x400/000/fff\&text=Web+Login)
  ![Web Register](https://dummyimage.com/600x400/000/fff\&text=Web+Register)

---

## 🔗 Important Links

* **GitHub Repo:** [https://github.com/decodersifat/Django-Flutter-Authentication-System](https://github.com/decodersifat/Django-Flutter-Authentication-System)
* **Demo Video (YouTube):** [https://youtu.be/I-fMTzBLftg?si=adkMW-MsWM4iHmqc](https://youtu.be/I-fMTzBLftg?si=adkMW-MsWM4iHmqc)

---

## 👤 Author

**MD. Sifat Hossain**

📞 Tel: +8801538386793

🔗 [LinkedIn](https://www.linkedin.com/in/decodersifat)

💻 [GitHub](https://github.com/decodersifat)


```

