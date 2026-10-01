---
name: Kinetic Obsidian
colors:
  surface: '#131315'
  surface-dim: '#131315'
  surface-bright: '#39393b'
  surface-container-lowest: '#0e0e10'
  surface-container-low: '#1c1b1d'
  surface-container: '#201f22'
  surface-container-high: '#2a2a2c'
  surface-container-highest: '#353437'
  on-surface: '#e5e1e4'
  on-surface-variant: '#c7c4d7'
  inverse-surface: '#e5e1e4'
  inverse-on-surface: '#313032'
  outline: '#908fa0'
  outline-variant: '#464554'
  surface-tint: '#c0c1ff'
  primary: '#c0c1ff'
  on-primary: '#1000a9'
  primary-container: '#8083ff'
  on-primary-container: '#0d0096'
  inverse-primary: '#494bd6'
  secondary: '#7bd0ff'
  on-secondary: '#00354a'
  secondary-container: '#00a6e0'
  on-secondary-container: '#00374d'
  tertiary: '#ffb2b7'
  on-tertiary: '#67001b'
  tertiary-container: '#ff516a'
  on-tertiary-container: '#5b0017'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e1e0ff'
  primary-fixed-dim: '#c0c1ff'
  on-primary-fixed: '#07006c'
  on-primary-fixed-variant: '#2f2ebe'
  secondary-fixed: '#c4e7ff'
  secondary-fixed-dim: '#7bd0ff'
  on-secondary-fixed: '#001e2c'
  on-secondary-fixed-variant: '#004c69'
  tertiary-fixed: '#ffdadb'
  tertiary-fixed-dim: '#ffb2b7'
  on-tertiary-fixed: '#40000d'
  on-tertiary-fixed-variant: '#92002a'
  background: '#131315'
  on-background: '#e5e1e4'
  surface-variant: '#353437'
typography:
  display-hero:
    fontFamily: Geist
    fontSize: 3.5rem
    fontWeight: '600'
    lineHeight: 3.75rem
    letterSpacing: -0.04em
  display-hero-mobile:
    fontFamily: Geist
    fontSize: 2.25rem
    fontWeight: '600'
    lineHeight: 2.5rem
    letterSpacing: -0.03em
  headline-lg:
    fontFamily: Geist
    fontSize: 2rem
    fontWeight: '600'
    lineHeight: 2.375rem
    letterSpacing: -0.03em
  headline-lg-mobile:
    fontFamily: Geist
    fontSize: 1.5rem
    fontWeight: '600'
    lineHeight: 1.875rem
    letterSpacing: -0.025em
  headline-sm:
    fontFamily: Geist
    fontSize: 1.25rem
    fontWeight: '500'
    lineHeight: 1.625rem
    letterSpacing: -0.02em
  body-lg:
    fontFamily: Geist
    fontSize: 1.0625rem
    fontWeight: '400'
    lineHeight: 1.625rem
    letterSpacing: -0.01em
  body-md:
    fontFamily: Geist
    fontSize: 0.9375rem
    fontWeight: '400'
    lineHeight: 1.5rem
    letterSpacing: -0.005em
  body-sm:
    fontFamily: Geist
    fontSize: 0.8125rem
    fontWeight: '400'
    lineHeight: 1.25rem
    letterSpacing: 0em
  label-mono-sm:
    fontFamily: JetBrains Mono
    fontSize: 0.75rem
    fontWeight: '500'
    lineHeight: 1rem
    letterSpacing: 0.02em
  label-mono-xs:
    fontFamily: JetBrains Mono
    fontSize: 0.6875rem
    fontWeight: '500'
    lineHeight: 0.875rem
    letterSpacing: 0.04em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-desktop: 1.5rem
  margin: 1rem
  margin-desktop: 3rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1.25rem
  space-xl: 2rem
---

## Brand & Style
The design system channels an intentional blend of high-efficiency utility and bespoke craftsmanship. It speaks to ambitious knowledge workers, designers, engineers, and digital minimalists who treat their workflow like an artisan’s workbench. The emotional resonance is calm velocity: frictionless capture, absolute clarity under cognitive load, and deliberate momentum without sensory fatigue.

The aesthetic fuses **Tactile Minimalism** with **Hyper-Refined Glassmorphism**. Drawing inspiration from elite productivity interfaces, the system avoids visual clutter and synthetic ornamentation. Depth is articulated through translucent backdrop blurs, whispering 1px hairline borders, muted monochrome foundations, and an authoritative electric indigo accent that acts as an optical beacon for active states and completion milestones.

## Colors
The palette is rooted in an ultra-deep, pure zinc slate architecture optimized for low-glare endurance during flow states. 

- **Primary Accent (`#6366F1`)**: Electric Indigo. Reserved strictly for primary call-to-actions, focused task states, progress indicators, and keyboard navigation rings.
- **Secondary Accent (`#38BDF8`)**: Radiant Cyan. Used for information streams, ambient indicators, and scheduled contexts.
- **Tertiary Accent (`#F43F5E`)**: Rose Coral. Dedicated to critical triage: urgent blockers, overdue dead-ends, and destructive confirmations.
- **Neutral Foundation (`#09090B`)**: Deep Obsidian Zinc. Backdrops, panels, and elevation steps utilize strict neutral tones (`#09090B` base canvas, `#18181B` surface tier, `#27272A` stroke and borders) to achieve high contrast with zero visual vibration.
- **Semantic Priority Hierarchy**: High Priority uses muted crimson wash with vibrant Rose text; Medium Priority utilizes an amber wash (`#F59E0B`); Low Priority employs a calm slate blue wash.

