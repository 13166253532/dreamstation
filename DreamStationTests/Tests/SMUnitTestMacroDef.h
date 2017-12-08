//
//  SMUnitTestMacroDef.h
//  MIFI360
//
//  Created by wei wu on 14-10-25.
//  Copyright (c) 2014年 qihoo360. All rights reserved.
//

#ifndef MIFI360_SMUnitTestMacroDef_h
#define MIFI360_SMUnitTestMacroDef_h

// Set the flag for a block completion handler
#define StartBlock() __block BOOL waitingForBlock = YES

// Set the flag to stop the loop
#define EndBlock() waitingForBlock = NO

// Wait and loop until flag is set
#define WaitUntilBlockCompletes() WaitWhile(waitingForBlock)

// Macro - Wait for condition to be NO/false in blocks and asynchronous calls
#define WaitWhile(condition) \
do { \
while(condition) { \
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]; \
} \
} while(0)


#endif
