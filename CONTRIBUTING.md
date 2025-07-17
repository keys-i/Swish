# Contributing to Swish

Thank you for your interest in contributing! Swish is an open-source macOS utility built with SwiftUI and native macOS APIs to allow screen and keyboard cleaning without accidental input.

We welcome issues, ideas, and pull requests. Please follow the guidelines below to help us maintain a consistent and high-quality codebase.

---

## Project Setup

### Requirements

- macOS 13 or later
- Xcode 15+
- Swift 5.9+
- Swift Package Manager (SPM) — no CocoaPods required

### Running the App

```bash
git clone https://github.com/your-username/Swish.git
cd Swish
open Swish.xcodeproj
````

Build and run via Xcode. The app is a menu bar utility.

---

## How to Contribute

### 1. Fork & Branch

* Fork this repo
* Create a feature branch:

  ```bash
  git checkout -b feature/your-feature-name
  ```

### 2. Make Your Changes

* Keep code clean and SwiftLint-friendly
* Prefer SwiftUI idioms and composability
* All new UI components should have `accessibilityIdentifier`s for testability

### 3. Test Your Code

* Run the app manually and verify behavior
* If relevant, write or update `XCTestCase` or `@Testable import Swish` logic

### 4. Commit Style

Use a **Facebook-style commit message**:

```
Swish/Keyboard: improve event tap filtering for Cmd+Q
```

Or for scaffolds:

```
Swish: scaffold input interception system
```

Use `git rebase -i` to squash and clean up history before submitting.

### 5. Open a Pull Request

* Use a clear title and description
* Reference any related issues
* Describe test coverage and limitations

---

## Code of Conduct

Please be respectful, constructive, and helpful in all interactions. We follow the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

---

## Want to Help?

Good areas to contribute:

* Fix bugs in keyboard blocking behavior
* Add accessibility and voiceover support
* Refine SwiftUI transitions and window management
* Improve automated tests (e.g. UI snapshot tests)

---

Thanks again for contributing — you're helping make Swish better for everyone!
– The Swish Team