## Typography
Typography is engineered around extreme structural precision and scannability. **Geist** delivers a neutral, surgical typographic texture across all headers and task descriptions, ensuring that dense lists read cleanly without glyph collisions. 

For technical parameters, timestamps, keyboard commands, and progress tallies, **JetBrains Mono** provides deliberate mechanical rhythm. Tabular numbers (`tnum`) must be enforced across all progress indicators, timers, and counter badges to prevent UI jitter during real-time updates.

## Layout & Spacing
The layout system follows an adaptive, single-to-multi-column column fluid model based on an exact 4px sub-grid with an 8px macro rhythm.

- **Mobile (< 768px)**: Strict single-column stack with dynamic bottom safe-area insets. Task sheets and panels dock to the bottom with sheet pull affordances. Margin is pinned to `1rem` to maximize spatial efficiency.
- **Tablet & Compact (768px - 1024px)**: 2-column view with collapsible task meta drawer and fluid master list. Margin shifts to `1.5rem`.
- **Desktop (≥ 1024px)**: 3-column split view: persistent navigation tree (fixed 240px), center task execution feed (max 680px for optimal reading lines), and contextual inspector rail (320px).

Gaps between list items are compact (`space-xs` to `space-sm`) to encourage high information density, while workspace containers and sections employ generous breathing room (`space-lg` to `space-xl`) to isolate focus areas.

## Elevation & Depth
Depth is constructed through optical transparency, layering, and microscopic perimeter borders rather than harsh drop shadows:

- **Level 0 (Canvas Base)**: Flat `#09090B`. No elevation.
- **Level 1 (Stacked Panels & Cards)**: `#121215` at 85% opacity with `backdrop-filter: blur(16px)` and a uniform `1px` border stroke of `rgba(255, 255, 255, 0.08)`.
- **Level 2 (Active Floating Modals & Command Palettes)**: `#18181B` at 90% opacity, `backdrop-filter: blur(24px)`, combined with an ambient diffuse shadow (`0 20px 40px -15px rgba(0, 0, 0, 0.7)`) and a vibrant top-edge accent highlight (`1px` gradient border shifting from `rgba(99, 102, 241, 0.4)` to transparent).
- **Interactive Dragging States**: Active floating items gain a subtle scalar increase (`scale(1.02)`) and an inner glow (`box-shadow: inset 0 0 0 1px rgba(99, 102, 241, 0.5)`).

## Shapes
The shape philosophy champions oversized, organic radii for containment shells, contrasted with tactile capsule pills for micro-elements:

- **Primary Cards & Modals**: Utilize `rounded-2xl` (1rem) on mobile and `rounded-3xl` (1.5rem) on desktop to create a soft, inviting window aesthetic.
- **Input Fields & Rows**: Utilize `rounded-xl` (0.75rem) to balance ergonomics and nested visual hierarchy.
- **Badges, Chips, and Toggles**: Set to continuous full capsules (`rounded-full`) to provide high contrast against structural rectangular viewports.

## Components

### Buttons
- **Primary**: Solid Electric Indigo background (`#6366F1`), high-contrast pure white text, pill or `rounded-xl` shape, subtle inward top highlight (`inset 0 1px 0 rgba(255,255,255,0.2)`). Active state applies a tactile scale dip (`0.98`).
- **Secondary / Ghost**: Semi-transparent surface (`rgba(255, 255, 255, 0.04)`), `1px` stroke (`rgba(255, 255, 255, 0.08)`), hover transitions to `rgba(255, 255, 255, 0.08)`.

### Priority Chips & Micro-Badges
- Built using `JetBrains Mono` label tokens, encapsulated in full-pill geometry (`rounded-full`).
- **High**: Soft rose background (`rgba(244, 63, 94, 0.12)`), text `#FB7185`, dot indicator glowing coral.
- **Medium**: Soft amber background (`rgba(245, 158, 11, 0.12)`), text `#FBBF24`.
- **Low**: Slate wash (`rgba(148, 163, 184, 0.12)`), text `#94A3B8`.

### Task Checkboxes & Radios
- Tactile circular enclosures (`18px` diameter) with `1.5px` border (`#3F3F46`). 
- On hover, border illuminates with primary accent. On check, springs into filled `#6366F1` with an SVG micro-check snap animation.

### Task Rows & Lists
- Borderless by default, separated by an ultra-faint horizontal separator (`rgba(255, 255, 255, 0.04)`).
- Hover or focused row reveals a floating background wash (`rgba(255, 255, 255, 0.03)`) with a `rounded-xl` footprint.

### Input Fields & Command Palettes
- Flush zero-border inputs in inline creation states; framed inputs in settings panels using `rgba(255,255,255,0.06)` background and `1px` border (`rgba(255,255,255,0.1)`). Focus state transitions border to Electric Indigo with zero external ring blowout, maintaining minimal restraint.

### Sleek Progress Rings
- Circular SVG indicators featuring an ambient background track (`rgba(255, 255, 255, 0.06)`) and an active stroke driven by `#6366F1` transitioning to `#38BDF8`. Stroke cap is strictly rounded with animated dash offsets for completion transitions.