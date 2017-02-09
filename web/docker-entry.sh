#!/bin/bash
echo Starting Nginx
sed -Ei "s/MATTERMOST_APP_PORT/$MATTERMOST_PORT_80_TCP_PORT/" /etc/nginx/sites-available/mattermost
sed -Ei "s/MATTERMOST_APP_PORT/$MATTERMOST_PORT_80_TCP_PORT/" /etc/nginx/sites-available/mattermost-ssl
sed -Ei "s/GITLAB_APP_PORT/$GITLAB_PORT_80_TCP_PORT/" /etc/nginx/sites-available/gitlab
sed -Ei "s/GITLAB_APP_PORT/$GITLAB_PORT_80_TCP_PORT/" /etc/nginx/sites-available/gitlab-ssl

if [ "$WEBSERVER_ENABLE_SSL" = true ]; then
    ssl="-ssl"
fi
ln -s /etc/nginx/sites-available/mattermost$ssl /etc/nginx/sites-enabled/mattermost
ln -s /etc/nginx/sites-available/gitlab$ssl /etc/nginx/sites-enabled/gitlab

nginx -g 'daemon off;'
