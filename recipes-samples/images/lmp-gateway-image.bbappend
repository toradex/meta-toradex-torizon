DESCRIPTION = "TordyOS image featuring OTA and container capabilities"
SUMMARY = "Basic TordyOS console image, based on Linux microPlatform gateway image."
PV = "0.1"

EXTRA_USERS_PARAMS = "\
useradd -P tordy tordy; \
usermod -a -G sudo,users,plugdev tordy; \
usermod -a -G docker tordy; \
"
