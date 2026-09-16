/// All portfolio content lives here, so updating the site means editing
/// this file only.
library;

class Experience {
  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.highlights,
    this.location = 'Remote',
    this.project,
  });

  final String company;
  final String role;
  final String period;
  final String location;
  final String? project;
  final List<String> highlights;
}

class Project {
  const Project({
    required this.name,
    required this.summary,
    required this.highlights,
    required this.tech,
    this.githubUrl,
    this.demoUrl,
    this.storeUrl,
    this.screenshots = const [],
    this.isPlaceholder = false,
  });

  final String name;
  final String summary;
  final List<String> highlights;
  final List<String> tech;
  final String? githubUrl;
  final String? demoUrl;
  final String? storeUrl;

  /// Asset paths of phone screenshots, shown in order.
  final List<String> screenshots;

  /// Shows a "details coming soon" badge until real content is filled in.
  final bool isPlaceholder;
}

class SkillGroup {
  const SkillGroup(this.title, this.skills);

  final String title;
  final List<String> skills;
}

abstract final class PortfolioData {
  static const name = 'Mostafa Ramadan';
  static const role = 'Flutter Developer';
  static const location = 'Egypt · Remote';
  static const email = 'mostafaramadanhamed010@gmail.com';

  /// wa.me expects the number in international format without "+" or spaces.
  static const whatsAppUrl = 'https://wa.me/201097374644';
  static const linkedInUrl =
      'https://www.linkedin.com/in/mostafa-ramadan-hamed-b26177213/';
  static const githubUrl = 'https://github.com/mostafaramadanhamed';

  /// Served from web/Mostafa Ramadan CV.pdf.
  static const cvPath = 'Mostafa%20Ramadan%20CV.pdf';

  static const tagline =
      'I build fast, maintainable cross-platform apps with clean architecture, '
      'solid state management, and polished UI.';

  static const about = [
    "I'm a Flutter developer with a Computer Science degree, currently "
        'building production apps at Dinotik. I care about code that is easy '
        'to read, test, and scale — clean architecture, SOLID principles, and '
        'predictable state management with BLoC and Riverpod.',
    'I have shipped real-time chat, social, and productivity apps backed by '
        'Firebase, Supabase, and REST APIs, with features like deep linking, '
        'caching, offline storage, notifications, and payments.',
  ];

  static const focusAreas = [
    ('Clean Architecture', 'Layered, testable code that scales with the team.'),
    ('State Management', 'BLoC, Cubit, and Riverpod done predictably.'),
    (
      'Real-time Apps',
      'Chat, presence, and live updates with Firebase & Supabase.',
    ),
    ('Performance', 'Caching, local storage, and fewer network round-trips.'),
  ];

  static const experience = [
    Experience(
      company: 'Dinotik',
      role: 'Flutter Developer',
      period: 'Jun 2025 — Present',
      project: 'JobSite Inspector and Oplla',
      highlights: [
        'Applied clean code principles to improve maintainability and scalability.',
        'Integrated deep linking for seamless in-app navigation.',
        'Added data caching to improve performance and reduce API calls.',
        'Used debugging tools and structured logging to trace and resolve runtime issues.',
      ],
    ),
    Experience(
      company: 'Na3ml Hackathon',
      role: 'Intern Flutter Developer',
      period: 'Jul 2023 — Sep 2023',
      project: 'Deraya — teaching programming to children',
      highlights: [
        'Integrated Google Sign-In for a faster, simpler login flow.',
        "Engineered the app's state management using BLoC.",
        'Adapted the UI to multiple screen sizes.',
        'Stored user data locally for better offline access.',
      ],
    ),
  ];

