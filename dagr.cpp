#include "lib/nlohmann-json.hpp"
#include "lib/net.h"
#include <stdexcept>
#include <string>

int main(int argc, char* argv[]) {
	(void)argc;
	(void)argv;

	std::string github_org;
	std::string github_token;

	try{
		github_org = std::string(std::getenv("GITHUB_ORG"));
		github_token = std::string(std::getenv("GITHUB_TOKEN"));
	}catch(const std::exception& e){
		std::cerr << "Environment variable(s) GITHUB_ORG and/or GITHUB_TOKEN is not set or empty." << std::endl;
		return 1;
	}

	using json = nlohmann::json;
	unsigned int page = 1;
	bool result = true;

	while(result){
		std::string response = net::download("https://api.github.com/orgs/" + github_org + "/repos?page=" + std::to_string(page), github_token);

		try{
			auto repos = json::parse(response);

			if(repos.empty() || (repos.contains("status") && repos.at("status") != 401)){
				std::cout << "Bad credentials or no repos." << std::endl;
				result = false;
			}else{
				for(auto& repo : repos.items()){
					std::string repo_name = repo.value().at("name");
					std::cout << "Downloading " << repo_name << ".zip" << std::endl;
					std::string zip = net::download("https://api.github.com/repos/" + github_org + "/" + repo_name + "/zipball/", github_token);
					std::ofstream fs(repo_name + ".zip", std::ios::out | std::ios::binary);
					fs.write(zip.c_str(), zip.length());
					fs.close();
				}
			}
		}catch(const json::parse_error& e){
			std::cerr << "Error parsing JSON response: " << e.what() << std::endl;
			return 1;
		}

		page++;
	}

	return 0;
}
