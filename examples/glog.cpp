#include <iostream>
#include <glog/logging.h>
int main() {
	LOG(INFO) << "<INFO> Hello World!";
	LOG(WARNING) << "<WARNING> Hello World!"; 
	LOG(ERROR) << "<ERROR>Hello World!"; 
	LOG(FATAL) << "<FATAL>Hello World!";
	return 0;
}