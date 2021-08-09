#!/bin/bash

echo "rg: ${RG_NAME} gateway: ${APPLICATION_GATEWAY_NAME} name: ${NAME}"

case "${RESOURCE}" in
    BACKENDPOOL)       
        servers=$([ -z "${ADDRESS_POOL}" ] && echo "" || echo "--servers ${ADDRESS_POOL} ")
        
        az network application-gateway address-pool create -g ${RG_NAME} \
            --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} ${servers}
        ;;
    HTTPSETTINGS)
        protocol=$([ -z "${PROTOCOL}" ] && echo "" || echo "--protocol ${PROTOCOL} ")
        cba=$([ -z "${COOKIE_BASED_AFFINITY}" ] && echo "" || echo "--cookie-based-affinity ${COOKIE_BASED_AFFINITY} ")
        timeout=$([ -z "${TIMEOUT}" ] && echo "" || echo "--timeout ${TIMEOUT} ")
        affinitycookiename =$([ -z "${AFFINITY_COOKIE_NAME}" ] && echo "" || echo "--affinity-cookie-name ${AFFINITY_COOKIE_NAME} ")
        authcerts=$([ -z "${AUTH_CERTS}" ] && echo "" || echo "--auth-certs ${AUTH_CERTS} ")
        connectiondrainingtimeout=$([ -z "${CONNECTION_DRAINING_TIMEOUT}" ] && echo "" || echo "--connection-draining-timeout ${CONNECTION_DRAINING_TIMEOUT} ")
        enableprobe=$([ -z "${ENABLE_PROBE}" ] && echo "" || echo "--enable-probe ${ENABLE_PROBE} ")
        hostname=$([ -z "${HOST_NAME}" ] && echo "" || echo "--host-name ${HOST_NAME} ")
        hostnamefrombackendpool=$([ -z "${HOST_NAME_FROM_BACKEND_POOL}" ] && echo "" || echo "--host-name-from-backend-pool ${HOST_NAME_FROM_BACKEND_POOL} ")
        path=$([ -z "${PATH}" ] && echo "" || echo "--path ${PATH} ")
        probe=$([ -z "${PROBE}" ] && echo "" || echo "--probe ${PROBE} ")
        rootcerts=$([ -z "${ROOT_CERTS}" ] && echo "" || echo "--root-certs ${ROOT_CERTS} ")

        az network application-gateway http-settings create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} -n ${NAME} --port ${PORT} \
        ${protocol}${cba}${timeout}${affinitycookiename}${authcerts}${connectiondrainingtimeout}${enableprobe}${hostname}${hostnamefrombackendpool}${path}${probe}${rootcerts}
        ;;
    HTTPLISTENER)
        frontendip=$([ -z "${PUBLIC_IP}" ] && echo "" || echo "--frontend-ip ${PUBLIC_IP} ")
        hostname=$([ -z "${HOST_NAME}" ] && echo "" || echo "--host-name ${HOST_NAME} ")
        hostnames=$([ -z "${HOST_NAMES}" ] && echo "" || echo "--host-names ${HOST_NAMES} ")
        sslcert=$([ -z "${SSL_CERT}" ] && echo "" || echo "--ssl-cert ${SSL_CERT} ")
        wafpolicy=$([ -z "${WAF_POLICY}" ] && echo "" || echo "--waf-policy ${WAF_POLICY} ")

        az network application-gateway http-listener create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
        -n ${NAME} --frontend-port ${PORT} ${frontendip}${hostname}${hostnames}${sslcert}${wafpolicy}
        ;;
    REQUESTROUTINGRULE)
        listener=$([ -z "${LISTENER}" ] && echo "" || echo "--http-listener ${LISTENER} ")
        addresspool=$([ -z "${ADDRESS_POOL}" ] && echo "" || echo "--address-pool ${ADDRESS_POOL} ")
        httpsettings=$([ -z "${HTTP_SETTINGS}" ] && echo "" || echo "--http-settings ${HTTP_SETTINGS} ")
        priority=$([ -z "${PRIORITY}" ] && echo "" || echo "--priority ${PRIORITY} ")
        redirectconfig=$([ -z "${REDIRECT_CONFIG}" ] && echo "" || echo "--redirect-config ${REDIRECT_CONFIG} ")
        rewriteruleset=$([ -z "${REWRITE_RULE_SET}" ] && echo "" || echo "--rewrite-rule-set ${REWRITE_RULE_SET} ")
        ruletype=$([ -z "${RULE_TYPE}" ] && echo "" || echo "--rule-type ${RULE_TYPE} ")
        urlpathmap=$([ -z "${URL_PATH_MAP}" ] && echo "" || echo "--url-path-map ${URL_PATH_MAP} ")

        az network application-gateway rule create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
        -n ${NAME} ${listener}${addresspool}${httpsettings}${priority}${redirectconfig}${rewriteruleset}${ruletype}${urlpathmap}
        ;;
    SSLCERT)
        certfile=$([ -z "${CERT_FILE}" ] && echo "" || echo "--cert-file ${CERT_FILE} ")
        certpassword=$([ -z "${CERT_PASSWORD}" ] && echo "" || echo "--cert-password ${CERT_PASSWORD} ")
        keyvaultsecretid=$([ -z "${KEY_VAULT_SECRET_ID}" ] && echo "" || echo "--key-vault-secret-id ${KEY_VAULT_SECRET_ID} ")
        
        az network application-gateway ssl-cert create -g ${RG_NAME} --gateway-name ${APPLICATION_GATEWAY_NAME} \
        -n ${NAME} ${certfile}${certpassword}${keyvaultsecretid}
        ;;
esac