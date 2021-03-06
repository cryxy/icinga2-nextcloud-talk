#!/bin/sh
generate_post_data()
{
  cat <<EOF
{
  "message":"Notification Type: $NOTIFICATIONTYPE \n\nService: $SERVICEDISPLAYNAME \nState: $SERVICESTATE\nHost: $HOSTDISPLAYNAME \nAddress: $HOSTADDRESS \nDate: $LONGDATETIME \n\n$SERVICEOUTPUT \n\nComment ($NOTIFICATIONAUTHORNAME): $NOTIFICATIONCOMMENT"
}
EOF
}

curl -u "${TALK_USER}:${TALK_TOKEN}" -X POST "https://${TALK_HOST}/ocs/v2.php/apps/spreed/api/v1/chat/${TALK_CHAT_ID}" -H 'OCS-APIRequest: true' -H 'Content-Type: application/json' -d "$(generate_post_data)"
