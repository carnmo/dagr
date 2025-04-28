#include "net.h"

std::string net::download(std::string url, std::string github_token){
	CURL* curl = curl_easy_init();

	if(!curl){
		std::cerr << "Could not initialize curl." << std::endl;
		exit(1);
	}

	CURLcode response;
	std::string output;

	struct curl_slist* headers = NULL;
	headers = curl_slist_append(headers, "Accept: application/vnd.github+json");
	std::string auth_header = "Authorization: Bearer " + github_token;
	headers = curl_slist_append(headers, auth_header.c_str());

	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0);
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_USERAGENT, "dagr");
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &output);
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, net::write_data);

	response = curl_easy_perform(curl);

	if(response != CURLE_OK){
		std::cerr << "curl failed: " << curl_easy_strerror(response) << std::endl;
		curl_easy_cleanup(curl);
		return "";
	}

	curl_easy_cleanup(curl);
	return output;
}

size_t net::write_data(char *data, size_t size, size_t nmemb, void *userdata){
	std::string* buffer = (std::string*)userdata;
	buffer->append(data, size * nmemb);
	return size * nmemb;
}