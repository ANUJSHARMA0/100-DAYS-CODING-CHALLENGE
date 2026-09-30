# Contributing to Nova Calc

Thank you for your interest in contributing to Nova Calc! 🎉

## How to Contribute

### Reporting Bugs

1. Check existing [Issues](../../issues) to avoid duplicates.
2. Open a new issue with a clear title and description.
3. Include steps to reproduce, expected behavior, and actual behavior.
4. Add screenshots or screen recordings if applicable.
5. Mention your Flutter version (`flutter --version`) and platform.

### Suggesting Features

1. Open a new issue with the `enhancement` label.
2. Describe the feature, why it would be useful, and any design ideas.

### Submitting Pull Requests

1. **Fork** the repository and clone your fork.
2. Create a new branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes and ensure they follow the project conventions.
4. Run the analyzer and fix any issues:
   ```bash
   flutter analyze
   ```
5. Run existing tests:
   ```bash
   flutter test
   ```
6. Commit with a clear, descriptive message.
7. Push your branch and open a Pull Request against `main`.

## Code Style

- Follow the [Dart style guide](https://dart.dev/effective-dart/style).
- Use the lint rules defined in `analysis_options.yaml`.
- Keep widgets focused and single-responsibility.
- Add doc comments (`///`) to public classes and methods.
- Use the existing `AppColors` and `AppTypography` constants — avoid hardcoding colors or font styles.

## Project Structure

- **`lib/models/`** — Data classes and models.
- **`lib/screens/`** — UI screens (one file per screen).
- **`lib/services/`** — Business logic, engines, and data services.
- **`lib/theme/`** — Design tokens (colors, typography).

## Need Help?

Feel free to open an issue or start a discussion. We're happy to help!