  static const workProjects = [
    Project(
      name: 'JobSite Inspector',
      summary:
          'Field app for fire-safety technicians to run building inspections '
          'and sync results with the back office.',
      highlights: [
        'Inspection calendar, building and job site management, and QR/barcode scanning to find devices.',
        'Dynamic checklists for fire alarms, extinguishers, and wet systems, with photos, notes, and deficiency review.',
        'Offline-safe answers: every checklist response auto-saves to a Hive cache and restores on reopen.',
        'Encrypted JWE token decryption, captured signatures, FCM push notifications, and deep links.',
        'Performance pass: IndexedStack tabs, buildWhen, RepaintBoundary, and cached images for smoother lists.',
        'Separate development/staging flavors, Remote Config, and CI deploys to TestFlight and Firebase App Distribution with Fastlane.',
      ],
      tech: [
        'Flutter',
        'BLoC / Cubit',
        'Clean Architecture',
        'Dio',
        'Hive',
        'Firebase',
        'Fastlane',
      ],
    ),
    Project(
      name: 'Oplla — Client App',
      summary:
          'Marketplace app for renting media production equipment and '
          'booking crew such as camera operators, editors, and voice-over artists.',
      highlights: [
        'Search and filtering for equipment and crew, cart, and bookings with rescheduling and cancellation.',
        'Real-time chat over Socket.IO with typing indicators, read receipts, message edit/delete, and reconnect catch-up.',
        'Firebase phone OTP + JWT auth with a token-refresh interceptor that queues concurrent requests.',
        'In-app ads in a WebView with an event queue, frequency capping, and retry backoff.',
        'Multi-step rating flow, articles, subscription bundles, and Hive-based caching.',
        'Arabic/English with RTL layouts, deep links, push notifications, and Firebase Analytics.',
      ],
      tech: [
        'Flutter',
        'BLoC / Cubit',
        'Clean Architecture',
        'Dio',
        'Socket.IO',
        'Firebase',
        'Hive',
        'Localization',
      ],
    ),
    Project(
      name: 'Oplla — Provider App',
      summary:
          'Companion app for providers to manage their services, equipment '
          'listings, bookings, and earnings.',
      highlights: [
        'Dashboard with earnings and utilization charts, availability calendar, and withdrawal requests.',
        'Management of services, equipment listings, maintenance records, portfolio works, promo codes, and subscriptions.',
        'Shares an oplla_core package with the client app in a Melos monorepo — network, auth, theme, and analytics written once.',
        'CI gates for analysis, formatting, tests, and translation drift; deploys to TestFlight and Firebase App Distribution.',
      ],
      tech: [
        'Flutter',
        'Melos Monorepo',
        'BLoC / Cubit',
        'GetIt',
        'Firebase',
        'fl_chart',
        'GitHub Actions',
      ],
    ),
  ];

