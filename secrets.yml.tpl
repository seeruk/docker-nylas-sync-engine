---
GOOGLE_OAUTH_CLIENT_ID: 986659776516-fg79mqbkbktf5ku10c215vdij918ra0a.apps.googleusercontent.com
GOOGLE_OAUTH_CLIENT_SECRET: zgY9wgwML0kmQ6mmYHYJE05d
MS_LIVE_OAUTH_CLIENT_ID: 0000000048157D75
MS_LIVE_OAUTH_CLIENT_SECRET: W69jkmY8Lp1CbRqn-H7TtRXLDLU7XBxb
# Hexl-encoded static keys used to encrypt blocks in S3, secrets in database:
BLOCK_ENCRYPTION_KEY: 43933ee4aff59913b7cd7204d87ee18cd5d0faea4df296cb7863f9f28525f7cd
SECRET_ENCRYPTION_KEY: 5f2356f7e2dfc4ccc93458d27147f97b954a56cc0554273cb6fee070cbadd050
CONTACTS_SEARCH:
    SENTRY_DSN: ""

DATABASE_USERS:
  "${MYSQL_HOST}":
    USER: ${MYSQL_USER}
    PASSWORD: ${MYSQL_PASS}
