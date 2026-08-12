# BazaarBridge — Setup Guide (Android Studio)

Yeh zip sirf `lib/` code aur `pubspec.yaml` deta hai — native `android/` `ios/`
folders isme jaan boojh kar shamil NAHI kiye, kyunke woh aapke local Flutter
SDK version ke mutabiq generate hone chahiye (warna corrupt ho sakte hain).

## 3 Steps:

1. Terminal mein ek naya empty Flutter project banayein:
   flutter create bazaarbridge

2. Us naye project ke `lib/` folder aur `pubspec.yaml` ko DELETE kar ke,
   is zip wale `lib/` folder aur `pubspec.yaml` se REPLACE kar dein.

3. Terminal mein:
   cd bazaarbridge
   flutter pub get

Ab Android Studio mein `bazaarbridge` folder open karein (File > Open) —
sab kuch (android/ios/lib/pubspec) automatically ready milega, kuch missing
nahi hoga.