  // Private repos have no githubUrl.
  static const personalProjects = [
    Project(
      name: 'Halal',
      summary:
          'A Muslim companion app for prayer times, Quran, azkar, and the '
          'Hijri calendar, in Arabic and English.',
      highlights: [
        'Prayer times calculated on-device from GPS, with adhan alarms scheduled natively on Android (Kotlin).',
        'Full Quran with adjustable font sizes and surah bookmarks.',
        'Azkar categories with scheduled reminders, a digital tasbih that saves sessions, and a qibla compass.',
        'Hijri calendar with Islamic events, light/dark themes, and Arabic/English localization.',
        'Clean architecture with use cases, Cubits, and GetIt, plus unit tests.',
      ],
      tech: [
        'Flutter',
        'BLoC / Cubit',
        'Clean Architecture',
        'Kotlin',
        'Local Notifications',
        'Localization',
      ],
      screenshots: [
        'assets/projects/halal/1.jpg',
        'assets/projects/halal/2.jpg',
        'assets/projects/halal/3.jpg',
        'assets/projects/halal/4.jpg',
        'assets/projects/halal/5.jpg',
      ],
    ),
    Project(
      name: 'Ensure',
      summary: 'A full-featured social media app built on clean architecture.',
      highlights: [
        'Supabase auth, real-time chat, and live updates via subscriptions.',
        'Profiles, follow system, post interactions, and search.',
        'Responsive UI with dark mode and media uploads.',
      ],
      tech: ['Flutter', 'Supabase', 'BLoC', 'Clean Architecture'],
      githubUrl: 'https://github.com/mostafaramadanhamed/ensure',
      screenshots: [
        'assets/projects/ensure/1.jpg',
        'assets/projects/ensure/2.jpg',
        'assets/projects/ensure/3.jpg',
        'assets/projects/ensure/4.jpg',
        'assets/projects/ensure/5.jpg',
      ],
      // TODO: add the demo link.
    ),
    Project(
      name: 'Kidney Care',
      summary:
          'A health app that helps kidney patients track lab results, '
          'medicines, diet, and water intake. Built with a teammate.',
      highlights: [
        'Multi-step form for kidney lab indicators that leads to a guidance result screen.',
        'Medicine guide with usage, side effects, and doses, plus health advice articles.',
        'Kidney-friendly diet guide by food category and a daily water intake tracker.',
        'Doctor directory with clinic locations, and email or Google sign-in with Firebase.',
      ],
      tech: ['Flutter', 'Firebase Auth', 'Firestore', 'WebView'],
      screenshots: [
        'assets/projects/kidney_care/1.jpg',
        'assets/projects/kidney_care/2.jpg',
        'assets/projects/kidney_care/3.jpg',
        'assets/projects/kidney_care/4.jpg',
        'assets/projects/kidney_care/5.jpg',
        'assets/projects/kidney_care/6.jpg',
        'assets/projects/kidney_care/7.jpg',
      ],
    ),
    Project(
      name: 'WhatsApp Clone',
      summary: 'A real-time messaging app modeled on WhatsApp.',
      highlights: [
        'Phone number authentication and user profiles with contacts and avatars.',
        'Real-time 1-on-1 chat with text, images, GIFs, audio, video, and emojis.',
        'Online status, seen indicators, and auto-scroll for new messages.',
      ],
      tech: ['Flutter', 'Firebase', 'Riverpod'],
      githubUrl: 'https://github.com/mostafaramadanhamed/whatsapp',
      screenshots: [
        'assets/projects/whatsapp/1.jpg',
        'assets/projects/whatsapp/2.jpg',
        'assets/projects/whatsapp/3.jpg',
        'assets/projects/whatsapp/4.jpg',
      ],
    ),
    Project(
      name: 'Tiger VPN',
      summary: 'A free VPN client for Android with one-tap connect.',
      highlights: [
        'Connects through a native OpenVPN module bridged to Flutter.',
        'Fetches and parses the public VPN Gate server list (CSV) to pick countries.',
        'Live connection status, timer, and upload/download speeds.',
        'Settings, localization, and in-app rating and sharing.',
      ],
      tech: ['Flutter', 'Provider', 'OpenVPN', 'Hive', 'Localization'],
      screenshots: [
        'assets/projects/tiger_vpn/1.jpg',
        'assets/projects/tiger_vpn/2.jpg',
        'assets/projects/tiger_vpn/3.jpg',
        'assets/projects/tiger_vpn/4.jpg',
      ],
    ),
    Project(
      name: 'Task Ease',
      summary: 'A task manager with reminders, priorities, and daily progress.',
      highlights: [
        'Scheduled reminders with local notifications.',
        'Quick task entry, prioritization, and progress tracking.',
        'Fully offline with Hive storage.',
      ],
      tech: ['Flutter', 'Hive', 'Local Notifications', 'BLoC'],
      githubUrl: 'https://github.com/mostafaramadanhamed/Task-Ease-App',
    ),
  ];

  static const skills = [
    SkillGroup('Languages', ['Dart', 'C++']),
    SkillGroup('State Management', ['BLoC', 'Cubit', 'Riverpod']),
    SkillGroup('Flutter', [
      'Google Maps',
      'Payments',
      'Notifications',
      'Deep Linking',
      'Localization',
      'Lottie',
      'Async Programming',
    ]),
    SkillGroup('Data & Networking', [
      'REST APIs',
      'Dio',
      'Http',
      'JSON',
      'Hive',
      'SQflite',
      'Shared Preferences',
    ]),
    SkillGroup('Backend', [
      'Firebase Auth',
      'Firestore',
      'Realtime Database',
      'FCM',
      'Supabase',
    ]),
    SkillGroup('Engineering', [
      'Clean Architecture',
      'SOLID',
      'OOP',
      'Data Structures & Algorithms',
      'Git & GitHub',
      'GitHub Actions',
      'Fastlane',
    ]),
  ];

  static const degree = 'Bachelor of Computer Science';
  static const school = 'Misr Higher Institute of Commerce and Computers';
  static const educationPeriod = 'Sep 2020 — Jun 2024';
}
