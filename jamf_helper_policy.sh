#!/bin/bash
#This calls forth a JAMF Helper Policy to the end user for a pop-up window.
####################################################################################################
#
# HISTORY
#
# Version: 1.1
#
# - Extended from lisacherie @jamfnation https://jamfnation.jamfsoftware.com/viewProfile.html?userID=1143
# - Used in CCA
# - Updated by Rob Potvin email:rob.potvin@jamfsoftware.com
#
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

# HARDCODED VALUES SET HERE

customEventName=""                  # The custom event name used to trigger the policy
winHeading="Software Updates are Available."      # Custom text heading top of the window
winDescription="Would you like to install updates"    # Custom text heading in the window

# CHECK TO SEE IF A VALUE WERE PASSED IN FOR PARAMETERS $4, $5, $6 AND, IF SO, ASSIGN THEM

if [ "$4" != "" ] && [ "${customEventName}" == "" ]
then
    customEventName=$4
fi
if [ "$5" != "" ] && [ "${winHeading}" == "" ]
then
    winHeading=$5
fi
if [ "$6" != "" ] && [ "${winDescription}" == "" ]
then
    winDescription=$6
fi

####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################

if [ "${customEventName}" == "" ]
then
  >&2 echo "Error: The 'customEventName' parameter is blank. Please specify a custom event name."
  exit 1
fi

result=$(/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper \
-windowType utility \
-icon /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/Resources/Message.png \
-heading "${winHeading}" \
-description "${winDescription}" \
-button1 "Update" \
-button2 "Cancel" \
-cancelButton "2")

echo "jamfHelper returned value = ${result}"

if [ "${result}" == "0" ]
then
  >&2 echo "User clicked 'Update'. Installing Software Updates."
  /usr/local/jamf/bin/jamf policy -event "${customEventName}"
  exit
else
  >&2 echo "User clicked 'Cancel'. No Software Updates installed."
fi
