## Contributing

- Find an issue in the [Issues Tab](https://github.com/SiroDevs/DroidconKeSwift/issues) and
  assign it to yourself. Feel free to create one if it doesn't exist.
- Fork the repository. This means that you will have a copy of the repository
  under `your-GitHub-username/repository-name`.
- Clone the repository to your local machine using git
  clone https://github.com/github-username/repository-name.git.
- Create a branch against main
- Create a PR to main. PullRequests must pass the following checks;
    * Must be approved by a code owner
    * Must pass all CI Checks
    * Must include updated tests
    * Must have every conversation resolved before merging
- We encourage you to
  use [git rebase](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase#:~:text=What%20is%20git%20rebase%3F,of%20a%20feature%20branching%20workflow.)
  for a linear history
- To ensure small PRs, Work on only one layer ie.
    * If you are working on the usecase;
        * Create the usecase, the repository and a repository implementation in the domain layer only
    * If you are working on the UI
        * Work on the UI and navigation if its an empty screen
        * Work on the Design and ViewModel if its UI implementation ticket
    * If you are working on the data layer work on the data layer only.

## Naming conventions

- All naming conventions to follow the already existing ones set by the code owner

## Coding Style

### DO

- ViewModel and view will fall under the feature's Ui package
- All Ui components will be under feature's components package
- Include tests if you are making changes to the following;
    - ViewModel
    - Repository
    - Mappers
- Include a preview for all UI components.
