# dagr

Download All Github Repositories for a Github organization as a zip file per repository.

## Acknowledgment

* dagr uses [JSON for Modern C++](https://github.com/nlohmann/json)

## Build requirements

* [make](https://www.gnu.org/software/make/)
* [libcurl](https://curl.se/libcurl/)

## Build

`make`

## Run

Export the following environment variables:
* GITHUB_ORG = your Github organization
* GITHUB_TOKEN = your [Fine-grained Personal Access Token](https://docs.github.com/en/rest/authentication/keeping-your-api-credentials-secure)

Execute

`./dagr`
