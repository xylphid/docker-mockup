#!/bin/sh

set -e

# Initialize wine
wineboot

if [ -n "${LICENSENAME}" ] && [ -n "${LICENSEKEY}" ]; then
	echo -n "Set license ... "
	# echo "[${LICENSENAME}::${LICENSEKEY}]"
	wine "${HOME}/mockup/Balsamiq Mockups 3.exe" register "${LICENSENAME}" "${LICENSEKEY}"
	echo "done"
fi

wine "${HOME}/mockup/Balsamiq Mockups 3.exe"
# wine /opt/mockup/Balsamiq\ Mockups\ 3.exe register "Anthony PERIQUET" "eJzzzU/OLi0odswsqnHMK8nIz6tUCHAN8gwMdQ2pMTS2MDMyNTAyszSwMKtxrjEEAG7tDns="