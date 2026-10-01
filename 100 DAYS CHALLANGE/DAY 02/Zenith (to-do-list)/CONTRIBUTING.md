# Contributing to Zenith

Thank you for your interest in contributing to Zenith! Every contribution makes this project better.

## 🛠️ Development Setup

1. **Fork & clone** the repository
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the dev server:
   ```bash
   npm run dev
   ```
4. Open `http://localhost:5173` in your browser

## 📋 Guidelines

### Code Style
- Use **TypeScript** for all source files
- Follow existing naming conventions (`PascalCase` for components, `camelCase` for utilities)
- Use CSS Modules for component styling (`.module.css`)
- Keep components focused and under ~200 lines where possible

### Commits
- Write clear, concise commit messages
- Use conventional commit prefixes: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`

### Pull Requests
1. Create a feature branch from `main`
2. Make your changes with clear, atomic commits
3. Ensure the app builds without errors: `npm run build`
4. Open a PR with a description of **what** changed and **why**

## 🐛 Reporting Issues

When opening an issue, please include:
- Steps to reproduce
- Expected vs actual behavior
- Browser & OS details
- Screenshots (if applicable)

## 📐 Architecture Notes

| Directory               | Purpose                                    |
| ----------------------- | ------------------------------------------ |
| `src/components/ui/`    | Reusable design-system primitives          |
| `src/components/layout/`| App shell, sidebar, and top bar            |
| `src/components/tasks/` | Task-specific UI (list items, modals, etc) |
| `src/components/shared/`| Cross-cutting components (settings, cmd palette) |
| `src/pages/`            | Top-level view screens                     |
| `src/stores/`           | Zustand state stores                       |
| `src/services/`         | Storage, notifications, seed data          |
| `src/types/`            | Shared TypeScript interfaces               |
| `src/utils/`            | Pure utility functions                     |
| `src/styles/`           | Global CSS & design tokens                 |

## 💡 Ideas Welcome

Have a feature idea? Open a **Discussion** or **Issue** — we'd love to hear it.

---

Thank you for contributing! 🚀
