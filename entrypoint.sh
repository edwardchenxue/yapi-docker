#! /bin/sh
#cd ${HOME}

if [ ! -e "init.lock" ]
then
	#sed -i "s/3000/"${PORT}"/g" ${HOME}/config.json
	#sed -i "s/admin@admin.com/"${ADMIN_EMAIL}"/g" ${HOME}/config.json
	sed -i "s/127.0.0.1/"${DB_SERVER}"/g" /yapi/config.json
	sed -i '/test1/d' /yapi/config.json
        #sed -i "s/yapi/"${DB_NAME}"/g" ${HOME}/config.json
	#sed -i "s/27017/"${DB_PORT}"/g" ${HOME}/config.json
	echo 'begin to install server'
        echo 'sleep 20s'
        sleep 20
        npm run install-server
	touch init.lock
fi

node server/app.js
