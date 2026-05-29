# homebrew-yanka

Homebrew tap for [yanka](https://github.com/Nambu14/yanka) — capture engineering decisions from conversation and retrieve them later.

## Install

```bash
brew tap Nambu14/yanka
brew install yanka
```

## How the tap works

The formula in `Formula/yanka.rb` downloads the **source distribution** (`yanka-<version>.tar.gz`) from [GitHub releases](https://github.com/Nambu14/yanka/releases) in the main yanka repo. Homebrew builds and installs the CLI from that tarball; bottles are not provided yet.

After you publish a new release in the main repo, update this tap manually (see below).

## Repo setup (one time)

In **Settings → Actions → General → Workflow permissions**, enable **Allow GitHub Actions to create and approve pull requests**. Without this, the update workflow can push the branch but cannot open the PR automatically.

## Update the formula after a release

1. In the [yanka](https://github.com/Nambu14/yanka) repo, run the **Release** workflow and **publish** the release. It must include **`yanka-<version>.tar.gz`** as a top-level asset.
2. In **this** repo, open **Actions → Update formula → Run workflow** and enter the version only (no `v` prefix, e.g. `0.3.0`).
3. The workflow downloads that release asset, computes the correct `sha256`, updates `Formula/yanka.rb`, and opens a pull request.
4. Approve and **squash-merge** the PR.

You can then install or upgrade locally:

```bash
brew update
brew upgrade yanka
```
