# Mostafa Ramadan — Portfolio

Personal portfolio built with Flutter Web.

## Editing content

All text, links, projects, and skills live in `lib/data/portfolio_data.dart`.
The downloadable CV is served from `web/Mostafa Ramadan CV.pdf`.

## Run locally

```sh
flutter pub get
flutter run -d chrome
```

## Deploy

Pushing to `main` builds and deploys to GitHub Pages via
`.github/workflows/deploy.yml`. In the repo settings, set
**Pages → Source** to **GitHub Actions**.
