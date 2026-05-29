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

1. In the [yanka](https://github.com/Nambu14/yanka) repo, run the **Release** workflow and publish the release. The release must include **`yanka-<version>.tar.gz`** as a top-level asset (the workflow uploads it automatically).
2. Get the sdist SHA256 from the release asset (or run):

   ```bash
   curl -L "https://github.com/Nambu14/yanka/releases/download/v0.2.0/yanka-0.2.0.tar.gz" | shasum -a 256
   ```

3. In **this** repo, open **Actions → Update formula → Run workflow**.
4. Enter the version (no `v` prefix, e.g. `0.2.0`) and the sdist `sha256`.
5. The workflow opens a pull request with the updated `Formula/yanka.rb`. If PR creation is blocked, use the compare link from the workflow log. Approve and squash-merge the PR.

You can then install or upgrade locally:

```bash
brew update
brew upgrade yanka
```
