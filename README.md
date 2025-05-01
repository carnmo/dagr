# dagr

Download all Github repositories from a Github organization as a zip file per repository.

![By Brenda Clarke - Knife 3Uploaded by Partyzan_XXI, CC BY 2.0, https://commons.wikimedia.org/w/index.php?curid=8365509](https://github.com/carnmo/dagr/blob/main/dagr.png) 

## Acknowledgments

* Includes [JSON for Modern C++](https://github.com/nlohmann/json)
* Includes dynamically linked [libcurl](https://curl.haxx.se/) on Windows or statically linked on Linux.
* Dagger image by Brenda Clarke under Creative Commons Attribution 2.0

## Build requirements

* [gcc](https://gcc.gnu.org/)
* [make](https://www.gnu.org/software/make/)

## Build

`make`

## Run

1. Export the following environment variables:
	* GITHUB_ORG = Organization name 
	* GITHUB_TOKEN = [Fine-grained Personal Access Token](https://docs.github.com/en/rest/authentication/keeping-your-api-credentials-secure) configured with relevant read access.
2. Execute `dagr.exe`

Repositories will be downloaded to the current directory.

## Notes

* Built and tested with [mingw-w64](https://www.mingw-w64.org/) on Windows 11 24H2 and Kubuntu 25.04, Arch Linux.
