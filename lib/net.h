#include <curl/curl.h>
#include <fstream>
#include <iostream>
#include <string>

class net{
	private:
		static size_t write_data(char*, size_t, size_t, void*);
	public:
		static std::string download(std::string, std::string);
};
