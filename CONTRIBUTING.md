# Contributing

- [Contributing](#contributing)
  - [Overview](#overview)
    - [Devcontainers](#devcontainers)
  - [Commit Message Conventions](#commit-message-conventions)
  - [Branch Naming Conventions](#branch-naming-conventions)
  - [Testing](#testing)
    - [Pre-commit hooks](#pre-commit-hooks)
    - [Continuous Integration and Continuous Delivery (CI/CD)](#continuous-integration-and-continuous-delivery-cicd)
  - [Formatting](#formatting)
  - [License](#license)

## Overview

**Thank you for considering contributing to this project!** If you’d like to help but can’t open a pull request, starring the repository is still a great way to support the project and help it reach more people. To improve the chances of your pull request being merged, please follow the guidelines in this document.

### Devcontainers

We use [Nix](https://nixos.org) for this project as it ensures that we are all using the same tools. Please make sure you have nix version 2.16.0 or higher and have the `nix-command` and `flakes` experimental options enabled.

If you don't have nix installed and can't install it for whatever reason then there is a [devcontainer](https://containers.dev/) you can use. When you enter a [devcontainer](https://containers.dev/) for the first time, it might take a while to pull the required image and set it all up. This will be a lot faster after the first initial setup. Look at the documentation for your IDE on how to work with devcontainers.

## Commit Message Conventions

All commit messages must follow the [conventional commit specification](https://www.conventionalcommits.org/en/v1.0.0/#specification). This is to autogenerate the changelog and keep commits constant. There are pre-commit checks to help you not push wrongly formed commits by mistake. Here is a list of allowed types:

- **feat**: For new features.
- **fix**: For bug fixes.
- **test**: For changes to tests.
- **docs**: For changes to the documentation.
- **deps**: For changes in dependencies.
- **ci**: For changes to the CI workflows.
- **refactor**: A code change that neither fixes a bug nor adds a feature.
- **perf**: A code change that improves performance.
- **style**: Changes that do not affect the meaning of the code (formatting).
- **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm).
- **chore**: Other changes that don't modify source or test files.
- **revert**: Reverts a previous commit.

## Branch Naming Conventions

Much like conventional commits we use conventional branch naming. This means that depending on what you're working on you should name your branch differently. For example:

- Name it `docs/*`, when working on documentation.
- Name it `feat/*`, when working on a feature.
- Name it `fix/*`, when working on a bug fix.
- Name it `deps/*`, when updating dependencies.

Where `*` describes your branch. So for example: `deps/update-xyz-from-v1.2.3-to-v4.5.6`. Make sure to use [kebab-case](https://developer.mozilla.org/en-US/docs/Glossary/Kebab_case).

These branch names will make it clear what your working on, and allows the [CI/CD](#continuous-integration-and-continuous-delivery-cicd) to label your PR better.

## Testing

Most of the tests done are performed automatically. The tests we use are [pre-commit hooks](#pre-commit-hooks) for the most immediate feedback and [CI/CD](#continuous-integration-and-continuous-delivery-cicd) ensures everything is good before we merge!

To test run locally:

```SH
nix flake check
```

This will test the entire repository, including building, testing, formatting etc. There might be a warning that the path is dirty, this means there are uncommitted changes, nothing to worry about.

### Pre-commit hooks

As mentioned before we use pre-commit hooks. These run on commit or on push, they allow you to make sure that you're not adding typos, broken symlinks, binaries, and a bunch of other things. These pre-commit hooks have to be 'installed' This happens when you enter a development shell using `nix develop`. This install needs to be done the first time you enter the repo, and every time `nix/config/pre-commit.nix` is changed.

So make sure to run:

```sh
nix develop 
```

You can make this easier by allowing [direnv](https://direnv.net/) to run.

### Continuous Integration and Continuous Delivery (CI/CD)

When interacting with this repository CI/CD will run to give you feedback, or help us out with some things. Only when all tests pass will we consider merging.

## Formatting

To format the files, run:

```SH
nix fmt
```

This will format all files or which there is a formatter installed. There might be warnings that no formatter is installed for some files. This is fine, you can safely ignore those warnings.

## License

By contributing, you agree that your contributions will be licensed under the same licence as the rest of the repository. See [LICENSE](./LICENSE) for more information and legal stuff.
