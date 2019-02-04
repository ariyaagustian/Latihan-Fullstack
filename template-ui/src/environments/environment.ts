// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.

export const environment = {
  production: false,
  clientId: 'itime',
  clientSecret: 123456,
  authUri: '/security-management/oauth/token',
  checkToken: '/security-management/oauth/check_token',
  securityUri: '/security-management/api',
  securityMenu: '/security-management/menu',
  authLogout: '/security-management/security',
  supportDeviceApi: '/supporting-device/api',
  remysUri: '/web-application-face/service',
  alfrescoUri: '/alfresco',
  basePath: '/',
  siteUrl: '',
  remysUrlDeploy: 'http://10.243.131.46'
};
