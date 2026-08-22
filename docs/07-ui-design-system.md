# Knowledge Dynamics — UI Design System

## Color Palette

### Primary
- **Navy** `#0F2A4A` — Primary brand, headers, navigation
- **Academic Blue** `#1E4D8C` — Links, buttons, accents
- **Light Blue** `#3B82F6` — Interactive states, highlights

### Neutral
- **White** `#FFFFFF` — Page backgrounds
- **Gray 50** `#F8FAFC` — Section backgrounds, cards
- **Gray 100** `#F1F5F9` — Borders, dividers
- **Gray 200** `#E2E8F0` — Input borders
- **Gray 400** `#94A3B8` — Placeholder text
- **Gray 500** `#64748B` — Secondary text
- **Gray 700** `#334155` — Body text
- **Gray 900** `#0F172A` — Headings

### Semantic
- **Success** `#059669` — Published, accepted, completed
- **Warning** `#D97706` — Revision required, pending
- **Danger** `#DC2626` — Rejected, errors, destructive
- **Info** `#0284C7` — Informational badges

### Open Access
- **OA Orange** `#F59E0B` — Open Access indicator badge

## Typography

### Font Stack
- **Headings**: `Inter`, system-ui fallback
- **Body**: `Inter`, system-ui fallback
- **Monospace**: `JetBrains Mono`, monospace

### Scale
| Name | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| Display | 2.25rem (36px) | 700 | 1.2 | Hero headings |
| H1 | 1.875rem (30px) | 700 | 1.3 | Page titles |
| H2 | 1.5rem (24px) | 600 | 1.35 | Section headings |
| H3 | 1.25rem (20px) | 600 | 1.4 | Card titles |
| H4 | 1.125rem (18px) | 600 | 1.4 | Sub-sections |
| Body | 1rem (16px) | 400 | 1.6 | Body text |
| Small | 0.875rem (14px) | 400 | 1.5 | Metadata, captions |
| XS | 0.75rem (12px) | 500 | 1.4 | Badges, labels |

## Spacing Scale
4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96, 128px

## Border Radius
- **None**: 0 — Tables, editorial elements
- **SM**: 4px — Badges, small elements
- **Base**: 6px — Buttons, inputs
- **MD**: 8px — Cards
- **LG**: 12px — Modals, panels

## Shadows
- **SM**: `0 1px 2px rgba(0,0,0,0.05)` — Subtle elevation
- **Base**: `0 1px 3px rgba(0,0,0,0.1)` — Cards
- **MD**: `0 4px 6px rgba(0,0,0,0.07)` — Dropdowns
- **LG**: `0 10px 15px rgba(0,0,0,0.1)` — Modals

## Components

### Buttons
- **Primary**: Navy bg, white text, hover darkens
- **Secondary**: White bg, navy border, navy text
- **Ghost**: Transparent, navy text, hover bg-gray-50
- **Danger**: Red bg for destructive actions
- **Sizes**: sm (32px), md (40px), lg (48px)

### Inputs
- Border: gray-200, focus: academic-blue ring
- Height: 40px (md), 48px (lg)
- Error state: red border + error message below

### Cards
- White bg, subtle border, 8px radius
- Hover: slight shadow elevation
- No excessive rounded corners

### Badges
- Open Access: orange bg
- Status: color-coded (published=green, review=blue, rejected=red)
- Article type: subtle gray bg

### Navigation
- Desktop: Sticky, white bg, navy text, bottom border
- Mobile: Bottom navigation bar (Home, Journals, Search, Research, Profile)

### Tables
- Striped rows, sticky header on scroll
- Responsive: horizontal scroll or card-based on mobile

### Modals
- Centered overlay, white bg, 12px radius
- Slide-up on mobile, fade-in on desktop

### Empty States
- Centered illustration placeholder
- Clear heading + description
- Action button where applicable

### Loading States
- Skeleton: gray-100 pulsing blocks matching content shape
- Spinner: for inline actions only

## Responsive Breakpoints
| Name | Width | Usage |
|---|---|---|
| xs | 320px | Small phones |
| sm | 375px | Standard phones |
| md | 768px | Tablets |
| lg | 1024px | Small desktops |
| xl | 1280px | Standard desktops |
| 2xl | 1440px+ | Large desktops |
