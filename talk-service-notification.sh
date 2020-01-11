#!/bin/sh
if [ -n "$ICINGAWEB2_URL" ]; then
    HOSTDISPLAYNAME="<a href=\"$ICINGAWEB2_URL/monitoring/host/show?host=$HOSTNAME\">$HOSTDISPLAYNAME</a>"
    SERVICEDISPLAYNAME="<a href=\"$ICINGAWEB2_URL/monitoring/service/show?host=$HOSTNAME&service=$SERVICEDESC\">$SERVICEDISPLAYNAME</a>"
fi
template=$(cat <<TEMPLATE
<strong>$NOTIFICATIONTYPE</strong> $HOSTDISPLAYNAME - $SERVICEDISPLAYNAME is $SERVICESTATE

Address: $HOSTADDRESS
Date/Time: $LONGDATETIME

<pre>$SERVICEOUTPUT</pre>
TEMPLATE
)

if [ -n "$NOTIFICATIONCOMMENT" ]; then
  template="$template

Comment: ($NOTIFICATIONAUTHORNAME) $NOTIFICATIONCOMMENT
"
fi

curl -u "${TALK_USER}:${TALK_TOKEN}" -X POST "https://${TALK_HOST}/ocs/v2.php/apps/spreed/api/v1/chat/${TALK_CHAT_ID}" -H 'OCS-APIRequest: true' -d "{\"message\":\"$template\"}" -H 'Content-Type: application/json'
