#!/bin/bash
#Password reset script while by passing resetting username.

pwpolicy -u $3 -setpolicy "newPasswordRequired=1"
