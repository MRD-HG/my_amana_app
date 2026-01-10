# My Amana (Poste Maroc) — PFE Flutter App

This version runs **without Firebase**.

✅ Data source:
- **Static Moroccan demo data** in `assets/data/*.json` (agencies, shipments, offers, demo users).
- **User-generated data** (support tickets, feedback, contact messages, pre-shipments, facteur status updates) stored locally via **SharedPreferences**.

## Quick start

```bash
flutter pub get
flutter run
```

## Demo credentials (Facteur space)

- Email: `facteur.rabat@amana.ma`  Password: `123456`
- Email: `facteur.marrakech@amana.ma`  Password: `123456`
- Email: `facteur.tanger@amana.ma`  Password: `123456`

## Tracking demo codes

Try in the tracking screen:
- `AMNMA240001`
- `AMNMA240002`
- `AMNMA240003`
- `AMNMA240004`
- `AMNINT240005`

## Where to edit the local data

- Agencies: `assets/data/agencies_ma.json`
- Shipments + tracking timeline: `assets/data/shipments_ma.json`
- Offers/news: `assets/data/offers_ma.json`
- Demo users (facteur login): `assets/data/users_ma.json`

> Tip: if you change any JSON in `assets/data/`, do a full restart so Flutter reloads assets.
