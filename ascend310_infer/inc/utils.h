

#ifndef MINDSPORE_INFERENCE_UTILS_H_
#define MINDSPORE_INFERENCE_UTILS_H_

#include <sys/stat.h>
#include <dirent.h>
#include <vector>
#include <string>
#include <memory>
#include <fstream>
#include "include/api/types.h"

using mindspore::MSTensor;

std::vector<std::string> GetAllFiles(std::string_view dirName);
DIR *OpenDir(std::string_view dirName);
std::string RealPath(std::string_view path);
mindspore::MSTensor ReadFileToTensor(const std::string &file);
int WriteResult(const std::string& imageFile, const std::vector<MSTensor> &outputs,
                const std::string & dataset_name, const std::string& seq);
std::vector<std::string> GetAlldir(const std::string& dir_name, const std::string_view& data_name);
#endif
