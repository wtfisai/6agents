# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Package Management
This project uses **PNPM** as the package manager in a Turborepo monorepo setup.

- Install dependencies: `pnpm install`
- Install global PNPM: `npm i -g pnpm` (if needed)

### Development Servers
- Start web app: `pnpm dev:web` (runs on port 3000)
- Start API server: `pnpm dev:api` (runs on port 3001)

### Build & Quality
- Build all workspaces: `pnpm build` (uses Turbo pipeline)
- Lint all workspaces: `pnpm lint` (uses Turbo pipeline) 
- Test all workspaces: `pnpm test` (uses Turbo pipeline)
- Setup environment: `pnpm setup` (runs `scripts/setup.sh`)

### Individual Workspace Commands
Use `pnpm --filter <workspace>` to target specific packages:
- `pnpm --filter @designsync/web <command>`
- `pnpm --filter @designsync/api <command>`

## Architecture Overview

### Monorepo Structure
```
apps/
├── web/          # Next.js frontend (@designsync/web)
└── api/          # Express.js backend (@designsync/api)

packages/
├── ui-components/     # Shared React components
├── design-tokens/     # Design system tokens
└── sync-protocol/     # Figma sync logic
```

### Core Technology Stack
- **Frontend**: Next.js 14+ with React 18, TypeScript
- **Backend**: Express.js with TypeScript (ES modules)
- **Build System**: Turborepo for monorepo orchestration
- **Package Manager**: PNPM with workspaces
- **Deployment**: Firebase (see firebase.json)

### Key Integrations
- **Figma API**: For design system sync
- **Google AI/Gemini**: For AI-powered design generation
- **Firebase**: Authentication, database, hosting
- **Stripe**: Payment processing

## Environment Setup

1. Copy `.env.example` to `.env` and configure required values
2. Key environment variables include:
   - Firebase configuration (auth, database)
   - Google AI API keys for Gemini integration
   - Figma API credentials
   - Stripe payment keys
   - Database and Redis URLs

## Development Workflow

### Adding New Features
- Features are organized by domain in `apps/web/src/features/`
- Shared components go in `packages/ui-components/`
- Backend logic in `apps/api/src/`

### Working with Workspaces
- Each app/package has its own `package.json` with workspace-specific scripts
- Use Turbo's dependency-aware builds and caching
- Shared packages are automatically linked across workspaces

### API Development
- API server runs as ES modules (`"type": "module"`)
- Uses `ts-node-dev` for hot reloading during development
- Builds to `dist/` directory for production

## Important Files

- `turbo.json`: Defines build pipeline and caching strategy
- `implement.md`: Detailed implementation roadmap and architecture
- `scripts/setup.sh`: Automated environment setup
- `firebase.json`: Firebase deployment configuration
- `.env.example`: Complete environment variable reference

## Testing Strategy

- Uses Vitest for testing (configured in Turbo pipeline)
- Test outputs go to `coverage/` directories
- Run tests across all workspaces with `pnpm test`

## Deployment

- CI/CD configured via GitHub Actions (`.github/workflows/`)
- Firebase hosting and functions deployment
- Automatic builds trigger on main branch changes