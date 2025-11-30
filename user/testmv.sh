#!/bin/sh

# 1. Cleanup old state
rm -rf src_root dst_root

# 2. Setup (Phase 1)
mkdir src_root
mkdir dst_root
touch src_root/file_A.txt
mkdir src_root/dir_1
touch src_root/dir_1/file_B.txt
mkdir src_root/dir_1/dir_2
touch src_root/dir_1/dir_2/file_C.txt

# 3. Execution (Phase 2 - Test 1)
echo "--- Testing Recursive Move ---"
mv src_root dst_root

# 4. Verification
if [ ! -d dst_root/src_root ]; then
    echo "Test FAILED: Destination folder not created."
    exit 1
fi
if [ -d src_root ]; then
    echo "Test FAILED: Source folder was not unlinked/deleted."
    exit 1
fi
if [ ! -f dst_root/src_root/dir_1/dir_2/file_C.txt ]; then
    echo "Test FAILED: Deeply nested file is missing."
    exit 1
fi

echo "ALL mv tests PASSED!"
