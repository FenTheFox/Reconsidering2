//
//  main.h
//  tmp
//
//  Created by Timm Allman on 9/26/14.
//  Copyright (c) 2014 UMass. All rights reserved.
//

#ifndef tmp_main_h
#define tmp_main_h

#include <fstream>
#include <iostream>
#include <list>
#include <mutex>
#include <sstream>
#include <string>
#include <thread>
#include <vector>

#include <string.h>

#include <sys/times.h>
#include <sys/mman.h>

#include "sqlite3.h"

#include "stringops.h"

int checkErr(int err, int line, sqlite3 *db=NULL, std::string extra="");
timer runScriptFile(sqlite3* db, char* fname, int idx);
timer runScriptFile(sqlite3 *db, std::ifstream &script, int idx);
timer runScriptFile(sqlite3 *db, sqlite3_stmt *pstmt, std::ifstream &input, int num, std::string type, int idx);
void runThread(std::string fname, std::string dbfile, int idx);

#endif
