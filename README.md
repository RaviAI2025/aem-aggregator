# AEM Aggregator

Maven aggregator reactor that builds all AEM projects together.

## Submodules

| Module | Repo | Description |
|--------|------|-------------|
| aem-marketing | [RaviAI2025/aem-marketing](https://github.com/RaviAI2025/aem-marketing) | Marketing site |
| aem-advise | [RaviAI2025/aem-advise](https://github.com/RaviAI2025/aem-advise) | Advise site |
| aem-lifeportal | [RaviAI2025/aem-lifeportal](https://github.com/RaviAI2025/aem-lifeportal) | Lifeportal site |

## Clone (with all submodules)

```bash
git clone --recurse-submodules https://github.com/RaviAI2025/aem-aggregator.git
```

## Build All Projects

```bash
mvn clean install
```

## Build a Single Project

```bash
mvn clean install -pl aem-marketing -am
mvn clean install -pl aem-advise -am
mvn clean install -pl aem-lifeportal -am
```

## Auto-Sync Agent

When you push code to any source repo (marketing, advise, lifeportal), a GitHub Actions workflow automatically:
1. Sends a `repository_dispatch` event to this aggregator repo
2. The aggregator's `sync-submodules` workflow pulls the latest submodule reference
3. Commits and pushes the updated pointer

### Manual Sync

You can also trigger a sync manually:
- Go to **Actions > Sync Submodules > Run workflow** in this repo
- Or run locally: `./scripts/sync-all.sh`

## Setup Required

To enable automatic sync, add a **Personal Access Token** as a secret named `AGGREGATOR_PAT` to each source repo:
1. Create a PAT at https://github.com/settings/tokens with `repo` scope
2. Add it as a secret in each source repo: Settings > Secrets > Actions > `AGGREGATOR_PAT`
