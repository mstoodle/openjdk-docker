#!/bin/bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -o pipefail

source ./common_functions.sh

# Cleanup any old containers and images
cleanup_images

for ver in ${supported_versions}
do
	# Remove any temporary files
	rm -f hotspot_shasums_latest.sh openj9_shasums_latest.sh push_commands.sh manifest_commands.sh

	echo "==============================================================================="
	echo "                                                                               "
	echo "                    Testing Docker Images for Version ${ver}                   "
	echo "                                                                               "
	echo "==============================================================================="
	./test_multiarch.sh ${ver}

	err=$?
	if [ ${err} != 0 ]; then
		echo
		echo "ERROR: Docker test for version ${ver} failed."
		echo
		exit 1;
	fi
done
