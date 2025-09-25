```markdown
# Job Post App

Flutter-based job posting platform with real-time updates using Supabase.

## 📱 Features

- User authentication (Sign up/Login)
- Create job postings
- Real-time job listings
- Responsive design (Web & Mobile)

## 🛠️ Tech Stack

- **Frontend:** Flutter 3.35.2
- **Backend:** Supabase (PostgreSQL + Realtime)
- **State Management:** BLoC/Cubit
- **Routing:** GoRouter
- **Dependency Injection:** GetIt + Injectable

## 📊 Database Schema

```sql
-- Users table (handled by Supabase Auth)

-- Jobs table
CREATE TABLE jobs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  posted_by_user UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  posted_by_display_name VARCHAR(255),
  description TEXT NOT NULL,
  location VARCHAR(255),
  employment_type VARCHAR(50),
  salary_min INTEGER,
  salary_max INTEGER,
  currency VARCHAR(10) DEFAULT 'USD',
  status VARCHAR(20) DEFAULT 'open',
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can view all jobs" ON jobs
  FOR SELECT USING (true);

CREATE POLICY "Users can create their own jobs" ON jobs
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own jobs" ON jobs
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own jobs" ON jobs
  FOR DELETE USING (auth.uid() = user_id);

-- Enable Realtime
ALTER PUBLICATION supabase_realtime ADD TABLE jobs;
```

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK 3.35.2
- Dart SDK Dart 3.9.0
- Android Studio / VS Code
- Supabase account

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/hasanboy1998/job_post_app.git
cd job_post_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Setup Supabase**
- Create a new project at [supabase.com](https://supabase.com)
- Run the SQL schema above in SQL Editor
- Copy your project URL and anon key
- Update in `main.dart`:
```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

5. **Run the app**
```bash
# For mobile
flutter run

# For web
flutter run -d chrome

# For release build
flutter build apk --release
flutter build web --release
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── errors/
│   ├── injection/
│   ├── router/
│   ├── services/
│   ├── theme/
│   ├── usecases/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── jobs/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## 🌐 Web Deployment

The app is deployed at: [https://job-post-1o7ctvvyn-hasanboys-projects-bdea888a.vercel.app]

### Local web build
```bash
flutter build web
cd build/web
python -m http.server 8000
# Visit http://localhost:8000
```

## 📱 Mobile APK

### Generate APK
```bash
flutter build apk --release
# APK location: build/app/outputs/flutter-apk/app-release.apk
```